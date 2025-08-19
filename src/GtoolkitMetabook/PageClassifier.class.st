"
I am a page classifier that classifies lepiter pages using a generative AI chat with a given prompt.
The classification could be into topics (such as EDD orMoldable Development) or it could be into the type of page (exercise, use case, tutorial etc).
"
Class {
	#name : #PageClassifier,
	#superclass : #AbstractPCChatGroup,
	#instVars : [
		'prompt',
		'announcer',
		'chats',
		'resultType',
		'jsonFile',
		'definingMethod'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #'instance creation' }
PageClassifier class >> fromJsonFilePath: aFilePath [
	^ self
		newFromJson: (STONJSON fromString: (FileLocator gtResource / aFilePath) contents)
]

{ #category : #'instance creation' }
PageClassifier class >> newFromJson: json [
	^ self new
		initializeFromJson: json;
		initializeResultsFromJson: json;
		yourself
]

{ #category : #updating }
PageClassifier >> addPages: aLePageCollection [
	"NB: Only add chats for pages not already represented."

	| newChats |
	newChats := OrderedCollection new.
	aLePageCollection
		do: [ :page | 
			(self blackList includes: page title)
				ifFalse: [ self chats
						detect: [ :c | c page = page ]
						ifNone: [ | newChat |
							newChat := self chatForPage: page.
							newChats addLast: newChat.
							self chats addLast: newChat ] ] ].
	self notifyResultsUpdated.
	^ newChats
]

{ #category : #accessing }
PageClassifier >> addRandomPages: aNumber [
	"Add a number of random pages from the database."

	| available picked pick |
	self assert: aNumber > 0.
	available := self database pages difference: self pages.
	picked := OrderedCollection new.
	1
		to: aNumber
		do: [ :i | 
			| posn |
			available ifEmpty: [ ^ self addPages: picked ].
			posn := available size atRandom.
			pick := available at: posn.
			picked addLast: pick.
			available removeAt: posn ].
	^ self addPages: picked
]

{ #category : #accessing }
PageClassifier >> allResults [
	^ self chats flatCollect: #results
]

{ #category : #accessing }
PageClassifier >> announcer [
	^ announcer
]

{ #category : #accessing }
PageClassifier >> attribute [
	self deprecated: 'Use resultType'.
	^ resultType
]

{ #category : #accessing }
PageClassifier >> attribute: aString [
	self deprecated: 'Use resultType:'.
	resultType := aString
]

{ #category : #accessing }
PageClassifier >> blackList [
	"A list of problem pages that we need to avoid.
	NB: infinite recursion problem in page 'How to guard against inifinte loops?' has been resolved."

	^ {}
]

{ #category : #'instance creation' }
PageClassifier >> chatForPage: aLePage [
	| pcChat |
	pcChat := PageClassifierChat new
			resultType: self resultType;
			page: aLePage;
			prompt: self prompt;
			yourself.
	pcChat announcer
		when: PCResultsUpdatedAnnouncement
		send: #notifyResultsUpdated
		to: self.
	^ pcChat
]

{ #category : #querying }
PageClassifier >> chatWithPage: aLePage [
	"NB: will produce error if no such chat exists."
	^ self chats detect: [ :c | c page = aLePage ]
]

{ #category : #accessing }
PageClassifier >> chats [
	^ chats
]

{ #category : #querying }
PageClassifier >> chatsWithNewCategories [
	"NB: only makes sense if the prompt is related to categories."

	^ self
		pcChatGroupWithItems: (self chats select: [ :chat | chat results includesAny: self newCategories ])
]

{ #category : #accessing }
PageClassifier >> database [
	self assert: self chats notEmpty.
	^ self pages first database
]

{ #category : #accessing }
PageClassifier >> definingMethod [
	^ definingMethod
]

{ #category : #'instance creation' }
PageClassifier >> freshCopy [
	"Return a copy with uninitialized chats and results."
	^ self class new
		resultType: self resultType;
		prompt: self prompt;
		pages: self pages;
		jsonFile: self jsonFile;
		yourself
]

{ #category : #printing }
PageClassifier >> gtDisplayOn: stream [
	super gtDisplayOn: stream.
	stream
		nextPut: $(;
		nextPutAll: self jsonFileBasename;
		nextPutAll: ' — ';
		nextPutAll: self resultType;
		nextPutAll: ' — ';
		nextPutAll: self chats size printString;
		nextPutAll: ' chats';
		nextPut: $)
]

{ #category : #action }
PageClassifier >> gtSpawnCopyAction: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Spawn a copy and send a new request';
		priority: 21;
		icon: BrGlamorousVectorIcons playinspect;
		action: [ :aButton | aButton phlow spawnObject: self freshCopy requestResults ]
]

{ #category : #view }
PageClassifier >> gtSummaryFor: aView [
	<gtView>
	| book |
	self chats
		ifEmpty: [ book := '-' ]
		ifNotEmpty: [ book := self chats first page database ].

	^ aView columnedList
		title: 'Summary';
		priority: 20;
		items: [ {{'Result type'.
					self resultType}.
				{'Book'.
					book}.
				{'Pages'.
					self pages size printString , ' pages'.
					self pages}.
				{'Chats'.
					self chats size printString , ' chats'.
					self chats}.
				{'Prompt'.
					self prompt}.
				{'JSON file'.
					self jsonFileBasename.
					self jsonFileReference}.
				{'Defining method'.
					self definingMethod}} ];
		actionUpdateButtonTooltip: 'Update item list';
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Key'
			text: #first
			width: 100;
		column: 'Value' text: #second;
		send: #last
]

{ #category : #initialization }
PageClassifier >> initialize [
	super initialize.
	announcer := Announcer new.
	chats := OrderedCollection new.
	self initializeDefiningMethod
]

{ #category : #initialization }
PageClassifier >> initializeDefiningMethod [
	"Walk up the stack looking for a method  with a gtExample pragma.
	Leave it nil if not found."

	| context |
	context := thisContext.
	[ context sender isNil ]
		whileFalse: [ context := context sender.
			(context method hasPragmaNamed: #gtExample)
				ifTrue: [ ^ definingMethod := context method ] ]
]

{ #category : #initialization }
PageClassifier >> initializeFromJson: json [
	"NB: we only set attributes not already initialized.
	To initialize the results there is now a separate method."

	| database |
	jsonFile ifNil: [ jsonFile := json at: 'jsonFile' ifAbsent: nil ].
	resultType ifNil: [ resultType := json at: 'resultType' ].
	prompt ifNil: [ prompt := (json at: 'prompt') asPrompt ].
	database := LeDatabase databaseNamed: (json at: 'bookName').
	(json at: 'chats')
		do: [ :j | 
			| page chat |
			page := database pageNamed: (j at: 'pageName').
			chat := self chats
					detect: [ :c | c page = page ]
					ifNone: [ chats addLast: (self chatForPage: page) ].
			"chat initializeResults: (j at: 'results')" ].
	^ self
]

{ #category : #initialization }
PageClassifier >> initializeResultsFromJson: json [
	| database |
	database := LeDatabase databaseNamed: (json at: 'bookName').
	(json at: 'chats')
		do: [ :j | 
			(self chatWithPage: (database pageNamed: (j at: 'pageName')))
				initializeResults: (j at: 'results') ]
]

{ #category : #accessing }
PageClassifier >> jsonFile [
	^ jsonFile
]

{ #category : #accessing }
PageClassifier >> jsonFile: aString [
	| contents |
	jsonFile := aString.
	(self jsonFileReference exists
		and: [ contents := self jsonFileReference contents.
			contents notEmpty ])
		ifTrue: [ self initializeFromJson: (STONJSON fromString: contents) ]
]

{ #category : #accessing }
PageClassifier >> jsonFileBasename [
	^ self jsonFile
		ifNil: [ '<no json file>' ]
		ifNotNil: [ self jsonFileReference basenameWithoutExtension ]
]

{ #category : #serialization }
PageClassifier >> jsonFileReference [
	^ FileLocator gtResource / self jsonFile
]

{ #category : #converting }
PageClassifier >> jsonObject [
	| json |
	json := {'resultType' -> self resultType.
			'bookName' -> self pages first database databaseName.
			'prompt' -> self prompt jsonObject.
			'chats' -> (self chats collect: [ :chat | chat jsonObject ]) asArray}
			asDictionary.
	self jsonFile ifNotNil: [ json at: 'jsonFile' put: jsonFile ].
	^ json
]

{ #category : #serialization }
PageClassifier >> loadJSONresults [
	self jsonFileReference
		ifExists: [ self
				initializeResultsFromJson: (STONJSON fromString: self jsonFileReference contents) ].
	^ self jsonFileReference
]

{ #category : #accessing }
PageClassifier >> missingResults [
	^ (self chats reject: #hasResults) size
]

{ #category : #querying }
PageClassifier >> multiResultChats [
	^ self pcChatGroupWithItems: (self chats select: [ :c | c results size > 1 ])
]

{ #category : #querying }
PageClassifier >> newCategories [
	"NB: only makes sense if the prompt is related to categories."

	^ self allResults copyWithoutDuplicates
		copyWithoutAll: CategoryClassifierExperiments new standardCategories
]

{ #category : #accessing }
PageClassifier >> newTopics [
	"NB: only makes sense if the prompt is related to topics."
	
	^ self allResults copyWithoutDuplicates
		copyWithoutAll: TopicClassifierExperiments new topicsFromClusters
]

{ #category : #announcements }
PageClassifier >> notifyResultsUpdated [
	self announcer announce: PCResultsUpdatedAnnouncement new
]

{ #category : #accessing }
PageClassifier >> pages: aLePageCollection [
	"NB: If this is sent after sending @jsonFile: then it will replace any initialized chats."

	chats := (aLePageCollection asOrderedCollection
			reject: [ :p | self blackList includes: p title ])
			collect: [ :aLePage | self chatForPage: aLePage ]
]

{ #category : #search }
PageClassifier >> pcChatGroupWithItems: aChatCollection [
	"For use in Spotter searches"

	^ PCChatGroup new
		pageClassifier: self;
		initializeWith: aChatCollection;
		yourself
]

{ #category : #accessing }
PageClassifier >> prompt [
	^ prompt
]

{ #category : #accessing }
PageClassifier >> prompt: aStringOrDictionary [
	"If a string, convert to a simple prompt.
	If a (JSON) dictionary, decide which kind of prompt to create."

	prompt := aStringOrDictionary asPrompt
]

{ #category : #action }
PageClassifier >> requestResultsSync [
	"Sync version for testing."

	chats do: [ :chat | chat requestResults ]
]

{ #category : #accessing }
PageClassifier >> resultType [
	^ resultType
]

{ #category : #accessing }
PageClassifier >> resultType: aString [
	resultType := aString
]

{ #category : #serialization }
PageClassifier >> saveToJSONfile [
	| file |
	file := self jsonFileReference ensureCreateFile asFileReference fileReference.
	file writeStreamDo: [ :aStream | aStream nextPutAll: self jsonString ].
	^ file
]

{ #category : #accessing }
PageClassifier >> withPrompt: aString [
	"Spawn a copy of myself with a new prompt."
	^ self class new
		resultType: self resultType;
		pages: self pages;
		prompt: aString;
		yourself
]
