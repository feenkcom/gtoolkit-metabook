Extension { #name : #LePage }

{ #category : #'*GtoolkitMetabook' }
LePage >> baseDatabase [
	self assert: self isMetapage description: 'This page is not a metapage.'.
	^ self database baseDatabase
]

{ #category : #'*GtoolkitMetabook' }
LePage >> basePage [
	self assert: self hasBasePage description: 'This metapage has no base page.'.
	^ self baseDatabase pageNamed: self title
]

{ #category : #'*GtoolkitMetabook' }
LePage >> createMetapage [
	| metaPage |
	self
		assert: self hasMetapage not
		description: 'This page already has a metapage.'.
	metaPage := (LePage named: self title)
			addSnippet: (LeTextSnippet new
					string: '';
					yourself);
			addSnippet: (LeTextSnippet new
					string: '*This is a metapage for ', self asRemoteLink, '* ';
					yourself);
			yourself.

	self metadatabase addPage: metaPage.
	^ metaPage
]

{ #category : #'*GtoolkitMetabook' }
LePage >> gtGitButtonFor: anAction [
	<lePageAction>
	| repoName repo |
	repoName := self repoName.
	repoName ifNil: [ ^ anAction empty ].
	repo := [ GtGitRepository forRepoNamed: repoName ]
			onErrorDo: [ ^ anAction empty ].
	^ anAction button
		tooltip: 'Go to repository';
		priority: 100;
		icon: BrGlamorousVectorIcons branching;
		id: GtCoderGitButtonId;
		action: [ :aButton | aButton phlow spawnTool: (GtGitPhlowTool new repository: repo) ]
]

{ #category : #'*GtoolkitMetabook' }
LePage >> gtMetadatabaseSummaryActionFor: anAction [
	"We need a better icon."

	<lePageAction>
	| baseDatabase |
	self database ifNil: [ ^ anAction noAction ].
	self database isDatabase ifFalse: [ ^ anAction noAction ].
	self hasMetadatabase
		ifTrue: [ baseDatabase := self database ]
		ifFalse: [ self isMetapage
				ifTrue: [ baseDatabase := self database baseDatabase ]
				ifFalse: [ ^ anAction noAction ] ].

	^ anAction button
		tooltip: 'Inspect the page''s meadatabase mapping';
		priority: 110;
		icon: LeIcons lepiterDatabase;
		id: LePageDatabaseActionId;
		action: [ :aButton | aButton phlow spawnObject: (GtMetabookSummary for: baseDatabase) ]
]

{ #category : #'*GtoolkitMetabook' }
LePage >> gtOpenBasepageActionFor: anAction [
	<lePageAction>
	self isMetapage ifFalse: [ ^ anAction empty ].
	self hasBasePage ifFalse: [ ^ anAction empty ].
	^ anAction button
		id: LeOpenMetapageElementId;
		tooltip: 'Open base page';
		priority: 90;
		icon: GtMetabookVectorIcons openBasePage;
		action: [ :aButton | aButton phlow spawnObject: self basePage ];
		primaryModifierAction: [ :aButton | aButton phlow showObject: self ]
]

{ #category : #'*GtoolkitMetabook' }
LePage >> gtOpenMetapageActionFor: anAction [
	<lePageAction>
	self hasMetadatabase ifFalse: [ ^ anAction empty ].
	^ anAction button
		tooltip: (self hasMetapage ifTrue: [ 'Open metapage' ] ifFalse: [ 'Create metapage' ]);
		id: LeOpenMetapageElementId;
		icon: (self hasMetapage
				ifTrue: [ GtMetabookVectorIcons openMetaPage ]
				ifFalse: [ GtMetabookVectorIcons createMetaPage ]);
		priority: 90;
		action: [ :aButton | 
			self hasMetapage
				ifTrue: [ aButton phlow spawnObject: self metapage ]
				ifFalse: [ aButton phlow spawnObject: self createMetapage ] ];
		primaryModifierAction: [ :aButton | aButton phlow showObject: self ]
]

{ #category : #'*GtoolkitMetabook' }
LePage >> hasBasePage [
	^ self baseDatabase hasPageNamed: self title
]

{ #category : #'*GtoolkitMetabook' }
LePage >> hasMetadatabase [
	^ self database hasMetadatabase
]

{ #category : #'*GtoolkitMetabook' }
LePage >> hasMetapage [
	^ self metadatabase hasPageNamed: self title
]

{ #category : #'*GtoolkitMetabook' }
LePage >> isMetapage [
	^ self database hasBaseDatabase
]

{ #category : #'*GtoolkitMetabook' }
LePage >> metadatabase [
	self assert: self hasMetadatabase description: 'This page has no metadatabase.'.
	^ self database metadatabase
]

{ #category : #'*GtoolkitMetabook' }
LePage >> metapage [
	self assert: self hasMetapage description: 'This page has no metapage.'.
	^ self metadatabase pageNamed: self title
]

{ #category : #'*GtoolkitMetabook' }
LePage >> repoName [
	^ self database repoName
]
