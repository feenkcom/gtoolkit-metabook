Class {
	#name : #PageClassifierExamples,
	#superclass : #Object,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #examples }
PageClassifierExamples >> basicPageClassifier [
	"A basic classifier for topics. The chats have not yet been activated."

	<gtExample>
	| pc |
	pc := PageClassifier new
			resultType: 'Topic';
			pages: self testPages;
			prompt: 'Propose up to three keywords for the above text, which is a page in the Glamorous Toolkit book.';
			yourself.
	self assert: pc pages size <= self exampleDatabase pages size.
	self assert: (pc chats flatCollect: #results) isEmpty.
	^ pc
]

{ #category : #examples }
PageClassifierExamples >> basicPageClassifierWithJsonFile [
	"A basic classifier for topics. The chats have not yet been activated."

	<gtExample>
	| pc |
	pc := self basicPageClassifier.
	self assert: (pc jsonObject includesKey: 'jsonFile') not.
	pc jsonFile: self basicPageClassifierWithJsonFilePath.
	self assert: (pc jsonObject includesKey: 'jsonFile').
	^ pc
]

{ #category : #examples }
PageClassifierExamples >> basicPageClassifierWithJsonFilePath [
	<gtExample>
	^ self jsonTestDirPath, '/basicPageClassifierExample.json'
]

{ #category : #examples }
PageClassifierExamples >> basicPageClassifierWithJsonFileReference [
	<gtExample>
	^ FileLocator gtResource / self basicPageClassifierWithJsonFilePath
]

{ #category : #examples }
PageClassifierExamples >> basicPageClassifierWithResults [
	"(Re-)Generate JSON file for use in basicPageClassifierWithResultsFromJSON.
	NB: run this manually. Not a test."

	<gtExample>
	<noTest>
	| pc |
	pc := self basicPageClassifier.
	pc jsonFile: self basicPageClassifierWithResultsJSONFilePath.
	pc requestResultsSync.
	pc saveToJSONfile.
	self assert: (pc chats flatCollect: #results) isNotEmpty.
	self assert: self jsonTestFileWithResults exists.
	self assert: self jsonTestFileWithResults contents isNotEmpty.
	^ pc
]

{ #category : #examples }
PageClassifierExamples >> basicPageClassifierWithResultsFromJSON [
	"Rebuilt from the JSON file.
	NB: the results are only loaded after explicitly sending loadJSONresults."

	<gtExample>
	| pc |
	"pc := PageClassifier
			fromJsonFilePath: PageClassifierExamples new basicPageClassifierWithResultsJSONFilePath."
	pc := self basicPageClassifier.
	self assert: pc pages size <= self exampleDatabase pages size.
	self assert: (pc chats flatCollect: #results) isEmpty.
	pc jsonFile: self basicPageClassifierWithResultsJSONFilePath.
	self assert: (pc chats flatCollect: #results) isEmpty.
	pc loadJSONresults.
	self assert: (pc chats flatCollect: #results) isNotEmpty.
	self assert: (pc jsonString) equals: (self jsonTestFileWithResults contents).
	
	^ pc
]

{ #category : #examples }
PageClassifierExamples >> basicPageClassifierWithResultsJSONFilePath [
	<gtExample>
	^ self jsonTestDirPath, '/basicPageClassifierExampleWithResults.json'
]

{ #category : #examples }
PageClassifierExamples >> basicPageClassifierWithResultsJSONFileReference [
	<gtExample>
	^ FileLocator gtResource / self basicPageClassifierWithResultsJSONFilePath
]

{ #category : #examples }
PageClassifierExamples >> browseStoredPCs [
	<gtExample>
	<noTest>
	^ (FileLocator gtResource / self jsonTestDirPath) files
		collect: [ :jf | PageClassifier new jsonFile: jf path pathString ]
]

{ #category : #examples }
PageClassifierExamples >> exampleBasedPageClassifier [
	"NB: the results are only initialized after the jsonFile path is set."

	<gtExample>
	| pc |
	pc := PageClassifier new
			resultType: 'Category';
			pages: self testPages;
			prompt: self simpleExampleBasedPrompt;
			yourself.
	self assert: (pc prompt isKindOf: PCExampleBasedPrompt).
	self assert: (pc chats flatCollect: #results) isEmpty.
	pc jsonFile: self exampleBasedPageClassifierJsonFilePath.
	pc loadJSONresults.
	self assert: (pc chats flatCollect: #results) isNotEmpty.
	^ pc
]

{ #category : #examples }
PageClassifierExamples >> exampleBasedPageClassifierFromJson [
	"Is everything properly initialized if we only provide the Json?"

	<gtExample>
	| pc |
	pc := PageClassifier new
			jsonFile: self exampleBasedPageClassifierJsonFilePath;
			loadJSONresults;
			yourself.
	self assert: pc resultType equals: 'Category'.
	self assert: pc jsonFile equals: self exampleBasedPageClassifierJsonFilePath.
	self assert: pc pages asSet equals: self testPages asSet.
	self assert: (pc prompt isKindOf: PCExampleBasedPrompt).
	self assert: pc prompt exampleDatabase equals: self exampleDatabase.
	self assert: (pc chats flatCollect: #results) isNotEmpty.
	^ pc
]

{ #category : #examples }
PageClassifierExamples >> exampleBasedPageClassifierJsonFilePath [
	<gtExample>
	^ self jsonTestDirPath , '/exampleBasedPageClassifierWithResults.json'
]

{ #category : #examples }
PageClassifierExamples >> exampleBasedPageClassifierJsonFileReference [
	<gtExample>
	^ FileLocator gtResource / self exampleBasedPageClassifierJsonFilePath
]

{ #category : #examples }
PageClassifierExamples >> exampleDatabase [
	"The example database is a collection of sample pages from the GT Book.
	NB: if this fails, then a sample page has been renamed in or removed from the book."

	<gtExample>
	| exampleDatabase |
	exampleDatabase := LeDatabase
			databaseNamed: 'feenkcom/gtoolkit-metabook/gtbook-examples'.
	exampleDatabase pages
		do: [ :page | self assert: (LeDatabase gtBook hasPageNamed: page title) ].
	^ exampleDatabase
]

{ #category : #examples }
PageClassifierExamples >> jsonTestDirPath [
	<gtExample>
	^ 'feenkcom/gtoolkit-metabook/data/pc-json'
]

{ #category : #examples }
PageClassifierExamples >> jsonTestFileWithResults [
	<gtExample>
	^ FileLocator gtResource / self basicPageClassifierWithResultsJSONFilePath
]

{ #category : #examples }
PageClassifierExamples >> newBasicPageClassifierFromJson [
	<gtExample>
	| pc newPC |
	pc := self basicPageClassifier.
	newPC := PageClassifier newFromJson: pc jsonObject.
	self assert: pc jsonObject equals: newPC jsonObject.
	self assert: pc jsonString equals: newPC jsonString.
	^ pc
]

{ #category : #examples }
PageClassifierExamples >> simpleExampleBasedPrompt [
	<gtExample>
	| prompt |
	prompt := PCExampleBasedPrompt new
			promptString: 'Please classify notebook pages into categories reflecting the kind of information they express, as in the following examples:';
			exampleDatabaseNamed: 'feenkcom/gtoolkit-metabook/gtbook-examples';
			examples: {'Glamorous Toolkit' -> 'Introduction'.
					'Getting started with GT in 7''' -> 'Video'.
					'Working with a REST API: the GitHub case study' -> 'Case study'.
					'A gentle introduction to Pharo Smalltalk' -> 'Tutorial'.
					'How do I recover my work after a crash?' -> 'FAQ'.
					'Coder' -> 'Terminology'.
					'Java' -> 'Tag'} asDictionary;
			yourself.
	^ prompt
]

{ #category : #examples }
PageClassifierExamples >> testPages [
	"Pages in the example database that are not part of the examples prompt, so can be used for testing."

	<gtExample>
	| testPages |
	testPages := {'A single starting point for scripting, linking and documenting'.
			'How to find stuff in GT in 7'''.
			'Working with AT Protocol'.
			'Querying objects'.
			'How to create a Lepiter page?'.
			'Debugger'.
			'Bloc'} collect: [ :title | self exampleDatabase pageNamed: title ].
	^ testPages
]
