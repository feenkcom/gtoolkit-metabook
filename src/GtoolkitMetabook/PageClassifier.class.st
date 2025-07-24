Class {
	#name : #PageClassifier,
	#superclass : #Object,
	#instVars : [
		'attribute',
		'prompt',
		'pages',
		'announcer',
		'chats',
		'backgroundProcess'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #accessing }
PageClassifier >> announcer [
	^ announcer
]

{ #category : #accessing }
PageClassifier >> attribute [
	^ attribute
]

{ #category : #accessing }
PageClassifier >> attribute: aString [
	attribute := aString
]

{ #category : #accessing }
PageClassifier >> chats [
	^ chats
		ifNil: [ chats := self pages
					collect: [ :p | 
						| pcChat |
						pcChat := PageClassifierChat new
								attribute: self attribute;
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

{ #category : #action }
PageClassifier >> gtSendRequestAction: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Send requests to all chats';
		priority: 20;
		icon: BrGlamorousVectorIcons play;
		action: [ :aButton | [ self requestResults ] fork ]
]

{ #category : #initialization }
PageClassifier >> initialize [
	super initialize.
	announcer := Announcer new
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
	"TODO: Need a mutex to avoid running request twice.
	TODO: only update if no results yet."

	| title jobs |
	self assert: backgroundProcess isNil.
	title := 'Sending chat requests'.
	jobs := chats collect: [ :chat | chat requestResults ].
	backgroundProcess := [ [ :job | 
		job title: title.
		jobs
			withIndexDo: [ :each :index | 
				job
					progress: index / jobs size;
					title: each printString.
				each value ] ] asJob run.
		backgroundProcess := nil ] fork
]

{ #category : #accessing }
PageClassifier >> withPrompt: aString [
	"Spawn a copy of myself with a new prompt."
	^ self class new
		attribute: self attribute;
		pages: self pages;
		prompt: aString;
		yourself
]
