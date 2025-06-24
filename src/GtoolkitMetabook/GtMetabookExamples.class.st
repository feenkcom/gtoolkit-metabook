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
	self assert: page isMetapage not.
	self assert: page hasMetapage.
	^ page
]

{ #category : #accessing }
GtMetabookExamples >> gtBookMetapage [
	<gtExample>
	| page metapage |
	page := self gtBookMainPage.
	metapage := page metapage.
	self assert: metapage isMetapage.
	self assert: metapage metaRepoName equals: 'gtoolkit-metabook'.
	self assert: metapage baseDatabase equals: page database.
	self assert: metapage hasBasePage.
	self assert: metapage basePage equals: page.
	^ metapage
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
