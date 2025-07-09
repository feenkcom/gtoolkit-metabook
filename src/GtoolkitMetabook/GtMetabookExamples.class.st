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

{ #category : #'as yet unclassified' }
GtMetabookExamples >> gtBookMapping [
	<gtExample>
	| map |
	map := GtMetabookRegistry new gtBookMapping.
	self assert: map baseDatabase equals: LeDatabase gtBook.
	^ map
]

{ #category : #accessing }
GtMetabookExamples >> gtBookMetapage [
	<gtExample>
	| page metapage |
	page := self gtBookMainPage.
	metapage := page metapage.
	self assert: metapage isMetapage.
	self assert: metapage repoName equals: 'gtoolkit-metabook'.
	self assert: metapage baseDatabase equals: page database.
	self assert: metapage hasBasePage.
	self assert: metapage basePage equals: page.
	^ metapage
]

{ #category : #accessing }
GtMetabookExamples >> gtBookRepo [
	<gtExample>
	| repoName repo |
	repoName := self gtBookMainPage repoName.
	self assert: repoName isNotNil.
	repo := GtGitRepository forRepoNamed: repoName.
	^ repo
]

{ #category : #accessing }
GtMetabookExamples >> projectMainPage [
	"Databases that are not registered have no meta database, and their repo is not known."

	<gtExample>
	| page |
	page := (LeDatabase databaseNamed: 'feenkcom/gtoolkit-metabook/lepiter')
			pageNamed: 'Metabook project'.
	self assert: page hasMetadatabase not.
	self assert: page repoName isNil.
	^ page
]
