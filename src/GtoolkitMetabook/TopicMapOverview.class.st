"
Inspect TopicMapOverview>>#overview for an overview.
"
Class {
	#name : #TopicMapOverview,
	#superclass : #Object,
	#instVars : [
		'cachedTopic2pageMap',
		'cachedCategory2PageMap'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #'as yet unclassified' }
TopicMapOverview class >> gtInspectOverviewActionFor: anAction [
	<gtClassAction>
	^ anAction button
		tooltip: 'Inspect slideshow';
		priority: 10;
		icon: BrGlamorousVectorIcons playinspect;
		action: [ :aButton | aButton phlow spawnObject: self new ];
		primaryModifierAction: [ :aButton | aButton phlow showObject: self new ]
			mouseCursor: BlCopyCursor new
]

{ #category : #accessing }
TopicMapOverview >> cachedCategory2PageMap [
	"Cached version for fast lookups."

	^ cachedCategory2PageMap
		ifNil: [ cachedCategory2PageMap := self category2PageMap ]
]

{ #category : #accessing }
TopicMapOverview >> cachedTopic2PageMap [
	"Cached version for fast lookups."

	^ cachedTopic2pageMap ifNil: [ cachedTopic2pageMap := self topic2PageMap ]
]

{ #category : #examples }
TopicMapOverview >> category2PageMap [
	"NB: This is computed each time."
	<gtExample>
	| dict |
	dict := Dictionary new.
	self categoryMap
		associationsDo: [ :assoc | (dict at: assoc value ifAbsentPut: OrderedCollection new) add: assoc key ].
	^ dict
]

{ #category : #examples }
TopicMapOverview >> categoryMap [
	<gtExample>
	^ CategoryClassifierExperiments new categoryMap
]

{ #category : #examples }
TopicMapOverview >> groupedTopics [
	<gtExample>
	^ (TopicClassifierExperiments new groupedTopics
		collect: [ :each | each first -> each second ]) asDictionary
]

{ #category : #examples }
TopicMapOverview >> groupsAndPagesJson [
	"NB: ignore pages not in the category and topics maps."

	<gtExample>
	| page2CategoryMap page2TopicMap groupsAndPagesJson mappedPages |
	page2CategoryMap := TopicMapOverview new categoryMap.
	mappedPages := page2CategoryMap keys.
	page2TopicMap := TopicMapOverview new page2TopicMap.
	self assert: mappedPages equals: page2TopicMap keys.
	groupsAndPagesJson := {'groups'
				-> (TopicMapOverview new groupedTopics associations
						collect: [ :assoc | 
							{'group' -> assoc key.
								'topics' -> assoc value} asDictionary ]).
			'pages'
				-> (LeDatabase gtBook pages asArray
						select: [ :page | mappedPages includes: page title ]
						thenCollect: [ :page | 
							{'page' -> page title.
								'category' -> (page2CategoryMap at: page title).
								'topics' -> (page2TopicMap at: page title)} asDictionary ])}
			asDictionary.
	^ groupsAndPagesJson
]

{ #category : #examples }
TopicMapOverview >> groupsAndPagesJsonFile [
	<gtExample>
	^ FileLocator gtResource
		/ 'feenkcom/gtoolkit-metabook/data/pc-json/groupsAndPagesJson.json'
]

{ #category : #examples }
TopicMapOverview >> groupsAndPagesJsonFromFile [
	"NB: assertion will fail if some pages have changed title."

	<gtExample>
	| json |
	json := STONJSON fromString: self groupsAndPagesJsonFile contents.	"self assert: json equals: self groupsAndPagesJson."
	^ json
]

{ #category : #views }
TopicMapOverview >> gtCategoriesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Standard Categories';
		priority: 10;
		items: [ self standardCategories ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Count'
			text: [ :cat | (self cachedCategory2PageMap at: cat) size ]
			width: 50;
		column: 'Item' text: [ :eachItem | eachItem gtDisplayText ];
		send: [ :cat | self pagesNamed: (self cachedCategory2PageMap at: cat) ];
		actionUpdateButton
]

{ #category : #views }
TopicMapOverview >> gtCategory2PageFor: aView [
	<gtView>
	^ aView forward
		title: 'Category to Page map';
		priority: 14;
		object: [ self category2PageMap ];
		view: #gtTreeFor:context:;
		send: [ :assoc | 
			assoc value isString
				ifTrue: [ LeDatabase gtBook pageNamed: assoc value ]
				ifFalse: [ self pagesNamed: assoc value ] ]
]

{ #category : #views }
TopicMapOverview >> gtCategoryMapFor: aView [
	<gtView>
	^ aView forward
		title: 'Page to Category map';
		priority: 12;
		object: [ self categoryMap ];
		view: #gtItemsFor:;
		send: [ :assoc | LeDatabase gtBook pageNamed: assoc key ];
		actionUpdateButton
]

{ #category : #views }
TopicMapOverview >> gtGroupedTopicsFor: aView [
	<gtView>
	^ aView forward
		title: 'Grouped Topics';
		priority: 22;
		object: [ self groupedTopics ];
		view: #gtTreeFor:context:;
		send: [ :assoc | 
			assoc value isString
				ifTrue: [ self pagesNamed: (self cachedTopic2PageMap at: assoc value) ]
				ifFalse: [ assoc value
						flatCollect: [ :pageName | self pagesNamed: (self cachedTopic2PageMap at: pageName) ] ] ]
]

{ #category : #views }
TopicMapOverview >> gtGroupsAndPagesJsonFor: aView [
	<gtView>
	^ aView forward
		title: 'Groups and Pages JSON';
		priority: 30;
		object: [ self groupsAndPagesJsonFromFile asGtJson ];
		view: #gtJsonObjectFor:context:
]

{ #category : #views }
TopicMapOverview >> gtTopicMapFor: aView [
	<gtView>
	^ aView forward
		title: 'Page to Topic map';
		priority: 24;
		object: [ self page2TopicMap ];
		view: #gtTreeFor:context:;
		send: [ :assoc | 
			assoc key isString
				ifTrue: [ LeDatabase gtBook pageNamed: assoc key ]
				ifFalse: [ self pagesNamed: (self cachedTopic2PageMap at: assoc value) ] ]
]

{ #category : #views }
TopicMapOverview >> gtTopicsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Topics';
		priority: 20;
		items: [ self topicsFromClusters ];
		actionUpdateButtonTooltip: 'Update item list';
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Count'
			text: [ :topic | (self cachedTopic2PageMap at: topic) size ]
			width: 50;
		column: 'Item' text: [ :eachItem | eachItem gtDisplayText ];
		send: [ :topic | self pagesNamed: (self cachedTopic2PageMap at: topic) ]
]

{ #category : #examples }
TopicMapOverview >> overview [
	<gtExample>
	^ self
]

{ #category : #examples }
TopicMapOverview >> page2TopicMap [
	<gtExample>
	^ TopicClassifierExperiments new top5TopicMap
]

{ #category : #utility }
TopicMapOverview >> pagesNamed: aPageNameCollection [
	^ aPageNameCollection
		select: [ :page | LeDatabase gtBook hasPageNamed: page ]
		thenCollect: [ :page | LeDatabase gtBook pageNamed: page ]
]

{ #category : #utility }
TopicMapOverview >> saveGroupsAndPagesJson [
	"Only run this if the file needs to be regenerated."

	<gtExample>
	<noTest>
	| jsonString file |
	jsonString := STONJSON toStringPretty: TopicMapOverview new groupsAndPagesJson.
	file := self groupsAndPagesJsonFile.
	file writeStreamDo: [ :aStream | aStream nextPutAll: jsonString ].
	^ file
]

{ #category : #examples }
TopicMapOverview >> standardCategories [
	<gtExample>
	^ CategoryClassifierExperiments new standardCategories
]

{ #category : #examples }
TopicMapOverview >> topic2PageMap [
	"NB: This is computed each time."
	<gtExample>
	| dict |
	dict := Dictionary new.
	self page2TopicMap
		associationsDo: [ :assoc | 
			assoc value
				do: [ :topic | (dict at: topic ifAbsentPut: OrderedCollection new) add: assoc key ] ].
	^ dict
]

{ #category : #examples }
TopicMapOverview >> topicsFromClusters [
	<gtExample>
	^ TopicClassifierExperiments new topicsFromClusters
]
