"
I hold a collection of chats from an existing PageClassifier instance, returned from a Spotter query.
"
Class {
	#name : #PCChatGroup,
	#superclass : #TraitHolderPCChatGroup,
	#instVars : [
		'pageClassifier'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #forwarding }
PCChatGroup >> addPages: aLePageCollection [
	self chats addAllLast: (self pageClassifier addPages: aLePageCollection)
]

{ #category : #forwarding }
PCChatGroup >> addRandomPages: aNumber [
	self chats addAllLast: (self pageClassifier addRandomPages: aNumber)
]

{ #category : #forwarding }
PCChatGroup >> announcer [
	"Should I have my own announcer?"

	^ self pageClassifier announcer
]

{ #category : #search }
PCChatGroup >> chatGroupWithItems: aChatCollection [
	"For use in Spotter searches"

	^ PCChatGroup new
		pageClassifier: self pageClassifier;
		initializeWith: aChatCollection;
		yourself
]

{ #category : #accessing }
PCChatGroup >> chats [
	^ self items
]

{ #category : #forwarding }
PCChatGroup >> database [
	^ self pageClassifier database
]

{ #category : #forwarding }
PCChatGroup >> freshCopy [
	^ self pageClassifier freshCopy
]

{ #category : #forwarding }
PCChatGroup >> jsonFile [
	^ self pageClassifier jsonFile
]

{ #category : #forwarding }
PCChatGroup >> jsonFileReference [
	^ self pageClassifier jsonFileReference
]

{ #category : #forwarding }
PCChatGroup >> jsonObject [
	^ self pageClassifier jsonObject
]

{ #category : #forwarding }
PCChatGroup >> loadJSONresults [
	^ self pageClassifier loadJSONresults
]

{ #category : #accessing }
PCChatGroup >> pageClassifier [
	^ pageClassifier
]

{ #category : #accessing }
PCChatGroup >> pageClassifier: anObject [
	pageClassifier := anObject
]

{ #category : #forwarding }
PCChatGroup >> prompt [
	^ self pageClassifier prompt
]

{ #category : #forwarding }
PCChatGroup >> saveToJSONfile [
	^ self pageClassifier saveToJSONfile
]
