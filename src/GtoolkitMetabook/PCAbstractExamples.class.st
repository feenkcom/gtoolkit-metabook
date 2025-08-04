"
I serve as an abstract parent for all PageClassifier examples and experiments, providing some useful utility methods.
"
Class {
	#name : #PCAbstractExamples,
	#superclass : #Object,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #'as yet unclassified' }
PCAbstractExamples >> gtBookSamplePages1 [
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
PCAbstractExamples >> gtBookSamplePages2 [
	"Somewhat random selection"
	<gtExample>
	<noTest>
	^ { 'A code size analysis' . 'A short history of Glamorous Toolkit' . 'About this version of Glamorous Toolkit' . 'Analysing the image size and its evolution' . 'Analyzing JavaScript React Native: the Zooniverse case study' . 'Analyzing Spring Boot RESTful web services' . 'Architectural report' . 'Brick' . 'Custom Action' . 'Editing Rust sources through the Language Server Protocol' . 'Example Object' . 'Explainable software' . 'Explaining the context menu and dropdown algorithm' . 'Explaining the text editor''s selection mechanism' . 'Exploring your Twitter data' . 'Futures' . 'Glamorous Toolkit' . 'How do I recover my work after a crash?' . 'How is the interrupt logic using primary+. working' . 'How to execute external commands' . 'How to pages related to GemStone' . 'How to programatically register a new database to a logical database' . 'How to set up a GT GitHub repo in 7''' . 'How to visualize the current knowledge base' . 'How to work with GitHub' . 'Implementing the Memory Game model' . 'Inspecting objects with custom views in 7''' . 'Introducing test examples and code cleaning' . 'Java' . 'Lepiter Iceberg Integration Model' . 'Lepiter' . 'Loader' . 'Loading GT server code into a non-Rowan stone' . 'Loading and managing code configurations with Metacello' . 'Managing LLM provider connections and setting the default' . 'Memory Game' . 'Method wrappers' . 'Modeling a Concrete Price' . 'OpenAI assistants' . 'PharoLink - Start manual server and client' . 'Profiling the user interface for a method styling' . 'Quantifying the need for custom tools' . 'React' . 'Remote' . 'Smalltalk Syntax in 7''' . 'The Moldable Development Environment' . 'Tooling patterns' . 'Understanding Lepiter in 7''' . 'Understanding Pharo built-in data types' . 'Understanding Smalltalk message syntax' . 'Understanding self and super' . 'WireEncoding in GemStone' . 'Working with AT Protocol' . 'Working with Python Bridge objects' . 'Working with the OpenAI API client' . 'World' . 'gt4magritte' . 'pandas' } collect: [ :title | LeDatabase gtBook pageNamed: title ]
]

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
