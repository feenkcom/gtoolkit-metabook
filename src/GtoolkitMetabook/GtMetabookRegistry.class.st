"
I am a Singleton that maps Lepiter databases to databases of metapages. 

Metapages are accessed by LePage actions that appear if a metadatabase is defined.
The mappings from databases to metadatabases are defined in methods with the `<metabookMapping>` pragma.
These are retrieved by my `mappings` method. 
Additional mappings can be defined as extension methods.
If needed, send me `reset` so the registry will be recomputed.
"
Class {
	#name : #GtMetabookRegistry,
	#superclass : #Object,
	#instVars : [
		'mappings'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GtoolkitMetabook-Mapping'
}

{ #category : #'instance creation' }
GtMetabookRegistry class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
GtMetabookRegistry >> baseDatabaseFor: aDatabase [
	self assert: aDatabase hasBaseDatabase.
	^ (self mappings
		detect: [ :map | map metadatabaseName = aDatabase databaseName ])
		baseDatabase
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
	"Look for a metadatabase with this name."

	^ self mappings
		detect: [ :map | map metadatabaseName = aDatabase databaseName ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #accessing }
GtMetabookRegistry >> hasMetadatabase: aDatabase [
	"Look for a base database with this name."

	^ self mappings
		detect: [ :map | map baseDatabaseName = aDatabase databaseName ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #accessing }
GtMetabookRegistry >> mappingFor: aDatabase [
	^ self mappings
		detect: [ :map | 
			map baseDatabaseName = aDatabase databaseName
				or: [ map metadatabaseName = aDatabase databaseName ] ]
]

{ #category : #accessing }
GtMetabookRegistry >> mappings [
	"Gather the methods that define metabook mappings, and return their maps
	to use in building the registry dictionaries."

	^ mappings
		ifNil: [ mappings := self class methods
					select: [ :m | m hasPragmaNamed: 'metabookMapping' ]
					thenCollect: [ :m | m valueWithReceiver: self arguments: {} ] ]
]

{ #category : #accessing }
GtMetabookRegistry >> metadatabaseFor: aDatabase [
	self assert: aDatabase hasMetadatabase.
	^ (self mappings
		detect: [ :map | map baseDatabaseName = aDatabase databaseName ]) metadatabase
]

{ #category : #accessing }
GtMetabookRegistry >> repoNameFor: aDatabase [
	self mappings
		detect: [ :map | map baseDatabaseName = aDatabase databaseName ]
		ifFound: [ :map | ^ map baseRepoName ].
	self mappings
		detect: [ :map | map metadatabaseName = aDatabase databaseName ]
		ifFound: [ :map | ^ map metaRepoName ].
	^ nil
]

{ #category : #initialization }
GtMetabookRegistry >> reset [
	mappings := nil
]
