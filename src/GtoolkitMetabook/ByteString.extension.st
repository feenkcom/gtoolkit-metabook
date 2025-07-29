Extension { #name : #ByteString }

{ #category : #'*GtoolkitMetabook' }
ByteString >> asPrompt [
	^ PCSimplePrompt new
		promptString: self;
		yourself
]
