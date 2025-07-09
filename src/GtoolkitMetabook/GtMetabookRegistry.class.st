"
I am a Singleton that maps Lepiter databases to databases of metapages. 

Metapages are accessed by LePage actions that appear if a metadatabase is defined.
The mappings from databases to metadatabases are defined in methods with the `<metabookMapping>` pragma.
These are retrieved by my `mappings` method. 
Additional mappings can be defined as extension method.
If needed, send me `reset` so the registry dictionaries will be recomputed.
"
Class {
	#name : #GtMetabookRegistry,
	#superclass : #Object,
	#instVars : [
		'map',
		'reverseMap',
		'repoMap'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GtoolkitMetabook-Mapping'
}

{ #category : #accessing }
GtMetabookRegistry class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
GtMetabookRegistry >> baseDatabaseFor: aDatabase [
	self assert: aDatabase hasBaseDatabase.
	^ (self reverseMap at: aDatabase databaseName) baseDatabase
]

{ #category : #mapping }
GtMetabookRegistry >> gtBookMapping [
	<metabookMapping>
	^ GtMetabookMapping
		forMap: {'Glamorous Toolkit Book'.
				'gtoolkit'.
				'feenkcom/gtoolkit-metabook/gtmetabook'.
				'gtoolkit-metabook'}
]

{ #category : #accessing }
GtMetabookRegistry >> hasBaseDatabase: aDatabase [
	^ self reverseMap includesKey: aDatabase databaseName
]

{ #category : #accessing }
GtMetabookRegistry >> hasMetadatabase: aDatabase [
	^ self map includesKey: aDatabase databaseName
]

{ #category : #accessing }
GtMetabookRegistry >> map [
	"Map: base db name -> map"

	^ map
		ifNil: [ map := (self mappings collect: [ :each | each baseDatabaseName -> each ])
					asDictionary ]
]

{ #category : #accessing }
GtMetabookRegistry >> mappings [
	"Gather the methods that define metabook mappings, and return their maps
	to use in building the registry dictionaries."

	^ self class methods
		select: [ :m | m hasPragmaNamed: 'metabookMapping' ]
		thenCollect: [ :m | m valueWithReceiver: self arguments: {} ]
]

{ #category : #accessing }
GtMetabookRegistry >> metadatabaseFor: aDatabase [
	self assert: aDatabase hasMetadatabase.
	^ (self map at: aDatabase databaseName) metadatabase
]

{ #category : #accessing }
GtMetabookRegistry >> repoMap [
	^ repoMap
		ifNil: [ repoMap := ((self mappings collect: [ :each | each first -> each second ])
					, (self mappings collect: [ :each | each third -> each fourth ]))
					asDictionary ]
]

{ #category : #accessing }
GtMetabookRegistry >> repoNameFor: aDatabase [
	aDatabase hasMetadatabase
		ifTrue: [ ^ (self map at: aDatabase databaseName) baseRepoName ].
	aDatabase hasBaseDatabase
		ifTrue: [ ^ (self reverseMap at: aDatabase databaseName) metaRepoName ].
	^ nil
]

{ #category : #accessing }
GtMetabookRegistry >> reset [
	map := nil.
	reverseMap := nil.
	repoMap := nil
]

{ #category : #accessing }
GtMetabookRegistry >> reverseMap [
	"Map: meta db name -> map"

	^ reverseMap
		ifNil: [ reverseMap := (self mappings
					collect: [ :each | each metadatabaseName -> each ]) asDictionary ]
]
