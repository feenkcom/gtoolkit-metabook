Class {
	#name : #GtMetabookMapping,
	#superclass : #Object,
	#classInstVars : [
		'map'
	],
	#category : #'GtoolkitMetabook-Mapping'
}

{ #category : #accessing }
GtMetabookMapping class >> associations [
	^ {'Glamorous Toolkit Book' -> 'feenkcom/gtoolkit-metabook/gtmetabook'}
]

{ #category : #accessing }
GtMetabookMapping class >> hasMetadatabase: aPage [
	^ self map includesKey: aPage database databaseName
]

{ #category : #accessing }
GtMetabookMapping class >> hasMetapage: aPage [
	^ (self metadatabaseFor: aPage) hasPageNamed: aPage title
]

{ #category : #accessing }
GtMetabookMapping class >> map [
	^ map ifNil: [ map := self associations asDictionary ]
]

{ #category : #accessing }
GtMetabookMapping class >> metadatabaseFor: aPage [
	self assert: aPage hasMetadatabase.
	^ LeDatabase databaseNamed: (self map at: aPage database databaseName)
]

{ #category : #accessing }
GtMetabookMapping class >> reset [
	map := nil
]
