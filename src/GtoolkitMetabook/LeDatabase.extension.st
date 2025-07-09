Extension { #name : #LeDatabase }

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> baseDatabase [
	^ GtMetabookRegistry uniqueInstance baseDatabaseFor: self
]

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> hasBaseDatabase [
	^ GtMetabookRegistry uniqueInstance hasBaseDatabase: self
]

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> hasMetadatabase [
	^ GtMetabookRegistry uniqueInstance hasMetadatabase: self
]

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> metadatabase [
	^ GtMetabookRegistry uniqueInstance metadatabaseFor: self
]

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> repoName [
	^ GtMetabookRegistry uniqueInstance repoNameFor: self
]
