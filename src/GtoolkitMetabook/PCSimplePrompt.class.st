Class {
	#name : #PCSimplePrompt,
	#superclass : #PCEntity,
	#instVars : [
		'promptString'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #'as yet unclassified' }
PCSimplePrompt >> jsonObject [
	^ self promptString
]

{ #category : #accessing }
PCSimplePrompt >> promptString [
	^ promptString
]

{ #category : #accessing }
PCSimplePrompt >> promptString: anObject [
	promptString := anObject
]
