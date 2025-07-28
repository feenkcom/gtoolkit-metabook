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
	^ self new fromJson: json
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

{ #category : #initialization }
PageClassifier >> fromJson: json [
	"NB: First we build the classifier and its pages. Then we lazily initialize the chats
	as usual, and finally update the results from the json."

	| database resultDict |
	self resultType: (json at: 'resultType').
	self prompt: (json at: 'prompt').
	self jsonFile: (json at: 'jsonFile' ifAbsent: nil).
	database := LeDatabase databaseNamed: (json at: 'bookName').
	resultDict := Dictionary new.
	pages := (json at: 'chats')
			collect: [ :j | 
				resultDict at: (j at: 'pageName') put: (j at: 'results').
				database pageNamed: (j at: 'pageName') ].
	self chats
		do: [ :chat | chat initializeResults: (resultDict at: chat page title) ].
	^ self
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

{ #category : #accessing }
PageClassifier >> jsonFile [
	^ jsonFile
]

{ #category : #accessing }
PageClassifier >> jsonFile: aString [
	jsonFile := aString
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
PageClassifier >> prompt: aString [
	prompt := aString asPrompt
]

{ #category : #action }
PageClassifier >> requestResults [
	"TODO: only update if no results yet."

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
	file := (FileLocator gtResource / self jsonFile) ensureCreateFile
			asFileReference fileReference.
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
