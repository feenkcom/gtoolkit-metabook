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
		'results'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

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

{ #category : #accessing }
PageClassifierChat >> defaultBook [
	^ LeDatabase gtBook
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
PageClassifierChat >> gtResultsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Results';
		priority: 20;
		items: [ self results ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #'as yet unclassified' }
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
	self chat provider format: self format.
	self chat addMessage: (GtLlmUserMessage new content: self pageString).
	self chat sendMessage: self prompt.
	self chat provider executions last wait
]

{ #category : #accessing }
PageClassifierChat >> results [
	^ results
		ifNil: [ self requestResults.
			results := self chat messages last contentJson at: 'results' ]
]
