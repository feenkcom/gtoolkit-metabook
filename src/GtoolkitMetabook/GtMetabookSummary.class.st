"
I a summarize information about a base database and its meta database.
I exist mainly as a place to attach views that are interesting for metapages and their base pages.
"
Class {
	#name : #GtMetabookSummary,
	#superclass : #Object,
	#instVars : [
		'baseDatabase',
		'metadatabase'
	],
	#category : #'GtoolkitMetabook-Mapping'
}

{ #category : #accessing }
GtMetabookSummary class >> for: aLeDatabase [ 
^ self new
	baseDatabase: aLeDatabase;
	yourself
]

{ #category : #accessing }
GtMetabookSummary class >> forDatabaseNamed: aLeDatabaseName [
	^ self new
		baseDatabase: (LeDatabase databaseNamed: aLeDatabaseName);
		yourself
]

{ #category : #accessing }
GtMetabookSummary class >> forMetadatabase: aLeDatabase [
	self assert: aLeDatabase hasBaseDatabase.
	^ self for: aLeDatabase baseDatabase
]

{ #category : #accessing }
GtMetabookSummary >> baseDatabase: aLeDatabase [
	self assert: aLeDatabase hasMetadatabase.
	baseDatabase := aLeDatabase.
	metadatabase := baseDatabase metadatabase
]

{ #category : #printing }
GtMetabookSummary >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream
		nextPutAll: ' for ';
		nextPutAll: baseDatabase databaseName
]

{ #category : #views }
GtMetabookSummary >> gtOrphanedMetaPagesFor: aView [
	"These pages have no base page. They might be standalone pages, or orphaned metapages whose base page has changed name."

	<gtView>
	^ aView columnedList
		title: 'Orphaned metapages';
		priority: 20;
		items: [ (metadatabase pages reject: #hasBasePage) collect: #page ];
		column: 'Value' text: [ :each | each title ]
]

{ #category : #'as yet unclassified' }
GtMetabookSummary >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Metapage status';
		priority: 10;
		items: [ baseDatabase tableOfContentsNodes ];
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

{ #category : #printing }
GtMetabookSummary >> storeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' forDatabaseNamed: ''';
		nextPutAll: baseDatabase databaseName;
		nextPutAll: ''''
]
