"
Experiments in generating topics for pages.
"
Class {
	#name : #TopicClassifierExperiments,
	#superclass : #PCAbstractExamples,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #examples }
TopicClassifierExperiments >> top0BasicClassifier [
	"Simple classifier with no examples, just a prompt.
	Results are mediocre."

	<gtExample>
	| pc |
	pc := PageClassifier new
			resultType: 'Topic';
			prompt: 'Propose up to three Topic keywords for the given text, which is a page in the Glamorous Toolkit book.';
			pages: self gtBookSamplePages1;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]
