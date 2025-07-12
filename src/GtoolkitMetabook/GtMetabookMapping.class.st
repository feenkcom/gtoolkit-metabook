"
I specify a mapping from a base Lepiter database to a metadatabase.

I am initialized with an array consisting of the base database and repo names followed by the meta database and repo names.

My mappings are defined in methods with the pragma `<mapping>`.
See `GtMetabookMapping>>#gtBookMapping` for an example.
More mappings can be defined as extension methods. 

The class methods `mappings` returns all the currently known mappings.
Query methods on the class side access this array.
"
Class {
	#name : #GtMetabookMapping,
	#superclass : #Object,
	#instVars : [
		'map'
	],
	#category : #'GtoolkitMetabook-Mapping'
}

{ #category : #querying }
GtMetabookMapping class >> baseDatabaseFor: aDatabase [
	self assert: aDatabase hasBaseDatabase.
	^ (self mappings
		detect: [ :map | map metadatabaseName = aDatabase databaseName ])
		baseDatabase
]

{ #category : #'instance creation' }
GtMetabookMapping class >> forMap: aMetadatabaseMapArray [
	^ self new
		map: aMetadatabaseMapArray;
		yourself
]

{ #category : #querying }
GtMetabookMapping class >> hasBaseDatabase: aDatabase [
	"Look for a metadatabase with this name."

	^ self mappings
		detect: [ :map | map metadatabaseName = aDatabase databaseName ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #querying }
GtMetabookMapping class >> hasMetadatabase: aDatabase [
	"Look for a base database with this name."

	^ self mappings
		detect: [ :map | map baseDatabaseName = aDatabase databaseName ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #querying }
GtMetabookMapping class >> mappingFor: aDatabase [
	^ self mappings
		detect: [ :map | 
			map baseDatabaseName = aDatabase databaseName
				or: [ map metadatabaseName = aDatabase databaseName ] ]
]

{ #category : #querying }
GtMetabookMapping class >> mappings [
	"Gather the methods that define metabook mappings, and return their maps
	to use in building the registry dictionaries."

	<todo: 'cache this in a class variable?'>
	^ self methods
		select: [ :m | m hasPragmaNamed: 'metabookMapping' ]
		thenCollect: [ :m | m valueWithReceiver: self arguments: {} ]
]

{ #category : #querying }
GtMetabookMapping class >> metadatabaseFor: aDatabase [
	self assert: aDatabase hasMetadatabase.
	^ (self mappings
		detect: [ :map | map baseDatabaseName = aDatabase databaseName ]) metadatabase
]

{ #category : #querying }
GtMetabookMapping class >> repoNameFor: aDatabase [
	self mappings
		detect: [ :map | map baseDatabaseName = aDatabase databaseName ]
		ifFound: [ :map | ^ map baseRepoName ].
	self mappings
		detect: [ :map | map metadatabaseName = aDatabase databaseName ]
		ifFound: [ :map | ^ map metaRepoName ].
	^ nil
]

{ #category : #accessing }
GtMetabookMapping >> baseDatabase [
	^ LeDatabase databaseNamed: self baseDatabaseName
]

{ #category : #accessing }
GtMetabookMapping >> baseDatabaseName [
	^ self map first
]

{ #category : #accessing }
GtMetabookMapping >> baseRepoName [
	^ self map second
]

{ #category : #mapping }
GtMetabookMapping >> gtBookMapping [
	<metabookMapping>
	^ GtMetabookMapping
		forMap: {'Glamorous Toolkit Book'.
				'gtoolkit'.
				'feenkcom/gtoolkit-metabook/gtmetabook'.
				'gtoolkit-metabook'}
]

{ #category : #printing }
GtMetabookMapping >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream
		nextPutAll: ' for ';
		nextPutAll: self baseDatabaseName
]

{ #category : #views }
GtMetabookMapping >> gtOrphanedMetaPagesFor: aView [
	"These pages have no base page. They might be standalone pages, or orphaned metapages whose base page has changed name."

	<gtView>
	^ aView columnedList
		title: 'Orphaned metapages';
		priority: 20;
		items: [ (self metadatabase pages reject: #hasBasePage) collect: #page ];
		column: 'Value' text: [ :each | each title ]
]

{ #category : #views }
GtMetabookMapping >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Metapage status';
		priority: 10;
		items: [ self baseDatabase tableOfContentsNodes ];
		children: #children;
		expandAll;
		column: 'Page'
			text: [ :each | each page title ]
			width: 400;
		column: 'Has Metapage'
			text: [ :each | 
				(each page isKindOf: LePage)
					ifTrue: [ each page hasMetapage ifTrue: [ '√' ] ifFalse: [ '-' ] ]
					ifFalse: [ 'x' ] ]
			width: 100;
		send: [ :each | each page ]
]

{ #category : #accessing }
GtMetabookMapping >> map [
	^ map
]

{ #category : #initialization }
GtMetabookMapping >> map: aMetadatabaseMapArray [
	"Mappings are of the form:
		{base database name . base database repo name .
			meta database name . metadatabase repo name}"
	map := aMetadatabaseMapArray
]

{ #category : #accessing }
GtMetabookMapping >> metaRepoName [
	^ self map fourth
]

{ #category : #accessing }
GtMetabookMapping >> metadatabase [
	^ LeDatabase databaseNamed: self metadatabaseName
]

{ #category : #accessing }
GtMetabookMapping >> metadatabaseName [
	^ self map third
]

{ #category : #printing }
GtMetabookMapping >> storeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' forMap: ';
		print: self map
]
