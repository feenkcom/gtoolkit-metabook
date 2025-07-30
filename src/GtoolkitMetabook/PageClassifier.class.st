"
I am a page classifier that classifies lepiter pages using a generative AI chat with a given prompt.
The classification could be into topics (such as EDD orMoldable Development) or it could be into the type of page (exercise, use case, tutorial etc).
"
Class {
	#name : #PageClassifier,
	#superclass : #PCEntity,
	#instVars : [
		'prompt',
		'pages',
		'announcer',
		'chats',
		'mutex',
		'process',
		'resultType',
		'jsonFile'
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

{ #category : #accessing }
PageClassifier >> chats [
	^ chats
		ifNil: [ chats := self pages
					collect: [ :p | 
						| pcChat |
						pcChat := PageClassifierChat new
								resultType: self resultType;
								page: p;
								prompt: self prompt;
								yourself.
						pcChat announcer
							when: PCResultsUpdatedAnnouncement
							send: #notifyResultsUpdated
							to: self.
						pcChat ] ]
]

{ #category : #views }
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

{ #category : #printing }
PageClassifier >> gtDisplayOn: stream [
	super gtDisplayOn: stream.
	stream nextPut: $(;
		nextPutAll: self jsonFileReference basenameWithoutExtension;
		nextPutAll: ' — ';
		nextPutAll: self resultType;
		nextPut: $)
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
PageClassifier >> gtStoreJSONAction: anAction [
	<gtAction>
	self jsonFile ifNil: [ ^ anAction empty ].
	self jsonFile ifEmpty: [ ^ anAction empty ].
	^ anAction button
		tooltip: 'Store JSON';
		priority: 30;
		icon: BrGlamorousIcons save;
		action: [ :aButton | aButton phlow spawnObject: self saveToJSONfile ]
]

{ #category : #initialization }
PageClassifier >> initialize [
	super initialize.
	announcer := Announcer new.
	mutex := Mutex new
]

{ #category : #initialization }
PageClassifier >> initializeFromJson: json [
	"NB: we only set attributes not already initialized.
	The page set in the json may not be identical to the pages attribute if
	it has already been separately set, so we must check each page and chat for results."

	| database resultDict |
	jsonFile ifNil: [ jsonFile := json at: 'jsonFile' ifAbsent: nil ].
	resultType ifNil: [ resultType := json at: 'resultType' ].
	prompt ifNil: [ prompt := (json at: 'prompt') asPrompt ].


	database := LeDatabase databaseNamed: (json at: 'bookName').
	resultDict := Dictionary new.

	pages ifNil: [ pages := OrderedCollection new ].
	(json at: 'chats')
		do: [ :j | 
			resultDict at: (j at: 'pageName') put: (j at: 'results').
			pages addIfNotPresent: (database pageNamed: (j at: 'pageName')) ].

	chats := nil.	"Force regeneration."
	self chats
		do: [ :chat | chat initializeResults: (resultDict at: chat page title ifAbsent: nil) ].

	^ self
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
	^ pages
]

{ #category : #accessing }
PageClassifier >> pages: aLePageCollection [
	pages := aLePageCollection
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
