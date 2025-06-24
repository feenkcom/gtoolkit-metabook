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
GtMetabookMapping >> baseDatabaseFor: aPage [
	self assert: aPage isMetapage.
	^ LeDatabase databaseNamed: (self reverseMap at: aPage database databaseName)
]

{ #category : #accessing }
GtMetabookMapping >> hasBaseDatabase: aPage [
	^ self reverseMap includesKey: aPage database databaseName
]

{ #category : #accessing }
GtMetabookMapping >> hasMetadatabase: aPage [
	^ self map includesKey: aPage database databaseName
]

{ #category : #accessing }
GtMetabookMapping >> map [
	^ map ifNil: [ map := (self mappings collect: [:each | each first -> each second ] ) asDictionary ]
]

{ #category : #accessing }
GtMetabookMapping >> mappings [
	"Add more mappings here. Mappings are of the form:
	{base database name . meta database name . metadatabase repo name}"

	^ {{'Glamorous Toolkit Book'.
			'feenkcom/gtoolkit-metabook/gtmetabook'.
			'gtoolkit-metabook'}}
]

{ #category : #accessing }
GtMetabookMapping >> metaRepoNameFor: aPage [
	self assert: aPage isMetapage.
	^ self repoMap at: aPage database databaseName
]

{ #category : #accessing }
GtMetabookMapping >> metadatabaseFor: aPage [
	self assert: aPage hasMetadatabase.
	^ LeDatabase databaseNamed: (self map at: aPage database databaseName)
]

{ #category : #accessing }
GtMetabookMapping >> repoMap [
	^ repoMap
		ifNil: [ repoMap := (self mappings collect: [ :each | each second -> each third ])
					asDictionary ]
]

{ #category : #accessing }
GtMetabookMapping >> reset [
	map := nil.
	reverseMap := nil.
	repoMap := nil
]

{ #category : #accessing }
GtMetabookMapping >> reverseMap [
	^ reverseMap
		ifNil: [ reverseMap := (self mappings collect: [ :each | each second -> each first ])
					asDictionary ]
]
