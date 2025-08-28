Class {
	#name : #GtMetabookExtensions,
	#superclass : #Object,
	#traits : 'TGtEnableExtensions',
	#classTraits : 'TGtEnableExtensions classTrait',
	#instVars : [
		'extensionsEnabled'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GtoolkitMetabook-Configuration'
}

{ #category : #accessing }
GtMetabookExtensions class >> doesNotUnderstand: aMessage [
	"Forward unknown messages to my singleton, avoiding a proliferation of class forwarding methods."

	^ aMessage sendTo: self uniqueInstance
]

{ #category : #initialization }
GtMetabookExtensions >> initialize [
	self disableExtensions
]
