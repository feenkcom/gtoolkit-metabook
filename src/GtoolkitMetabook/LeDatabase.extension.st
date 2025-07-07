Extension { #name : #LeDatabase }

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> baseDatabase [
	^ GtMetabookMapping uniqueInstance baseDatabaseFor: self
]

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> hasBaseDatabase [
	^ GtMetabookMapping uniqueInstance hasBaseDatabase: self
]

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> hasMetadatabase [
	^ GtMetabookMapping uniqueInstance hasMetadatabase: self
]

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> metadatabase [
	^ GtMetabookMapping uniqueInstance metadatabaseFor: self
]
