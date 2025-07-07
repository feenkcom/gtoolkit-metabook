"
I am a Singleton that maps Lepiter databases to databases of metapages. 

Metapages are accessed by LePage actions that appear if a metadatabase is defined.
The mappings from databases to metadatabases is defined in my `mappings` method. 
Extend this to define more mappings.

(To do: define an API to add more mappings.)
"
Class {
	#name : #GtMetabookMapping,
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

{ #category : #'as yet unclassified' }
GtMetabookMapping class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
GtMetabookMapping >> baseDatabaseFor: aDatabase [
	self assert: aDatabase hasBaseDatabase.
	^ LeDatabase databaseNamed: (self reverseMap at: aDatabase databaseName)
]

{ #category : #accessing }
GtMetabookMapping >> hasBaseDatabase: aDatabase [
	^ self reverseMap includesKey: aDatabase databaseName
]

{ #category : #accessing }
GtMetabookMapping >> hasMetadatabase: aDatabase [
	^ self map includesKey: aDatabase databaseName
]

{ #category : #accessing }
GtMetabookMapping >> map [
	"Map: base db name -> meta db name"

	^ map
		ifNil: [ map := (self mappings collect: [ :each | each first -> each third ])
					asDictionary ]
]

{ #category : #accessing }
GtMetabookMapping >> mappings [
	"Add more mappings here. Mappings are of the form:
	{base database name . base database repo name .
		meta database name . metadatabase repo name}"

	^ {{'Glamorous Toolkit Book'.
			'gtoolkit'.
			'feenkcom/gtoolkit-metabook/gtmetabook'.
			'gtoolkit-metabook'}}
]

{ #category : #accessing }
GtMetabookMapping >> metadatabaseFor: aDatabase [
	self assert: aDatabase hasMetadatabase.
	^ LeDatabase databaseNamed: (self map at: aDatabase databaseName)
]

{ #category : #accessing }
GtMetabookMapping >> repoMap [
	^ repoMap
		ifNil: [ repoMap := ((self mappings collect: [ :each | each first -> each second ])
					, (self mappings collect: [ :each | each third -> each fourth ]))
					asDictionary ]
]

{ #category : #accessing }
GtMetabookMapping >> repoNameFor: aDatabase [
	^ self repoMap at: aDatabase databaseName ifAbsent: nil
]

{ #category : #accessing }
GtMetabookMapping >> reset [
	map := nil.
	reverseMap := nil.
	repoMap := nil
]

{ #category : #accessing }
GtMetabookMapping >> reverseMap [
	"Map: meta db name -> base db name"

	^ reverseMap
		ifNil: [ reverseMap := (self mappings collect: [ :each | each third -> each first ])
					asDictionary ]
]
