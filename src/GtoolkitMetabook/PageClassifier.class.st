"
I am a page classifier that classifies lepiter pages using a generative AI chat with a given prompt.
The classification could be into topics (such as EDD orMoldable Development) or it could be into the type of page (exercise, use case, tutorial etc).
"
Class {
	#name : #PageClassifier,
	#superclass : #PCEntity,
	#instVars : [
		'prompt',
		'announcer',
		'chats',
		'mutex',
		'process',
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

{ #category : #accessing }
PageClassifier >> definingMethod [
	^ definingMethod
]

{ #category : #'instance creation' }
PageClassifier >> freshCopy [
	"Return a copy with uninitialized chats and results."
	self shouldBeImplemented.

	^ self class new
		resultType: self resultType;
		"page: self page;"
		prompt: self prompt;
		yourself
]

{ #category : #view }
PageClassifier >> gtChatsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Chats';
		priority: 10;
		items: [ self chats ];
		column: 'Page'
			text: [ :each | each page title ]
			width: 300;
		column: 'Result[1]'
			text: [ :each | (each resultsWithDefaults: 3) first ]
			width: 150;
		column: 'Result[2]'
			text: [ :each | (each resultsWithDefaults: 3) second ]
			width: 150;
		column: 'Result[rest]'
			text: [ :each | '; ' join: ((each resultsWithDefaults: 3) allButFirst: 2) ]
			width: 150;
		actionUpdateButton;
		updateWhen: PCResultsUpdatedAnnouncement in: self announcer
]

{ #category : #action }
PageClassifier >> gtClearResultsAction: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Clear the results';
		priority: 30;
		icon: BrGlamorousVectorIcons close;
		action: [ :aButton | self chats do: #clearResults ]
]

{ #category : #printing }
PageClassifier >> gtDisplayOn: stream [
	super gtDisplayOn: stream.
	stream
		nextPut: $(;
		nextPutAll: self jsonFileBasename;
		nextPutAll: ' — ';
		nextPutAll: self resultType;
		nextPut: $)
]

{ #category : #action }
PageClassifier >> gtLoadResultsAction: anAction [
	<gtAction>
	self jsonFile ifNil: [ ^ anAction empty ].
	self jsonFile ifEmpty: [ ^ anAction empty ].
	^ anAction button
		tooltip: 'Load results from stored JSON';
		priority: 32;
		icon: BrGlamorousIcons loadfromdisk;
		action: [ :aButton | aButton phlow spawnObject: self loadJSONresults ]
]

{ #category : #view }
PageClassifier >> gtPromptStringFor: aView [
	<gtView>
	^ aView forward
		title: 'Prompt';
		priority: 42;
		object: [ self prompt ];
		view: #gtPromptFor:;
		actionUpdateButton
]

{ #category : #action }
PageClassifier >> gtSendRequestAction: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Send requests to chats' " missing results (' , self missingResults printString , ')'";
		priority: 20;
		icon: BrGlamorousVectorIcons play;
		action: [ :aButton | self requestResults ]
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

{ #category : #action }
PageClassifier >> gtStoreJSONAction: anAction [
	<gtAction>
	self jsonFile ifNil: [ ^ anAction empty ].
	self jsonFile ifEmpty: [ ^ anAction empty ].
	^ anAction button
		tooltip: 'Store JSON';
		priority: 40;
		icon: BrGlamorousIcons savetodisk;
		action: [ :aButton | aButton phlow spawnObject: self saveToJSONfile ]
]

{ #category : #'as yet unclassified' }
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
	mutex := Mutex new.
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

{ #category : #'as yet unclassified' }
PageClassifier >> loadJSONresults [
	self
		initializeResultsFromJson: (STONJSON fromString: self jsonFileReference contents).
		^ self jsonFileReference
]

{ #category : #accessing }
PageClassifier >> missingResults [
	^ (self chats reject: #hasResults) size
]

{ #category : #announcements }
PageClassifier >> notifyResultsUpdated [
	self announcer announce: PCResultsUpdatedAnnouncement new
]

{ #category : #accessing }
PageClassifier >> pages [
	^ self chats collect: #page
]

{ #category : #accessing }
PageClassifier >> pages: aLePageCollection [
	"NB: If this is sent after sending @jsonFile: then it will replace any initialized chats."

	chats := aLePageCollection asOrderedCollection
			collect: [ :aLePage | self chatForPage: aLePage ]
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
PageClassifier >> requestResults [
	"NB: Async version"

	| title jobs |
	mutex
		critical: [ process
				ifNil: [ title := 'Sending chat requests'.
					jobs := chats collect: [ :chat | [ chat requestResults ] ].
					process := [ [ :job | 
						job title: title.
						jobs
							withIndexDo: [ :each :index | 
								job
									progress: index / jobs size;
									title: each printString.
								each value ] ] asJob run.	"NB: second CS is within the forked process"
						mutex critical: [ process := nil ] ] fork ]
				ifNotNil: [ self inform: 'A request is already running!' ] ]
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
