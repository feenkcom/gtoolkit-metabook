Extension { #name : #LePage }

{ #category : #'*GtoolkitMetabook' }
LePage >> gtOpenInNewTabActionFor: anAction [
	<lePageAction>
	^ anAction button
		id: LeOpenPageInNewWorldTabElementId;
		tooltip: 'Open page in a new world tab';
		icon: BrGlamorousVectorIcons spawn;
		action: [ :aButton | 
			BlSpace new
				pageInPager: self;
				withSceneDriller;
				showFrom: aButton ]
]

{ #category : #'*GtoolkitMetabook' }
LePage >> gtOpenMetapageActionFor: anAction [
	"To do:
	- hide if no metadatabase exists
	- change appearance if metapage exists
	- open the metapage"

	<lePageAction>
	^ anAction button
		id: LeOpenMetapageElementId;
		tooltip: 'Open metapage';
		icon: BrGlamorousVectorIcons rightSide;
		action: [ :aButton | aButton phlow spawnObject: self ];
		primaryModifierAction: [ :aButton | aButton phlow showObject: self ]
]
