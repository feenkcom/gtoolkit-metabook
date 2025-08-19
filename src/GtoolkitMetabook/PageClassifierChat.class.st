"
I encapsulate a chat that classifies a page according some attribute of interest (i.e., its topic, or the category of page content) using a particular prompt.
"
Class {
	#name : #PageClassifierChat,
	#superclass : #PCEntity,
	#instVars : [
		'page',
		'prompt',
		'chat',
		'results',
		'announcer',
		'resultType'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #announcements }
PageClassifierChat >> announcer [
	^ announcer
]

{ #category : #accessing }
PageClassifierChat >> attribute [
	self deprecated: 'Use resultType'.
	^ resultType
]

{ #category : #initialization }
PageClassifierChat >> attribute: aString [
	"The name of an attribute, such as 'Topic' or 'Category'"

	self deprecated: 'Use resultType:'.
	resultType := aString
]

{ #category : #accessing }
PageClassifierChat >> chat [
	^ chat ifNil: [ chat := GtLlmChat new ]
]

{ #category : #accessing }
PageClassifierChat >> clearResults [
	results := self defaultResults.
	self notifyResultsUpdated
]

{ #category : #defaults }
PageClassifierChat >> defaultResultValue [
	| default |
	default := '-'.
	^ default
]

{ #category : #defaults }
PageClassifierChat >> defaultResults [
	"NB: ensure that chats do not share the same results reference!"

	^ Array new
]

{ #category : #constants }
PageClassifierChat >> format [
	"JSON schema for the output -- a list of results.
	This should be generic enough to work for all classifiers.
	NB: the format allows for any number of results, not just a maximum of 3."

	^ {'type' -> 'object'.
		'properties'
			-> {'results'
						-> {'type' -> 'array'.
								'items' -> {'type' -> 'string'} asDictionary} asDictionary} asDictionary.
		'required' -> {'results'}.
		'additionalProperties' -> false} asDictionary
]

{ #category : #'instance creation' }
PageClassifierChat >> freshCopy [
	"Return a copy with uninitialized chats and results."

	^ self class new
		resultType: self resultType;
		page: self page;
		prompt: self prompt;
		yourself
]

{ #category : #view }
PageClassifierChat >> gtChatFor: aView [
	<gtView>
	^ aView forward
		title: 'Chat';
		priority: 30;
		object: [ self chat ];
		view: #gtMessagesWidgetFor:
]

{ #category : #action }
PageClassifierChat >> gtClearResultsAction: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Clear the results';
		priority: 10;
		icon: BrGlamorousVectorIcons close;
		action: [ :aButton | self clearResults ]
]

{ #category : #view }
PageClassifierChat >> gtPageFor: aView [
	<gtView>
	^ aView forward
		title: 'Page';
		priority: 10;
		object: [ self page ];
		view: #gtLiveFor:
]

{ #category : #view }
PageClassifierChat >> gtResultsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Results';
		priority: 35;
		items: [ self results ];
		column: 'Value' text: [ :each | each gtDisplayString ];
		actionUpdateButton;
		updateWhen: PCResultsUpdatedAnnouncement in: self announcer
]

{ #category : #action }
PageClassifierChat >> gtSendRequestAction: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Send the request';
		priority: 20;
		icon: BrGlamorousVectorIcons play;
		action: [ :aButton | self requestResults ]
]

{ #category : #action }
PageClassifierChat >> gtSpawnCopyAction: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Spawn a copy and send a new request';
		priority: 21;
		icon: BrGlamorousVectorIcons playinspect;
		action: [ :aButton | aButton phlow spawnObject: self freshCopy requestResults ]
]

{ #category : #view }
PageClassifierChat >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 12;
		items: [ {{'Result type'.
					self resultType}.
				{'Book'.
					self page database}.
				{'Page'.
					self page}.
				{'Prompt'.
					self prompt}.
				{'Chat'.
					self chat}} ];
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

{ #category : #accessing }
PageClassifierChat >> hasResults [
	^ self results notEmpty
]

{ #category : #initialization }
PageClassifierChat >> initialize [
	super initialize.
	announcer := Announcer new.
	results := self defaultResults
]

{ #category : #initialization }
PageClassifierChat >> initializeResults: anArray [
	results := anArray.
	self notifyResultsUpdated
]

{ #category : #accessing }
PageClassifierChat >> jsonObject [
	^ {'pageName' -> self page title.
		'results' -> self results asArray} asDictionary
]

{ #category : #announcements }
PageClassifierChat >> notifyResultsUpdated [
	self announcer announce: PCResultsUpdatedAnnouncement new
]

{ #category : #accessing }
PageClassifierChat >> page [
	^ page
]

{ #category : #accessing }
PageClassifierChat >> page: aLePage [
	page := aLePage
]

{ #category : #accessing }
PageClassifierChat >> pageString [
	^ GtLlmLepiterContentExporter new
		page: self page;
		export
]

{ #category : #accessing }
PageClassifierChat >> pageTitle [
	^self page title
]

{ #category : #accessing }
PageClassifierChat >> prompt [
	^ prompt
]

{ #category : #initialization }
PageClassifierChat >> prompt: anObject [
	prompt := anObject
]

{ #category : #computing }
PageClassifierChat >> requestResults [
	"Run the query. If we already have results, ignore the request.
	We should instead spawn a new chat for comparison."

	results ifNotEmpty: [ ^ self ].
	self chat provider instructions: self prompt value.
	self chat provider format: self format.
	self chat sendMessage: self pageString.
	self chat provider executions last wait.
	results := self chat messages last contentJson at: 'results'.
	self notifyResultsUpdated
]

{ #category : #accessing }
PageClassifierChat >> resultType [
	^ resultType
]

{ #category : #initialization }
PageClassifierChat >> resultType: aString [
	"The name of an attribute, such as 'Topic' or 'Category'"

	resultType := aString
]

{ #category : #accessing }
PageClassifierChat >> results [
	^ results
]

{ #category : #querying }
PageClassifierChat >> resultsJoined [
	^ String cr join: self results
]

{ #category : #accessing }
PageClassifierChat >> resultsWithDefaults: minSize [
	"To be used by views that expect results to be of a certain length."

	| size |
	size := minSize max: self results size.
	^ (1 to: size)
		collect: [ :i | self results at: i ifAbsent: self defaultResultValue ]
]

{ #category : #printing }
PageClassifierChat >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self class name;
		nextPutAll: ' new';
		lf;
		tab;
		nextPutAll: 'resultType: ';
		print: self resultType;
		nextPut: $;;
		lf;
		tab;
		nextPutAll: 'page: ((LeDatabase databaseNamed: ';
		print: self page database databaseName;
		nextPutAll: ') pageNamed: ';
		print: self page title;
		nextPutAll: ');';
		lf;
		tab;
		nextPutAll: 'prompt: '.
	self prompt storeOn: aStream.
	aStream
		nextPut: $;;
		lf;
		tab;
		nextPutAll: ' yourself)'
]

{ #category : #accessing }
PageClassifierChat >> withPrompt: aString [
	"Spawn a copy of myself with a new prompt."

	^ self class new
		resultType: self resultType;
		page: self page;
		prompt: aString;
		yourself
]
