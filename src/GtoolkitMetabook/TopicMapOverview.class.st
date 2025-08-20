Class {
	#name : #TopicMapOverview,
	#superclass : #Object,
	#instVars : [
		'cachedTopic2pageMap',
		'cachedCategory2PageMap'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

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

{ #category : #views }
TopicMapOverview >> gtCategoriesFor: aView [
	<gtView>
	^ aView forward
		title: 'Standard Categories';
		priority: 10;
		object: [ self standardCategories ];
		view: #gtItemsFor:;
		send: [ :cat | 
			(self cachedCategory2PageMap at: cat)
				collect: [ :each | LeDatabase gtBook pageNamed: each ] ]
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
			assoc value isSequenceable
				ifTrue: [ 
					assoc value collect: [ :each | LeDatabase gtBook pageNamed: each ] ]
				ifFalse: [ LeDatabase gtBook pageNamed: assoc value ] ]
]

{ #category : #views }
TopicMapOverview >> gtCategoryMapFor: aView [
	<gtView>
	^ aView forward
		title: 'Page to Category map';
		priority: 12;
		object: [ self categoryMap ];
		view: #gtItemsFor:;
		send: [ :assoc | LeDatabase gtBook pageNamed: assoc key ]
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
			assoc value isSequenceable
				ifTrue: [ assoc value
						flatCollect: [ :pageName | 
							(self cachedTopic2PageMap at: pageName)
								collect: [ :each | LeDatabase gtBook pageNamed: each ] ] ]
				ifFalse: [ (self cachedTopic2PageMap at: assoc value)
						collect: [ :each | LeDatabase gtBook pageNamed: each ] ] ]
]

{ #category : #views }
TopicMapOverview >> gtTopicMapFor: aView [
	<gtView>
	^ aView forward
		title: 'Page to Topic map';
		priority: 24;
		object: [ self top5TopicMap ];
		view: #gtTreeFor:context:;
		send: [ :assoc | LeDatabase gtBook pageNamed: assoc key ]
]

{ #category : #views }
TopicMapOverview >> gtTopicsFor: aView [
	<gtView>
	^ aView forward
		title: 'Topics';
		priority: 20;
		object: [ self topicsFromClusters ];
		view: #gtItemsFor:;
		send: [ :topic | 
			(self cachedTopic2PageMap at: topic)
				collect: [ :each | LeDatabase gtBook pageNamed: each ] ]
]

{ #category : #examples }
TopicMapOverview >> standardCategories [
	<gtExample>
	^ CategoryClassifierExperiments new standardCategories
]

{ #category : #examples }
TopicMapOverview >> top5TopicMap [
	<gtExample>
	^ TopicClassifierExperiments new top5TopicMap
]

{ #category : #examples }
TopicMapOverview >> topic2PageMap [
	"NB: This is computed each time."
	<gtExample>
	| dict |
	dict := Dictionary new.
	self top5TopicMap
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
