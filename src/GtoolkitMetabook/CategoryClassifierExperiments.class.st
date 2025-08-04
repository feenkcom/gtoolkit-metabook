"
I am a collection of example-based prompt classifiers for categories of pages.
Each example is an experiment stored in a json file.
"
Class {
	#name : #CategoryClassifierExperiments,
	#superclass : #PCAbstractExamples,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #examples }
CategoryClassifierExperiments >> cat0SimpleCategoryClassifier1 [
	"A simple classifier with a basic prompt."

	<gtExample>
	<noTest>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			prompt: self cat0SimplePrompt;
			pages: self gtBookSamplePages1;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #examples }
CategoryClassifierExperiments >> cat0SimplePrompt [
	"The simple basic prompt from the tests."

	<gtExample>
	^ PageClassifierExamples new simpleExampleBasedPrompt
]

{ #category : #examples }
CategoryClassifierExperiments >> cat1DetailedPrompt1 [
	<gtExample>
	| prompt |
	prompt := PCExampleBasedPrompt new
			promptString: 'The Glamorous Toolkit Book consists of numerous notebook pages documenting various aspects of Moldable Development and the Glamorous Toolkit (GT) IDE that supports it.
We are interested in categorizing the pages according to the kind of information they contain.

Here is an incomplete list of some of the categories:

Introduction: a page that introduces a topic, usually with little or no code.
Video: a page pointing the reader to an on-line video for a given topic.
Case study: a page describing an existing case study that illustrates a topic, with detailed code examples.
Tutorial: a page containing a step-by-step series of explanations and exercises with code to teach the reader about a topic. Whereas a case study focuses on a specific application, a tutorial focuses on how to acquire a specfic skill.
FAQ: a page containing a "how to" question related to a topic, with a detailed answer to just that question.
Definition: a page whose title is a term and whose contents consists of a concise definition of that term.
Tag: a page whose title consist of a single word identifying a topic, and little or no contents, to be used as a tag in other pages on that topic.

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
CategoryClassifierExperiments >> cat1DetailedPromptCategoryClassifier1 [
	<gtExample>
	<noTest>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			prompt: self cat1DetailedPrompt1;
			pages: self gtBookSamplePages1;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #examples }
CategoryClassifierExperiments >> cat2DetailedPrompt2 [
"Added Pattern."
	<gtExample>
	| prompt |
	prompt := PCExampleBasedPrompt new
			promptString: 'The Glamorous Toolkit Book consists of numerous notebook pages documenting various aspects of Moldable Development and the Glamorous Toolkit (GT) IDE that supports it.
We are interested in categorizing the pages according to the kind of information they contain.

Here is an incomplete list of some of the categories:

Introduction: a page that introduces a topic, usually with little or no code.
Video: a page pointing the reader to an on-line video for a given topic.
Case study: a page describing an existing case study that illustrates a topic, with detailed code examples.
Tutorial: a page containing a step-by-step series of explanations and exercises with code to teach the reader about a topic. Whereas a case study focuses on a specific application, a tutorial focuses on how to acquire a specfic skill.
Pattern: a pattern describes a recurring design problem and its solution. A pattern must include sections describing the Context, the Problem, Forces, and Solution, and may also have sections Steps and Examples.
FAQ: a page containing a "how to" question related to a topic, with a detailed answer to just that question. The title will often start with "How to".
Definition: a page whose title is a term and whose contents consists of a concise definition of that term.
Tag: a page whose title consist of a single word identifying a topic, and little or no contents, to be used as a tag in other pages on that topic. A tag never has a title of more than two words.

These are some of the most important categories, but there may be others as well.

Your task is to assign a category to a page provided as input. A single answer is preferred, but in case of doubt, please propose two or even three alternatives.

Note that the category Video is preferred instreda of Tutorial or FAQ, and FAQ is preferred over Definition.

Also one of the categories listed above is preferred as an answer, but if none of those is a good fit, please propose a new category as one of the answers.

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
CategoryClassifierExperiments >> cat2DetailedPromptCategoryClassifier2 [
	<gtExample>
	<noTest>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			prompt: self cat2DetailedPrompt2;
			pages: self gtBookSamplePages2;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]
