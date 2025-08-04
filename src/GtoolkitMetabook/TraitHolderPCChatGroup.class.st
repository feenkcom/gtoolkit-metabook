"
I exist only as a trait holder, so my subclasses do not have their API cluttered with trait methods.
"
Class {
	#name : #TraitHolderPCChatGroup,
	#superclass : #AbstractPCChatGroup,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #accessing }
TraitHolderPCChatGroup >> pages [
	self subclassResponsibility
]
