"
I serve as an abstract parent for all PageClassifier examples and experiments, providing some useful utility methods.
"
Class {
	#name : #PCAbstractExamples,
	#superclass : #Object,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #utility }
PCAbstractExamples >> jsonFilePath [
	<gtExample>
	^ self jsonTestDirPath , '/' , thisContext sender selector , '.json'
]

{ #category : #examples }
PCAbstractExamples >> jsonTestDirPath [
	<gtExample>
	^ 'feenkcom/gtoolkit-metabook/data/pc-json'
]
