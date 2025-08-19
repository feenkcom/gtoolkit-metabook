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

{ #category : #views }
PCSimplePrompt >> gtPromptFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Prompt';
		priority: 20;
		text: [ self value ];
		"styler: BrRBTextStyler new;"
		aptitude: [ BrGlamorousCodeEditorAptitude ]
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

{ #category : #printing }
PCSimplePrompt >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self class name;
		nextPutAll: ' new'; lf; tab;
		nextPutAll: 'promptString:';
		print: self promptString;
		nextPutAll: ';'; lf; tab;
		nextPutAll: ' yourself)'
]

{ #category : #accessing }
PCSimplePrompt >> value [
	^ self promptString
]
