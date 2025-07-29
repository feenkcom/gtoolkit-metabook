Class {
	#name : #CategoryMinerExamples,
	#superclass : #Object,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #examples }
CategoryMinerExamples >> exampleBasedPageClassifier [
	"NB: the results are only initialized after the jsonFile path is set."

	<gtExample>
	<noTest>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			pages: self testPages;
			prompt: self simpleExampleBasedPrompt;
			jsonFile: self exampleBasedPageClassifierJsonFilePath;
			yourself.

	^ pc
]

{ #category : #examples }
CategoryMinerExamples >> jsonTestDirPath [
	<gtExample>
	^ 'feenkcom/gtoolkit-metabook/data/pc-json'
]
