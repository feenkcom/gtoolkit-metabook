"
I specify a mapping from a base Lepiter database to a metadatabase.

I am initialized with an array consisting of the base database and repo names followed by the meta database and repo names.
"
Class {
	#name : #GtMetabookMapping,
	#superclass : #Object,
	#instVars : [
		'baseDatabaseName',
		'metadatabaseName',
		'baseRepoName',
		'metaRepoName'
	],
	#category : #'GtoolkitMetabook-Mapping'
}

{ #category : #'instance creation' }
GtMetabookMapping class >> forMap: aMetadatabaseMapArray [
	"Mappings are of the form:
		{base database name . base database repo name .
			meta database name . metadatabase repo name}"

	^ self new
		baseDatabaseName: aMetadatabaseMapArray first;
		baseRepoName: aMetadatabaseMapArray second;
		metadatabaseName: aMetadatabaseMapArray third;
		metaRepoName: aMetadatabaseMapArray fourth;
		yourself
]

{ #category : #accessing }
GtMetabookMapping >> baseDatabase [
	^ LeDatabase databaseNamed: self baseDatabaseName
]

{ #category : #accessing }
GtMetabookMapping >> baseDatabaseName [
	^ baseDatabaseName
]

{ #category : #accessing }
GtMetabookMapping >> baseDatabaseName: aString [
	baseDatabaseName := aString
]

{ #category : #accessing }
GtMetabookMapping >> baseRepoName [
	^ baseRepoName
]

{ #category : #'instance creation' }
GtMetabookMapping >> baseRepoName: aString [
	baseRepoName := aString
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
	^ {self baseDatabaseName.
		self baseRepoName.
		self metadatabaseName.
		self metaRepoName}
]

{ #category : #accessing }
GtMetabookMapping >> metaRepoName [
	^ metaRepoName
]

{ #category : #accessing }
GtMetabookMapping >> metaRepoName: aString [
	metaRepoName := aString
]

{ #category : #accessing }
GtMetabookMapping >> metadatabase [
	^ LeDatabase databaseNamed: self metadatabaseName
]

{ #category : #accessing }
GtMetabookMapping >> metadatabaseName [
	^ metadatabaseName
]

{ #category : #accessing }
GtMetabookMapping >> metadatabaseName: aString [
	metadatabaseName := aString
]

{ #category : #printing }
GtMetabookMapping >> storeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' forMap: ';
		print: self map
]
