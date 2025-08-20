"
I am a collection of example-based prompt classifiers for categories of pages.
Each example is an experiment stored in a json file.
The experiments ask an assistant to propose categories of pages, given a list of suggestions.
New categories may be proposed.

TO DO: after mining a list of categories from all pages, we edit the resulting list as use it as a canonical list for assigning categories to pages.
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
	"A more detailed prompt describing categories, with examples from specific pages."

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

- Introduction: a page that introduces a topic, usually with little or no code.
- Video: a page pointing the reader to an on-line video for a given topic.
- Case study: a page describing an existing case study that illustrates a topic, with detailed code examples.
- Tutorial: a page containing a step-by-step series of explanations and exercises with code to teach the reader about a topic. Whereas a case study focuses on a specific application, a tutorial focuses on how to acquire a specfic skill.
- Pattern: a pattern describes a recurring design problem and its solution. A pattern must include sections describing the Context, the Problem, Forces, and Solution, and may also have sections Steps and Examples.
- FAQ: a page containing a "how to" question related to a topic, with a detailed answer to just that question. The title will often start with "How to".
- Definition: a page whose title is a term and whose contents consists of a concise definition of that term.
- Tag: a page whose title consist of a single word identifying a topic, and little or no contents, to be used as a tag in other pages on that topic. A tag never has a title of more than two words.

These are some of the most important categories, but there may be others as well.

Your task is to assign a category to a page provided as input. A single answer is preferred, but in case of doubt, please propose two or even three alternatives.

Note that the category Video is preferred instead of Tutorial or FAQ, and FAQ is preferred over Definition.

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
	"A more refined prompt, adding more examples and the Pattern category."

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

{ #category : #examples }
CategoryClassifierExperiments >> cat3DetailedPromptCategoryClassifier2 [
	"Same prompt, but run on the whole book."

	<gtExample>
	<noTest>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			prompt: self cat2DetailedPrompt2;
			pages: self gtBookAllPages;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #'as yet unclassified' }
CategoryClassifierExperiments >> cat4CategoryMapFile [
	"The JSON file produced from CategoryClassifierExperiments>>#cat4DetailedPromptCategoryClassifier4"

	<gtExample>
	^ FileLocator gtResource
		/ 'feenkcom/gtoolkit-metabook/data/pc-json/cat4DetailedPromptCategoryClassifier4.json'
]

{ #category : #examples }
CategoryClassifierExperiments >> cat4DetailedPrompt3 [
	"Refined prompt, fixing the categories as a result of the analysis of expt 3."

	<gtExample>
	| prompt |
	prompt := PCExampleBasedPrompt new
			promptString: 'The Glamorous Toolkit Book consists of numerous notebook pages documenting various aspects of Moldable Development and the Glamorous Toolkit (GT) IDE that supports it.
We are interested in categorizing the pages according to the kind of information they contain.

Here is a description of each of the categories:

- Introduction: a page that introduces a topic, usually with little or no code.
- Media: a page pointing the reader to a slideshow or an on-line video for a given topic.
- Case study: a page describing an existing case study that illustrates a topic, with detailed code examples.
- Examples: a page listing one or more examples of a tool or technique, but not a proper case study.
- Tutorial: a page containing a step-by-step series of explanations and exercises with code to teach the reader about a topic. Whereas a case study focuses on a specific application, a tutorial focuses on how to acquire a specific skill. A tutorial often takes the form of an exercise to be performed by the reader.
- Pattern: a pattern describes a recurring design problem and its solution. A pattern must include sections describing the Context, the Problem, Forces, and Solution, and may also have sections Steps and Examples.
- FAQ: a page containing a "how to" question related to a topic, with a detailed answer to just that question. The title will often start with "How to".
- Index: a structuring page that serves only to point to or list other pages.
- Definition: a page whose title is a term and whose contents consists of a concise definition of that term.
- Tag: a page whose title consist of a single word identifying a topic, and little or no contents, to be used as a tag in other pages on that topic. A tag never has a title of more than two words.
- Documentation: a page containing a technical description, a set of metrics, release notes, or other details of some component or API.

Your task is to assign a category to a page provided as input. A single answer is preferred, but in case of doubt, please propose two, or at most three alternatives.

Note that the category Video is preferred instead of Tutorial or FAQ, and FAQ is preferred over Definition.
The category Documentation should be used as a default only if none of the other categories fits.
Do not propose any new categories.

In your answers, simply provide the category without any further explanation.

Below follows a series of examples of User inputs consisting of notebook page contents, and the expected Assistant category as an answer.';
			exampleDatabaseNamed: 'feenkcom/gtoolkit-metabook/gtbook-examples';
			examples: {'Glamorous Toolkit' -> 'Introduction'.
					'Getting started with GT in 7''' -> 'Media'.
					'Working with a REST API: the GitHub case study' -> 'Case study'.
					'Treemap' -> 'Examples'.
					'A gentle introduction to Pharo Smalltalk' -> 'Tutorial'.
					'Custom View' -> 'Pattern'.
					'How do I recover my work after a crash?' -> 'FAQ'.
					'How to pages related to GemStone' -> 'Index'.
					'Coder' -> 'Definition'.
					'Java' -> 'Tag'.
					'Basic shortcuts' -> 'Documentation'
					} asDictionary;
			yourself.
	^ prompt
]

{ #category : #examples }
CategoryClassifierExperiments >> cat4DetailedPromptCategoryClassifier4 [
	"New experiment on the entire bookm with the revised category list."

	<gtExample>
	<noTest>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			prompt: self cat4DetailedPrompt3;
			pages: self gtBookAllPages;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #examples }
CategoryClassifierExperiments >> categoryMap [
	"Map from page names to categories."

	<gtExample>
	| jsonString json chats emptyResults notEmptyResults dict |
	jsonString := CategoryClassifierExperiments new cat4CategoryMapFile contents.

	json := STON fromString: jsonString.
	chats := json at: 'chats'.
	emptyResults := chats select: [ :d | (d at: 'results') isEmpty ].	"self assert: emptyResults isEmpty."
	notEmptyResults := chats select: [ :d | (d at: 'results') notEmpty ].
	notEmptyResults do: [ :d | self assert: (d at: 'results') size equals: 1 ].
	dict := (notEmptyResults
			collect: [ :d | (d at: 'pageName') -> (d at: 'results') first ]) sorted
			asDictionary.
	^ dict
]

{ #category : #examples }
CategoryClassifierExperiments >> standardCategories [
	"This list is the outcome of analyzing the results of
	CategoryClassifierExperiments>>#cat3DetailedPromptCategoryClassifier2"

	<gtExample>
	^ {'Introduction'.
		'Media'.
		'Case study'.
		'Examples'.
		'Tutorial'.
		'Pattern'.
		'FAQ'.
		'Index'.
		'Definition'.
		'Tag'.
		'Documentation'}
]

{ #category : #examples }
CategoryClassifierExperiments >> standardCategoriesOLD [
	<gtExample>
	^ {'Introduction'.
		'Video'.
		'Case study'.
		'Tutorial'.
		'Pattern'.
		'FAQ'.
		'Definition'.
		'Tag'}
]
