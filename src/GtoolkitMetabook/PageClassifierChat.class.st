"
I encapsulate a chat that classifies a page according some attribute of interest (i.e., its topic, or the category of page content) using a particular prompt.
"
Class {
	#name : #PageClassifierChat,
	#superclass : #Object,
	#instVars : [
		'page',
		'prompt',
		'attribute',
		'chat',
		'results',
		'announcer'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #announcements }
PageClassifierChat >> announcer [
	^ announcer
]

{ #category : #accessing }
PageClassifierChat >> attribute [
	^ attribute
]

{ #category : #initialization }
PageClassifierChat >> attribute: aString [
	"The name of an attribute, such as 'Topic' or 'Category'"

	attribute := aString
]

{ #category : #accessing }
PageClassifierChat >> chat [
	^ chat ifNil: [ chat := GtLlmChat new ]
]

{ #category : #initialization }
PageClassifierChat >> defaultResults [
	^ #()
]

{ #category : #constants }
PageClassifierChat >> format [
	"JSON schema for the output -- a list of results.
	This should be generic enough to work for all classifiers."

	^ {'type' -> 'object'.
		'properties'
			-> {'results'
						-> {'type' -> 'array'.
								'items' -> {'type' -> 'string'} asDictionary} asDictionary} asDictionary.
		'required' -> {'results'}.
		'additionalProperties' -> false} asDictionary
]

{ #category : #views }
PageClassifierChat >> gtChatFor: aView [
	<gtView>
	^ aView forward
		title: 'Chat';
		priority: 30;
		object: [ self chat ];
		view: #gtMessagesWidgetFor:
]

{ #category : #view }
PageClassifierChat >> gtPageFor: aView [
	<gtView>
	^ aView forward
		title: 'Page';
		priority: 20;
		object: [ self page ];
		view: #gtLiveFor:
]

{ #category : #view }
PageClassifierChat >> gtResultsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Results';
		priority: 40;
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
		action: [ :aButton | 
			self requestResults.
			"aButton phlow spawnObject: self moves last "]
]

{ #category : #view }
PageClassifierChat >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 10;
		items: [ {{'Attribute'.
					self attribute}.
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

{ #category : #initialization }
PageClassifierChat >> initialize [
	super initialize.
	announcer := Announcer new.
	results := self defaultResults
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
	^ GtLlmPageExporter new
		page: self page;
		export
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
	"Run the query. If we already have results, reset the chat."

	results ifNotEmpty: [ chat := nil ].
	self chat provider format: self format.
	self chat addMessage: (GtLlmUserMessage new content: self pageString).
	self chat sendMessage: self prompt.
	self chat provider executions last wait.
	results := self chat messages last contentJson at: 'results'.
	self notifyResultsUpdated
]

{ #category : #accessing }
PageClassifierChat >> results [
	^ results
]

{ #category : #accessing }
PageClassifierChat >> withPrompt: aString [
	"Spawn a copy of myself with a new prompt."

	^ self class new
		attribute: self attribute;
		page: self page;
		prompt: aString;
		yourself
]
