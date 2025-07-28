Class {
	#name : #PageClassifierExamples,
	#superclass : #Object,
	#category : #'GtoolkitMetabook-Examples'
}

{ #category : #examples }
PageClassifierExamples >> basicPageClassifier [
	"A basic classifier for topics. The chats have not yet been activated."

	<gtExample>
	| pc |
	pc := PageClassifier new
			resultType: 'Topic';
			pages: self exampleDatabase pages;
			prompt: 'Propose up to three keywords for the above text, which is a page in the Glamorous Toolkit book.';
			yourself.
	self assert: pc pages size equals: self exampleDatabase pages size.
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
	pc jsonFile: self jsonTestFilePath.
	self assert: (pc jsonObject includesKey: 'jsonFile').
	^ pc
]

{ #category : #examples }
PageClassifierExamples >> basicPageClassifierWithResults [
	"Rebuilt from the JSON file"

	<gtExample>
	| pc |
	pc := PageClassifier
			fromJsonFilePath: PageClassifierExamples new jsonTestFilePathWithResults.

	self assert: pc pages size equals: self exampleDatabase pages size.
	self assert: (pc chats flatCollect: #results) isNotEmpty.
	self assert: (pc jsonString) equals: (self jsonTestFileWithResults contents).
	
	^ pc
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
PageClassifierExamples >> jsonTestFile [
	<gtExample>
	^ FileLocator gtResource / self jsonTestFilePath
]

{ #category : #examples }
PageClassifierExamples >> jsonTestFilePath [
	<gtExample>
	^ self jsonTestDirPath, '/basicPageClassifierExample.json'
]

{ #category : #examples }
PageClassifierExamples >> jsonTestFilePathWithResults [
	<gtExample>
	^ self jsonTestDirPath, '/basicPageClassifierExampleWithResults.json'
]

{ #category : #examples }
PageClassifierExamples >> jsonTestFileWithResults [
	<gtExample>
	^ FileLocator gtResource / self jsonTestFilePathWithResults
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
