"
Experiments in generating topics for pages.
"
Class {
	#name : #TopicClassifierExperiments,
	#superclass : #PCAbstractExamples,
	#category : #'GtoolkitMetabook-TopicMining'
}

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
			pages: LeDatabase gtBook pages;
			jsonFile: self jsonFilePath;
			loadJSONresults;
			yourself.
	^ pc
]
