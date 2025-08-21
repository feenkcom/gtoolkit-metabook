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

{ #category : #utility }
TopicMapOverviewFromJson >> asAssociations2Sets: dict [
	^ dict associations collect: [ :kv | kv key -> kv value asSet ]
]

{ #category : #accessing }
TopicMapOverviewFromJson >> cachedGroupsAndPagesJson [
	^ cachedGroupsAndPagesJson
		ifNil: [ cachedGroupsAndPagesJson := self groupsAndPagesJsonFromFile ]
]

{ #category : #examples }
TopicMapOverviewFromJson >> category2PageMap [
	"NB: to perform the comparison we must turn the page collection values into sets."

	<gtExample>
	| category2PageMap |
	category2PageMap := super category2PageMap.
	self
		assert: (self asAssociations2Sets: category2PageMap)
		equals: (self asAssociations2Sets: TopicMapOverview new category2PageMap).
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
TopicMapOverviewFromJson >> groupedTopics [
	<gtExample>
	| groupedTopics |
	groupedTopics := ((self cachedGroupsAndPagesJson at: 'groups')
			collect: [ :d | (d at: 'group') -> (d at: 'topics') ]) asDictionary.
			
	self assert: groupedTopics equals: super groupedTopics.

	^ groupedTopics
]

{ #category : #examples }
TopicMapOverviewFromJson >> page2TopicMap [
	<gtExample>
	| page2TopicMap |
	page2TopicMap := ((self cachedGroupsAndPagesJson at: 'pages')
			collect: [ :d | (d at: 'page') -> (d at: 'topics') ]) asDictionary.
	self assert: page2TopicMap equals: super page2TopicMap.
	^ page2TopicMap
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

{ #category : #'as yet unclassified' }
TopicMapOverviewFromJson >> topic2PageMap [
	| topic2PageMap |
	topic2PageMap := super topic2PageMap.

	self
		assert: (self asAssociations2Sets: topic2PageMap)
		equals: (self asAssociations2Sets: TopicMapOverview new topic2PageMap).

	^ topic2PageMap
]
