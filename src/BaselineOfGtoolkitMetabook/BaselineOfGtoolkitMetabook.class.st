Class {
	#name : #BaselineOfGtoolkitMetabook,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtoolkitMetabook
}

{ #category : #loading }
BaselineOfGtoolkitMetabook class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'gtoolkit-metabook' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfGtoolkitMetabook >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GtoolkitMetabook'
		]
]
