Extension { #name : #LeDatabase }

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> baseDatabase [
	^ GtMetabookMapping baseDatabaseFor: self
]

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> hasBaseDatabase [
	^ GtMetabookMapping hasBaseDatabase: self
]

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> hasMetadatabase [
	^ GtMetabookMapping hasMetadatabase: self
]

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> metadatabase [
	^ GtMetabookMapping metadatabaseFor: self
]

{ #category : #'*GtoolkitMetabook' }
LeDatabase >> repoName [
	^ GtMetabookMapping repoNameFor: self
]
