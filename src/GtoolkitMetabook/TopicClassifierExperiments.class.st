"
Experiments in generating topics for pages.
"
Class {
	#name : #TopicClassifierExperiments,
	#superclass : #PCAbstractExamples,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #'as yet unclassified' }
TopicClassifierExperiments >> groupTopicsJsonString [
	"We add `Using Magritte` after discovering it as a missing topic."

	<gtExample>
	^ '[
	[
		"Glamorous Toolkit Basics",
		[
			"About Glamorous Toolkit",
			"Book Organization and Navigation",
			"Community & Support",
			"Debugging in Glamorous Toolkit",
			"Explainable Systems",
			"Games and Simulations in Glamorous Toolkit",
			"Getting Started with GT",
			"GT Component Documentation",
			"Live Documentation",
			"Pharo Integration and Compatibility"
		]
	],
	[
		"Core infrastructure and skills",
		[
			"Algorithm Explanations",
			"Announcements and Event Handling",
			"Asynchronous Programming",
			"Code Analysis",
			"Code Configuration and Package Management",
			"Collections and Data Structures",
			"Deployment and Persistence",
			"Distributed and Remote Execution",
			"Domain Modeling",
			"Extension Methods",
			"Object-Oriented Programming Concepts",
			"Parsing and Language Manipulation",
			"Performance Analysis and Profiling",
			"Pragmas and Annotations",
			"Programming Smalltalk",
			"Recovering from Crashes",
			"Reflection and Metaprogramming",
			"Scripting and Automation",
			"Security and Authentication",
			"Smalltalk History",
			"Text Editing",
			"Utilities and Extensions",
			"Wardley Maps"
		]
	],
	[
		"Moldable Development topics",
		[
			"Building Custom Tools",
			"Examples and Documentation",
			"Inspector actions",
			"Inspector Views",
			"Moldable Development Practices",
			"Moldable Exceptions",
			"Querying and Navigating Code"
		]
	],
	[
		"Using GT components",
		[
			"Using Beacon",
			"Using Bloc",
			"Using Coder",
			"Using Lepiter",
			"Using Magritte",
			"Using Metacello",
			"Using Mondrian",
			"Using PetitParser",
			"Using SmaCC"
		]
	],
	[
		"Working with external systems",
		[
			"Working with Baselines and Dependencies",
			"Working with Bash",
			"Working with Cobol",
			"Working with External APIs",
			"Working with External Data",
			"Working with External Tools",
			"Working with GemStone",
			"Working with Git and GitHub",
			"Working with Java",
			"Working with JavaScript",
			"Working with Legacy Languages",
			"Working with LLMs",
			"Working with Python",
			"Working with React and React Native",
			"Working with Rust",
			"Working with the File System"
		]
	]
]'
]

