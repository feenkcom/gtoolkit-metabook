"
I am an abstract parent for PageClassifier experiments. I contain some utility methods that can be shared amongst the experiments.
"
Class {
	#name : #PCExperiments,
	#superclass : #Object,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #utility }
PCExperiments >> jsonFilePath [
	<gtExample>
	^ self jsonTestDirPath , '/' , thisContext sender selector , '.json'
]

{ #category : #examples }
PCExperiments >> jsonTestDirPath [
	<gtExample>
	^ 'feenkcom/gtoolkit-metabook/data/pc-json'
]
