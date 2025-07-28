Class {
	#name : #PCSimplePrompt,
	#superclass : #PCEntity,
	#instVars : [
		'promptString'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #converting }
PCSimplePrompt >> asPrompt [
	^ self
]

{ #category : #converting }
PCSimplePrompt >> jsonObject [
	^ {'promptString' -> self promptString} asDictionary
]

{ #category : #accessing }
PCSimplePrompt >> promptString [
	^ promptString
]

{ #category : #accessing }
PCSimplePrompt >> promptString: anObject [
	promptString := anObject
]
