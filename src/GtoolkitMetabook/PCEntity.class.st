"
I am a common superclass for Page Classifier entities with JSON representation.
"
Class {
	#name : #PCEntity,
	#superclass : #Object,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #views }
PCEntity >> gtJsonFor: aView [
	<gtView>
	^ aView forward
		title: 'JSON object';
		priority: 40;
		object: [ self jsonObject asGtJson ];
		view: #gtJsonObjectFor:context:
]

{ #category : #views }
PCEntity >> gtJsonStringFor: aView [
	<gtView>
	^ aView forward
		title: 'JSON string';
		priority: 41;
		object: [ self jsonObject asGtJson ];
		view: #gtJsonStringFor:;
		actionUpdateButton
]

{ #category : #converting }
PCEntity >> jsonObject [
	self subclassResponsibility
]

{ #category : #printing }
PCEntity >> jsonString [
	^ STON toJsonString: self jsonObject
]
