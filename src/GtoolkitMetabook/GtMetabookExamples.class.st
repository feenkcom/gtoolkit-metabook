Class {
	#name : #GtMetabookExamples,
	#superclass : #Object,
	#category : #'GtoolkitMetabook-Examples'
}

{ #category : #accessing }
GtMetabookExamples >> gtBookMainPage [
	<gtExample>
	| page |
	page := LeDatabase gtBook pageNamed: 'Glamorous Toolkit'.
	self assert: page hasMetadatabase.
	^ page
]

{ #category : #accessing }
GtMetabookExamples >> projectMainPage [
	<gtExample>
	| page |
	page := (LeDatabase databaseNamed: 'feenkcom/gtoolkit-metabook/lepiter')
			pageNamed: 'Metabook project'.
	self assert: page hasMetadatabase not.
	^ page
]
