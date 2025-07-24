Class {
	#name : #PageClassifier,
	#superclass : #Object,
	#instVars : [
		'attribute',
		'prompt',
		'chats',
		'pages'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

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
						PageClassifierChat new
							attribute: self attribute;
							page: p;
							prompt: self prompt;
							yourself ] ]
]

{ #category : #views }
PageClassifier >> gtChatsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Chats';
		priority: 10;
		items: [ self chats ];
		column: 'Page' text: [ :each | each page title ] width: 300;
		column: 'Result[1]' text: [ :each | each results first ] width: 150;
		column: 'Result[2]' text: [ :each | each results second ] width: 150;
		column: 'Result[rest]' text: [ :each | '; ' join: (each results allButFirst: 2)] width: 150;
		actionUpdateButton
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

{ #category : #accessing }
PageClassifier >> withPrompt: aString [
	"Spawn a copy of myself with a new prompt."
	^ self class new
		attribute: self attribute;
		pages: self pages;
		prompt: aString;
		yourself
]
