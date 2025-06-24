Extension { #name : #LePage }

{ #category : #'*GtoolkitMetabook' }
LePage >> createMetapage [
	| metaPage |
	self
		assert: self hasMetapage not
		description: 'This page already has a metapage.'.
	metaPage := (LePage named: self title)
			addSnippet: (LeTextSnippet new
					string: '(Edit metapage.)';
					yourself);
			yourself.

	self metadatabase addPage: metaPage.
	^ metaPage
]

{ #category : #'*GtoolkitMetabook' }
LePage >> gtOpenBasepageActionFor: anAction [
	<lePageAction>
	self hasMetadatabase ifFalse: [ ^ anAction empty ].
	^ self hasMetapage
		ifTrue: [ anAction button
				id: LeOpenMetapageElementId;
				tooltip: 'Open metapage';
				icon: GtMetabookVectorIcons rightSide;
				action: [ :aButton | aButton phlow spawnObject: self metapage ];
				primaryModifierAction: [ :aButton | aButton phlow showObject: self ] ]
		ifFalse: [ anAction button
				id: LeOpenMetapageElementId;
				tooltip: 'Create metapage';
				icon: GtMetabookVectorIcons fadedRightSide;
				action: [ :aButton | aButton phlow spawnObject: self createMetapage ];
				primaryModifierAction: [ :aButton | aButton phlow showObject: self ] ]
]

{ #category : #'*GtoolkitMetabook' }
LePage >> gtOpenMetapageActionFor: anAction [
	<lePageAction>
	self hasMetadatabase ifFalse: [ ^ anAction empty ].
	^ self hasMetapage
		ifTrue: [ anAction button
				id: LeOpenMetapageElementId;
				tooltip: 'Open metapage';
				icon: GtMetabookVectorIcons rightSide;
				action: [ :aButton | aButton phlow spawnObject: self metapage ];
				primaryModifierAction: [ :aButton | aButton phlow showObject: self ] ]
		ifFalse: [ anAction button
				id: LeOpenMetapageElementId;
				tooltip: 'Create metapage';
				icon: GtMetabookVectorIcons fadedRightSide;
				action: [ :aButton | aButton phlow spawnObject: self createMetapage ];
				primaryModifierAction: [ :aButton | aButton phlow showObject: self ] ]
]

{ #category : #'*GtoolkitMetabook' }
LePage >> hasMetadatabase [
	^ GtMetabookMapping hasMetadatabase: self
]

{ #category : #'*GtoolkitMetabook' }
LePage >> hasMetapage [
	^ self metadatabase hasPageNamed: self title
]

{ #category : #'*GtoolkitMetabook' }
LePage >> metadatabase [
self assert: self hasMetadatabase description: 'This page has no metadatabase'.
	^ GtMetabookMapping metadatabaseFor: self
]

{ #category : #'*GtoolkitMetabook' }
LePage >> metapage [
	self assert: self hasMetapage description: 'This page has no metapage.'.
	^ self metadatabase pageNamed: self title
]
