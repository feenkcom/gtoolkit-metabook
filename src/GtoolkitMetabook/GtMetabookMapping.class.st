Class {
	#name : #GtMetabookMapping,
	#superclass : #Object,
	#instVars : [
		'map',
		'reverseMap'
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
GtMetabookMapping >> associations [
	^ {'Glamorous Toolkit Book' -> 'feenkcom/gtoolkit-metabook/gtmetabook'}
]

{ #category : #accessing }
GtMetabookMapping >> baseDatabaseFor: aPage [
	self assert: aPage hasBaseDatabase..
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
GtMetabookMapping >> hasMetapage: aPage [
	^ (self metadatabaseFor: aPage) hasPageNamed: aPage title
]

{ #category : #accessing }
GtMetabookMapping >> map [
	^ map ifNil: [ map := self associations asDictionary ]
]

{ #category : #accessing }
GtMetabookMapping >> metadatabaseFor: aPage [
	self assert: aPage hasMetadatabase.
	^ LeDatabase databaseNamed: (self map at: aPage database databaseName)
]

{ #category : #accessing }
GtMetabookMapping >> reset [
	map := nil.
	reverseMap := nil
]

{ #category : #accessing }
GtMetabookMapping >> reverseMap [
	^ reverseMap
		ifNil: [ reverseMap := (self associations
					collect: [ :assoc | assoc value -> assoc key ]) asDictionary ]
]
