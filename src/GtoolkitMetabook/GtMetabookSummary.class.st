"
I a summarize information about a base database and its meta database.
I exist mainly as a place to attach views that are interesting for metapages and their base pages.
"
Class {
	#name : #GtMetabookSummary,
	#superclass : #Object,
	#instVars : [
		'baseDatabase'
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
GtMetabookSummary >> baseDatabase: aLeDatabase [
"self assert: aLeDatabase "
	baseDatabase := aLeDatabase
]
