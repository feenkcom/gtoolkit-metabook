Class {
	#name : #GtMetabookExtensions,
	#superclass : #Object,
	#instVars : [
		'extensionsEnabled'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GtoolkitMetabook-Configuration'
}

{ #category : #cleanup }
GtMetabookExtensions class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
GtMetabookExtensions class >> doesNotUnderstand: aMessage [
	"Forward unknown messages to my singleton, avoiding a proliferation of class forwarding methods."

	^ aMessage sendTo: self uniqueInstance
]

{ #category : #'class actions' }
GtMetabookExtensions class >> gtMetabookExtensionsMenuFor: anAction [
	<gtClassAction>
	<lePageAction>
	^ anAction dropdown
		icon: BrGlamorousVectorIcons hamburger;
		priority: 20;
		tooltip: 'Metabook Menu';
		content: [ :aButton | 
			BrGlamorousSimpleContextMenuContent new
				items: {'Enable extensions' -> [ GtMetabookExtensions uniqueInstance enableExtensions ].
						'Disable extensions' -> [ GtMetabookExtensions uniqueInstance disableExtensions ]};
				yourself ]
]

{ #category : #'instance creation' }
GtMetabookExtensions class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
GtMetabookExtensions >> disableExtensions [
	extensionsEnabled := false
]

{ #category : #accessing }
GtMetabookExtensions >> enableExtensions [
	extensionsEnabled := true
]

{ #category : #initialization }
GtMetabookExtensions >> extensionsEnabled [
	^ extensionsEnabled
]

{ #category : #initialization }
GtMetabookExtensions >> initialize [
	self disableExtensions
]
