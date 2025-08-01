"
I extend a simple prompt with a list of examples and expected answers.
My JSON includes the starting prompt and the list of page titles and answers, 
rather than the fully generated prompt including the bodies of the example pages.
"
Class {
	#name : #PCExampleBasedPrompt,
	#superclass : #PCSimplePrompt,
	#instVars : [
		'exampleDatabase',
		'examples'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #accessing }
PCExampleBasedPrompt >> exampleDatabase [
	^ exampleDatabase
]

{ #category : #accessing }
PCExampleBasedPrompt >> exampleDatabaseNamed: aString [
	exampleDatabase := LeDatabase databaseNamed: aString
]

{ #category : #accessing }
PCExampleBasedPrompt >> examples [
	^ examples
]

{ #category : #accessing }
PCExampleBasedPrompt >> examples: aDictionary [
	"The dictionary maps page titles (Strings) to answers (Strings)."

	examples := aDictionary
]

{ #category : #accessing }
PCExampleBasedPrompt >> examplesJSON [
	^ (self examples associations
		collect: [ :keyVal | 
			{'pageName' -> keyVal key.
				'answer' -> keyVal value} asDictionary ]) asArray
]

{ #category : #converting }
PCExampleBasedPrompt >> jsonObject [
	| json |
	json := super jsonObject.
	json at: 'exampleDatabaseName' put: self exampleDatabase databaseName.
	json at: 'examples' put: self examplesJSON.
	^ json
]

{ #category : #accessing }
PCExampleBasedPrompt >> value [
	"Problem -- the page contents may also contain triple backquotes."

	| writeStream |
	writeStream := '' writeStream.
	writeStream nextPutAll: self promptString.

	self examples
		associationsDo: [ :keyVal | 
			| page pageString |
			page := self exampleDatabase pageNamed: keyVal key.
			pageString := ((GtLlmPageExporter new
					page: page;
					export) copyReplaceAll: '```' with: '`')
					copyReplaceAll: String cr
					with: String lf.
			writeStream
				lf;
				lf;
				nextPutAll: 'User:';
				lf;
				nextPutAll: '```';
				lf;
				nextPutAll: pageString;
				lf;
				nextPutAll: '```';
				lf;
				lf;
				nextPutAll: 'Assistant:';
				lf;
				nextPutAll: '```';
				lf;
				nextPutAll: keyVal value;
				lf;
				nextPutAll: '```';
				lf ].
	^ writeStream contents
]
