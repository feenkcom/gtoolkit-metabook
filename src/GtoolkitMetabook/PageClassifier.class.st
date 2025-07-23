Class {
	#name : #PageClassifier,
	#superclass : #Object,
	#instVars : [
		'pages'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #accessing }
PageClassifier >> pages [
	^ pages
]

{ #category : #accessing }
PageClassifier >> pages: aLePageCollection [
	pages := aLePageCollection
]
