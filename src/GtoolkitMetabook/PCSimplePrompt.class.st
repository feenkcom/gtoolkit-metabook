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
	^ promptString copyReplaceAll: String cr with: String lf
]

{ #category : #accessing }
PCSimplePrompt >> promptString: anObject [
	promptString := anObject
]

{ #category : #accessing }
PCSimplePrompt >> value [
	^ self promptString
]
