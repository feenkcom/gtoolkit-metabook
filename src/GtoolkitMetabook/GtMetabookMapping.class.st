"
I specify a mapping from a base Lepiter database to a metadatabase.

I am initialized with an array consisting of the base database and repo names followed by the meta database and repo names.
"
Class {
	#name : #GtMetabookMapping,
	#superclass : #Object,
	#instVars : [
		'map'
	],
	#category : #'GtoolkitMetabook-Mapping'
}

{ #category : #'instance creation' }
GtMetabookMapping class >> forMap: aMetadatabaseMapArray [
	"Mappings are of the form:
		{base database name . base database repo name .
			meta database name . metadatabase repo name}"

	^ self new
		map: aMetadatabaseMapArray;
		yourself
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
GtMetabookMapping >> map: anObject [
	map := anObject
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
