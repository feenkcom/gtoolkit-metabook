"
Like my parent, I provide an overview of the mappings of topics and categories, however I retreive all my data from the stored JSON, and test that the results are the same as those generated.
"
Class {
	#name : #TopicMapOverviewFromJson,
	#superclass : #TopicMapOverview,
	#instVars : [
		'cachedGroupsAndPagesJson'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #accessing }
TopicMapOverviewFromJson >> cachedGroupsAndPagesJson [
	^ cachedGroupsAndPagesJson
		ifNil: [ cachedGroupsAndPagesJson := self groupsAndPagesJsonFromFile ]
]

{ #category : #'as yet unclassified' }
TopicMapOverviewFromJson >> category2PageMap [
	"NB: to perform the comparison we must turn the page collection values into sets."

	<gtExample>
	| category2PageMap |
	category2PageMap := super category2PageMap.
	self
		assert: (category2PageMap associations collect: [ :kv | kv key -> kv value asSet ])
		equals: (TopicMapOverview new category2PageMap associations
				collect: [ :kv | kv key -> kv value asSet ]).
	^ category2PageMap
]

{ #category : #examples }
TopicMapOverviewFromJson >> categoryMap [
	<gtExample>
	| categoryMap |
	categoryMap := ((self cachedGroupsAndPagesJson at: 'pages')
			collect: [ :d | (d at: 'page') -> (d at: 'category') ]) asDictionary.
	self assert: categoryMap equals: super categoryMap.
	^ categoryMap
]

{ #category : #examples }
TopicMapOverviewFromJson >> standardCategories [
	"Although we can retrieve these from the JSON, we stick to the original order."

	<gtExample>
	| standardCategories |
	standardCategories := ((self cachedGroupsAndPagesJson at: 'pages')
			collect: [ :d | d at: 'category' ]) copyWithoutDuplicates.
	self assert: standardCategories asSet equals: super standardCategories asSet.
	^ super standardCategories
]
