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
CategoryClassifierExperiments >> ex0SimpleCategoryClassifier1 [
	"A simple classifier with a basic prompt."

	<gtExample>
	<noTest>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			prompt: self ex0SimplePrompt;
			pages: self gtBookSamplePages1;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #examples }
CategoryClassifierExperiments >> ex0SimplePrompt [
	"The simple basic prompt from the tests."

	<gtExample>
	^ PageClassifierExamples new simpleExampleBasedPrompt
]

{ #category : #examples }
CategoryClassifierExperiments >> ex1DetailedPrompt1 [
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
CategoryClassifierExperiments >> ex1DetailedPromptCategoryClassifier1 [
	<gtExample>
	<noTest>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			prompt: self ex1DetailedPrompt1;
			pages: self gtBookSamplePages1;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #examples }
CategoryClassifierExperiments >> ex2DetailedPrompt2 [
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
Pattern: a pattern describes a recurring design problem and its solution. A pattern typically cincludes sections describing the Context, the Problem, Forces, SOlution, Steps and Examples.
FAQ: a page containing a "how to" question related to a topic, with a detailed answer to just that question. The title will often start with "How to".
Definition: a page whose title is a term and whose contents consists of a concise definition of that term.
Tag: a page whose title consist of a single word identifying a topic, and little or no contents, to be used as a tag in other pages on that topic. A tag never has a title of more than two words.

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
CategoryClassifierExperiments >> ex2DetailedPromptCategoryClassifier2 [
	<gtExample>
	<noTest>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			prompt: self ex2DetailedPrompt2;
			pages: self gtBookSamplePages2;
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

{ #category : #'as yet unclassified' }
CategoryClassifierExperiments >> gtBookSamplePages2 [
	"Somewhat random selection"
	<gtExample>
	<noTest>
	^ { 'A code size analysis' . 'A short history of Glamorous Toolkit' . 'About this version of Glamorous Toolkit' . 'Analysing the image size and its evolution' . 'Analyzing JavaScript React Native: the Zooniverse case study' . 'Analyzing Spring Boot RESTful web services' . 'Architectural report' . 'Brick' . 'Custom Action' . 'Editing Rust sources through the Language Server Protocol' . 'Example Object' . 'Explainable software' . 'Explaining the context menu and dropdown algorithm' . 'Explaining the text editor''s selection mechanism' . 'Exploring your Twitter data' . 'Futures' . 'Glamorous Toolkit' . 'How do I recover my work after a crash?' . 'How is the interrupt logic using primary+. working' . 'How to execute external commands' . 'How to pages related to GemStone' . 'How to programatically register a new database to a logical database' . 'How to set up a GT GitHub repo in 7''' . 'How to visualize the current knowledge base' . 'How to work with GitHub' . 'Implementing the Memory Game model' . 'Inspecting objects with custom views in 7''' . 'Introducing test examples and code cleaning' . 'Java' . 'Lepiter Iceberg Integration Model' . 'Lepiter' . 'Loader' . 'Loading GT server code into a non-Rowan stone' . 'Loading and managing code configurations with Metacello' . 'Managing LLM provider connections and setting the default' . 'Memory Game' . 'Method wrappers' . 'Modeling a Concrete Price' . 'OpenAI assistants' . 'PharoLink - Start manual server and client' . 'Profiling the user interface for a method styling' . 'Quantifying the need for custom tools' . 'React' . 'Remote' . 'Smalltalk Syntax in 7''' . 'The Moldable Development Environment' . 'Tooling patterns' . 'Understanding Lepiter in 7''' . 'Understanding Pharo built-in data types' . 'Understanding Smalltalk message syntax' . 'Understanding self and super' . 'WireEncoding in GemStone' . 'Working with AT Protocol' . 'Working with Python Bridge objects' . 'Working with the OpenAI API client' . 'World' . 'gt4magritte' . 'pandas' } collect: [ :title | LeDatabase gtBook pageNamed: title ]
]