{ #category : #'as yet unclassified' }
TopicClassifierExperiments >> groupedTopics [
	"This is a tentative grouping of topics -- to be refined and possibly stored in another format (a dictionary?)
	Possible groups are:
	- Glamorous Toolkit
	- Moldable Development
	- Core infrastructure and skills
	- Using GT components
	- Working with external systems and APIs"

	<gtExample>
	| json |
	json := STON fromString: self groupTopicsJsonString.
	self
		assert: (json flatCollect: #second) asSet
		equals: self topicsFromClusters asSet.
	^ json
]

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

{ #category : #examples }
TopicClassifierExperiments >> top1ClassifierWithTopicDescription [
	"Still a simple classifier but with a more detailed prompt describing newcomers and topics."

	<gtExample>
	| pc |
	pc := PageClassifier new
			resultType: 'Topic';
			prompt: self top1TopicDescriptionPrompt;
			pages: self gtBookSamplePages1;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #examples }
TopicClassifierExperiments >> top1TopicDescriptionPrompt [
	"A more detailed prompt describing newcomers and topics."

	<gtExample>
	| prompt |
	prompt := PCSimplePrompt new promptString:
'The Glamorous Toolkit (GT) Book consists of over 500 notebook pages documenting various aspects of Moldable Development and the GT IDE that supports it.

A typical newcomer to GT is either:
(i) someone who has heard of GT, and would like to learn more about it, but has no particular  goal in mind, or
(ii) someone with a specific problem to solve, whether work-related or a personal hobby project.
We want to provide newcomers with a roadmap of the pages organized around a set of 20-30 GT-related topics.

A good topic is high-level enough that we can assign multiple pages to a topic, but specific enough to be useful for finding relevant pages.

Examples of good topics:
- Understanding Moldable Development -- a baseline for a newcomer to build on.
- Programming Smalltalk -- something a newcomer needs to learn.
- Working with Python -- many newcomers have Python code bases.
- Moldable Development Patterns -- patterns offer a good way to explain moldable development, and they cross cut many tutorials and case studies.
- Reflection and Metaprogramming -- moldable development is about building lots of little tools, so many pages touch on reflective techniques and metaprogramming.

Examples of poor topics:
- Working with GraphSQL -- too specific for a cluster of pages.
- Glamorous Toolkit -- too broad; all the pages relate to GT.
- Method Wrappers -- too specific; this is just one particular reflective technique.

Your job is to assign topics to a given page, so that pages can be organized into clusters by topic.
Try to select good topics that can be used to effectively cluster pages.
Each page will cover at least one topic, but possible more, as topics cross-cut multiple dimensions.
Please provide only a single topic per page, unless the page clearly covers more than one topic, in which case a maximum of three topics may be listed.
Just list the topics and do not provide any further explanations.
'.
	^ prompt
]

{ #category : #examples }
TopicClassifierExperiments >> top2ClassifierWithTopicDescription [
	"Like top1 but with a larger dataset."

	<gtExample>
	| pc |
	pc := PageClassifier new
			resultType: 'Topic';
			prompt: self top1TopicDescriptionPrompt;
			pages: self gtBookSamplePages2;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #examples }
TopicClassifierExperiments >> top3ClassifierOnEntireGtBook [
	"Like top1 but with the complete GT book."

	<gtExample>
	| pc |
	pc := PageClassifier new
			resultType: 'Topic';
			prompt: self top1TopicDescriptionPrompt;
			pages: self gtBookAllPages;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #examples }
TopicClassifierExperiments >> top4ClassifierOnSamplePages [
	"We provide the curated list of topics in the prompt.
	We allow up to five topics per page (though we bundle 3-5 in the display)."

	<gtExample>
	| pc |
	pc := PageClassifier new
			resultType: 'Topic';
			prompt: self top4TopicDescriptionPrompt;
			pages: self gtBookSamplePages2;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #examples }
TopicClassifierExperiments >> top4TopicDescriptionPrompt [
	"Prompt that includes a curated list of topics."

	<gtExample>
	| prompt writeStream |
	writeStream := '' writeStream.
	writeStream
		nextPutAll: 'The Glamorous Toolkit (GT) Book consists of over 500 notebook pages documenting various aspects of Moldable Development and the GT IDE that supports it.

A typical newcomer to GT is either:
(i) someone who has heard of GT, and would like to learn more about it, but has no particular  goal in mind, or
(ii) someone with a specific problem to solve, whether work-related or a personal hobby project.
We want to provide newcomers with a roadmap of the pages organized around a set of GT-related topics.

The topic of a page refers to its subject matter, for example, "Using Bloc", or Programming Smalltalk", not the style or format of the page, such as "Tutorial" or "FAQ".

A good topic is high-level enough that we can assign multiple pages to a topic, but specific enough to be useful for finding relevant pages.

Your job is to assign topics from a curated list to a given page, so that pages can be organized into clusters by topic. Each page will cover at least one topic, but possible more, as topics cross-cut multiple dimensions. Please provide only a single topic per page, unless the page clearly covers more than one topic, in which case a maximum of five topics may be listed. You should only assign topics from the curated list, unless there is no topic that fits, in which case you may propose a topic not on the list. In your results, simply list the topics for the page and do not provide any further explanations.

Here is the list of curated topics:';
		lf;
		lf;
		nextPutAll: '```';
		lf.
	self topicsFromClusters
		do: [ :topic | 
			writeStream
				nextPutAll: topic;
				lf ].
	writeStream nextPutAll: '```'.
	prompt := PCSimplePrompt new promptString: writeStream contents.
	^ prompt
]

{ #category : #examples }
TopicClassifierExperiments >> top5ClassifierOnEntireGtBook [
	"We provide the curated list of topics in the prompt.
	We allow up to five topics per page (though we bundle 3-5 in the display)."

	<gtExample>
	| pc |
	pc := PageClassifier new
			resultType: 'Topic';
			prompt: self top4TopicDescriptionPrompt;
			pages: self gtBookAllPages;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #examples }
TopicClassifierExperiments >> top5ClassifierOnEntireGtBookEdited [
	"Same as TopicClassifierExperiments>>#top5ClassifierOnEntireGtBook
	but we manually edit the JSON to patch the extra topics."

	<gtExample>
	| pc |
	pc := PageClassifier new
			resultType: 'Topic';
			prompt: self top4TopicDescriptionPrompt;
			pages: self gtBookAllPages;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]

{ #category : #'as yet unclassified' }
TopicClassifierExperiments >> topicsFromClusters [
	"This is a list of topics obtained from the topic clustering experiments, 
	manually edited down to a list of ~60 specific topics that are not also categories.
	See TopicClassifierExperiments>>#groupedTopics for a possible grouping.
	"

	<gtExample>
	^ STON fromString: TopicClusteringExperiments new topicClustersExpt5ReducedFile
]
