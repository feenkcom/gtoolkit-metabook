Class {
	#name : #TopicClusteringExperiments,
	#superclass : #PCAbstractExamples,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #examples }
TopicClusteringExperiments >> clus1TopicClusterChat [
	<gtExample>
	| chat |
	chat := GtLlmChat new.
	chat provider instructions: self clusteringPrompt.
	chat provider format: PageClassifierChat new format.
	^ chat
]

{ #category : #examples }
TopicClusteringExperiments >> clus1TopicClusterChatResults [
	<gtExample>
	<noTest>
	| chat results |
	chat := self clus1TopicClusterChat.
	chat sendMessage: self topicMapJson.
	chat provider executions last wait.
	results := chat messages last contentJson at: 'results'.
	^ results
]

{ #category : #examples }
TopicClusteringExperiments >> clus1TopicClusterChatSavedResults1 [
	"Results from a run"

	<gtExample>
	^ #('Understanding Moldable Development' 'Getting Started with GT' 'Programming Smalltalk' 'Moldable Development Patterns' 'Reflection and Metaprogramming' 'Working with Python' 'User Interface Development and Customization' 'Visualization and Data Exploration' 'Working with External Tools and Integrations' 'Working with Lepiter and Notebooks' 'Version Control and Project Management' 'Debugging and Diagnostics' 'Testing and Quality Assurance' 'Performance Analysis and Optimization' 'Working with Databases and Persistence' 'Case Studies and Real-World Examples' 'Inspector Tooling and Custom Views' 'Asynchronous and Parallel Programming' 'Code Analysis, Querying, and Navigation' 'Installing, Updating, and Configuring GT' 'Working with GemStone' 'Working with Large Language Models and AI' 'Parsing and Language Tools (PetitParser, SmaCC)' 'Building and Extending Moldable Tools' 'Pharo and GT Integration' 'Scripting and Automation' 'Documentation and Live Examples' 'Working with JavaScript and Web Technologies' 'Game and Simulation Development' 'Contribution, Community and Support')
]

{ #category : #examples }
TopicClusteringExperiments >> clus1TopicClusterChatSavedResults2 [
	"Results from a run"

	<gtExample>
	^ #('Understanding Moldable Development' 'Programming Smalltalk' 'Building and Customizing User Interfaces' 'Reflection and Metaprogramming' 'Inspector Patterns and Views' 'Moldable Development Patterns' 'Working with Python' 'Working with GemStone & Object Databases' 'Integrating and Using External Tools & APIs' 'Program Analysis, Metrics & Visualization' 'Example-Driven Development & Tutorials' 'Version Control, Git & Project Management' 'Troubleshooting, Debugging & Diagnostics' 'Testing, QA & Test Patterns' 'Code Navigation, Search & Query Tools' 'Parsing, Grammar, and Language Integration' 'Working with Lepiter and Notebooks' 'Performance Optimization & Profiling' 'Pharo & GT Integration' 'Case Studies and Real-World Applications' 'Working with Large Language Models (LLMs) and AI' 'Domain-Driven Design & Domain Modeling' 'Managing Dependencies & Baselines' 'Extending GT with Custom Tools & Plugins' 'Building Games & Simulations' 'Deployment, Releases & Continuous Integration' 'Live & Executable Documentation' 'Data Handling: Import, Storage & Management' 'Widgets, Components & Bloc/Brick-based UI' 'Scripting & Automation in GT')
]

{ #category : #examples }
TopicClusteringExperiments >> clus1TopicClusterChatSavedResults3 [
	"Results from a run"

	<gtExample>
	^ #('Understanding Moldable Development' 'Programming Smalltalk and Pharo' 'Getting Started with GT and Setup' 'Moldable Development Patterns' 'Working with Python' 'Working with GemStone and Object Databases' 'Inspector and Custom Views' 'Reflection and Metaprogramming' 'Visualization and UI Development' 'Integrating with External APIs and Tools' 'Version Control and Project Management' 'Lepiter Notebooks and Knowledge Management' 'Debugging, Diagnostics, and Error Handling' 'Case Studies and Tutorials' 'Asynchronous Programming and Futures' 'Building and Customizing Tools' 'Testing and Quality Assurance' 'Performance Profiling and Optimization' 'Parsing, Syntax, and Code Analysis' 'Live Documentation and Example-Driven Development' 'Project Configuration and Dependency Management' 'Working with Large Language Models (LLMs) and GenAI' 'Releases and Environment Maintenance' 'Customizing the GT User Interface' 'Scripting and Automation' 'Integration with Other Languages (JavaScript, Rust, etc.)' 'Game and Domain Modeling' 'Pharo and GT Internals' 'Community, Contribution, and Support' 'Troubleshooting and How-to Guides')
]

{ #category : #examples }
TopicClusteringExperiments >> clusteringPrompt [
	<gtExample>
	^ 'The Glamorous Toolkit (GT) Book consists of over 500 notebook pages documenting various aspects of Moldable Development and the GT IDE that supports it.

In order to help guide newcomers to relevant documentation, we need to offer a roadmap that maps pages to a set of topics relevant to learning about GT.

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

The attached JSON string documents the titles of these pages, and, for each page, up to three possible topics that have been mined for that page. Currently there are far too many topics in this list. 

Your job is to propose a set of up to 30 topics that can be used to classify the pages of the book, and replace the existing mined topics. 
Try to select good topics that can be used to effectively cluster pages.
Each topic should match at least half a dozen pages.


Just list the new topics and do not provide any further explanation.
'
]

{ #category : #examples }
TopicClusteringExperiments >> topicMap [
	<gtExample>
	^ TopicClassifierExperiments new top3ClassifierOnEntireGtBook jsonObject
		at: 'chats'
]

{ #category : #examples }
TopicClusteringExperiments >> topicMapJson [
	<gtExample>
	^ STONJSON toStringPretty: self topicMap asGtJson jsonObject
]

{ #category : #examples }
TopicClusteringExperiments >> topicsSorted [
	<gtExample>
	^ (self topicMap flatCollect: [ :d | d at: 'results' ]) asBag sortedCounts
]
