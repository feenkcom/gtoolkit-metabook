"
I am a collection of example-based prompt classifiers for categories of pages.
Each example is an experiment stored in a json file.
"
Class {
	#name : #CategoryClassifierExperiments,
	#superclass : #PCExperiments,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #examples }
CategoryClassifierExperiments >> detailedPrompt1 [
	<gtExample>
	| prompt |
	prompt := PCExampleBasedPrompt new
			promptString: 'The Glamorous Toolkit Book consists of numerous notebook pages documenting various aspects of Moldable Development and the Glamorous Toolkit (GT) IDE that supports it.
We are interested in categorizing the pages according to the kind of information they contain.

Here is an incomplete list of some of the categories:

Introduction: a page that introduces a topic
Video: a page pointing the reader to an on-line video for a given topic
Case study: a page describing an existing case study that illustrates a topic
Tutorial: a page containing a step-by-step series of explanations and exercises to teach the reader about a topic
FAQ: a page containing a "how to" question related to a topic, with a detailed answer to just that question
Definition: a page whose title is a term and whose contents consists of a concise definition of that term
Tag: a page with a single word title identifying a topic and little or no contents, to be used as a tag in other pages on that topic

These are some of the most important categories, but there may be others as well.

Your task is to assign a category to a page provided as input. A single answer is preferred, but in case of doubt, please propose two or even three alternatives. Also one of the categories listed above is preferred as an answer, but if none of those is a good fit, please propose a new category as one of the answers.

In your answers, simply provide the category without any further explanation.

Below follows a series of examples of User inputs consisting of notebook page contents, and the expected Assistant category as an answer.';
			exampleDatabaseNamed: 'feenkcom/gtoolkit-metabook/gtbook-examples';
			examples: {'Glamorous Toolkit' -> 'Introduction'.
					'Getting started with GT in 7''' -> 'Video'.
					'Working with a REST API: the GitHub case study' -> 'Case study'.
					'A gentle introduction to Pharo Smalltalk' -> 'Tutorial'.
					'How do I recover my work after a crash?' -> 'FAQ'.
					'Coder' -> 'Definition'.
					'Java' -> 'Tag'} asDictionary;
			yourself.
	^ prompt
]

{ #category : #examples }
CategoryClassifierExperiments >> detailedPromptCategoryClassifier1 [
	<gtExample>
	<noTest>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			prompt: self detailedPrompt1;
			pages: self gtBookSamplePages1;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #'as yet unclassified' }
CategoryClassifierExperiments >> gtBookSamplePages1 [
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

{ #category : #examples }
CategoryClassifierExperiments >> simpleCategoryClassifier1 [
	"A simple classifier with a basic prompt."

	<gtExample>
	<noTest>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			prompt: self simplePrompt;
			pages: self gtBookSamplePages1;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #examples }
CategoryClassifierExperiments >> simplePrompt [
	"The simple basic prompt from the tests."

	<gtExample>
	^ PageClassifierExamples new simpleExampleBasedPrompt
]
