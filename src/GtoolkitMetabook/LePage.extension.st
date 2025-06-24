Extension { #name : #LePage }

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
