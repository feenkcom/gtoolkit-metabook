Class {
	#name : #PageClassifier,
	#superclass : #Object,
	#instVars : [
		'prompt',
		'pages',
		'announcer',
		'chats',
		'mutex',
		'process',
		'resultType'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

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

{ #category : #views }
PageClassifier >> gtJsonFor: aView [
	<gtView>
	^ aView forward
		title: 'JSON object';
		priority: 40;
		object: [ self jsonObject asGtJson ];
		view: #gtJsonObjectFor:context:
]

{ #category : #views }
PageClassifier >> gtJsonStringFor: aView [
	<gtView>
	^ aView forward
		title: 'JSON string';
		priority: 41;
		object: [ self jsonObject asGtJson ];
		view: #gtJsonStringFor:
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

{ #category : #initialization }
PageClassifier >> initialize [
	super initialize.
	announcer := Announcer new.
	mutex := Mutex new
]

{ #category : #converting }
PageClassifier >> jsonObject [
	^ {'resultType' -> self resultType.
		'bookName' -> self pages first database databaseName.
		'prompt' -> self prompt.
		'chats'
			-> (self chats
					collect: [ :chat | 
						{'pageName' -> chat page title.
							'results' -> chat results asArray} asDictionary ]) asArray} asDictionary
]

{ #category : #printing }
PageClassifier >> jsonString [
	^ STON toJsonString: self jsonObject
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
	prompt := aString
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

{ #category : #accessing }
PageClassifier >> withPrompt: aString [
	"Spawn a copy of myself with a new prompt."
	^ self class new
		resultType: self resultType;
		pages: self pages;
		prompt: aString;
		yourself
]
