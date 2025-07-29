"
I am a collection of example-based prompt classifiers for categories of pages.
Each example is an experiment stored in a json file.
"
Class {
	#name : #CategoryClassifierExamples,
	#superclass : #Object,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #'as yet unclassified' }
CategoryClassifierExamples >> gtBookSamplePages1 [
	"We have: Introductions, Videos, Tutorials, Case studies, FAQs/HowTos, Terms, Tags"
	<gtExample>
	<noTest>
	^ {'Glamorous Toolkit'.
		'A short history of Glamorous Toolkit'.
		'Understanding Lepiter in 7'''.
		'Smalltalk Syntax in 7'''.
		'Exploring your Twitter data'.
		'Editing Rust sources through the Language Server Protocol'.
		'Understanding Smalltalk message syntax'.
		'Understanding self and super'.
		'Method wrappers'.
		'Implementing the Memory Game model'.
		'Explainable software'.
		'How do I recover my work after a crash?'.
		'How to programatically register a new database to a logical database'.
		'Futures'.
		'Brick'.
		'Working with the OpenAI API client'.
		'Java'.
		'React'} collect: [ :title | LeDatabase gtBook pageNamed: title ]
]

{ #category : #utility }
CategoryClassifierExamples >> jsonFilePath [
	^ self jsonTestDirPath , '/' , thisContext sender selector , '.json'
]

{ #category : #examples }
CategoryClassifierExamples >> jsonTestDirPath [
	<gtExample>
	^ 'feenkcom/gtoolkit-metabook/data/pc-json'
]

{ #category : #examples }
CategoryClassifierExamples >> simpleCategoryClassifier1 [
	<gtExample>
	<noTest>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			jsonFile: self jsonFilePath;
			prompt: PageClassifierExamples new simpleExampleBasedPrompt;
			pages: self gtBookSamplePages1;
			yourself.
	^ pc
]
