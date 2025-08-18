Class {
	#name : #TopicClusteringExperiments,
	#superclass : #PCAbstractExamples,
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #examples }
TopicClusteringExperiments >> clus1TopicClusterChat [
	"We ask the assistant to propose 30 topics to replace the longer set we have.
	Each run is rather different, and only a few topics are stable."

	<gtExample>
	| chat |
	chat := GtLlmChat new.
	chat provider instructions: self clusteringPrompt1.
	chat provider format: PageClassifierChat new format.
	^ chat
]

{ #category : #examples }
TopicClusteringExperiments >> clus1TopicClusterChatResults [
	"Caveat: slow -- uses an ad hoc chat without a progress bar."

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
TopicClusteringExperiments >> clus2TopicClusterChat [
	"This time we ask it instead to cluster or group the existing topics, 
	and *then* propose a name to cover the group.
	NB: The prompt does not always succeed to give the expected answer.
	Insteda of all the answers it often just gives the first answer."

	<gtExample>
	| chat |
	chat := GtLlmChat new.
	chat provider instructions: self clusteringPrompt2.
	chat provider format: PageClassifierChat new format.
	^ chat
]

{ #category : #examples }
TopicClusteringExperiments >> clus2TopicClusterChatResults [
	"Caveat: slow -- uses an ad hoc chat without a progress bar."

	<gtExample>
	<noTest>
	| chat results |
	chat := self clus2TopicClusterChat.
	chat sendMessage: self topicMapJson.
	chat provider executions last wait.
	results := chat messages last contentJson at: 'results'.
	^ results
]

{ #category : #examples }
TopicClusteringExperiments >> clus2TopicClusterChatSavedResults1 [
	<gtExample>
	<noTest>
	^ #('["Understanding Moldable Development", "Understanding Moldable Development", "Learning Moldable Development", "Moldable Development Concepts", "Moldable Development Roles", "History of Glamorous Toolkit", "Glamorous Toolkit Overview", "Moldable Development", "Glamorous Toolkit Tutorials", "Book Organization and Navigation", "Mapping Moldable Development", "Program Comprehension and Code Reading", "Software Assessment Fundamentals", "Importance of Tools in Software Engineering", "Learning Moldable Development", "The Moldable Development Environment", "Explanations"]' '["Moldable Development Patterns", "Moldable Development Patterns", "Process and Workflow in Moldable Development", "Tooling Patterns", "Tool Creation Techniques", "Custom Tooling", "Moldable Tools and Extensions", "Moldable Tools", "Tool Prototyping and Custom Visualization", "Pattern-Oriented Moldable Development", "Explainable Software", "Explainable Systems", "Explainability and System Exploration", "Custom Views and Moldable Object Presentations", "Custom Visualization and Views", "Game Implementation Patterns", "Object-Oriented Design Patterns", "Refactoring Patterns in Moldable Development", "Tracking the state of the Ludo game play", "Process patterns", "Glamorous Toolkit as a case study", "Blind Spot", "Spotter and Custom Search Views", "Connector", "Tooling Buildup", "Tool Creation Techniques", "Moldable User Interfaces", "Inspector Views", "Custom Views and Presentations", "Throwaway Analysis Tool", "Tool Prototyping and Custom Visualization", "Futures", "LLM", "Extending the debugger through moldable exceptions", "Process Patterns in Moldable Development", "Modeling patterns", "Presenter", "Testing the Ludo corner cases", "Unit Testing and Examples", "Testing Phlow Views", "Moldable Data Wrapper", "Custom Tooling"]' '["Programming Smalltalk", "Programming Smalltalk", "Programming with GT Tools", "Programming Smalltalk in GT", "Pharo Programming", "Pharo Language Semantics", "Programming Smalltalk", "Programming Java", "Programming Smalltalk", "Programming Python", "Programming COBOL", "Working with Smalltalk", "Object-Oriented Programming Concepts", "Pharo and Smalltalk Architecture", "Programming Smalltalk"]' '["Reflection and Metaprogramming", "Metaprogramming and Reflection", "Reflection and Metaprogramming", "Querying Objects, Classes, and the Runtime", "Dynamic Language Features (doesNotUnderstand, Wrappers, Anonymous Classes)", "Introspection and Inspection", "Understanding reflection", "Introspection Techniques", "Overriding doesNotUnderstand:", "Reflection", "What is Reflection?", "What is Introspection?", "Querying objects", "Method wrappers", "Reflection and Metaprogramming"]' '["Working with Python", "Working with Python", "Working with Python Bridge", "GT-Python Integration", "Programming Python", "Python Integration and Bridge Architecture", "Working with Python source files", "Editing with Language Server Protocol", "Working with Shell Integrations", "GT LanguageLink Framework", "Snippet Interoperability", "Snippet Configuration and Environment Management", "Snippet Types", "Phlow for Python", "Python Debugger Setup & Example", "Working with Examples and Snippets", "pandas", "Exploring the execution of a Python LampSort algorithm", "PythonBridge custom views for pandas DataFrame and Series", "Inspecting Python objects with custom inspectors", "Basic usage of the Python Bridge", "Connecting to a remote Python Bridge instance", "Editing Python sources through the Language Server Protocol"]' '["Glamorous Toolkit Architecture and IDE", "Glamorous Toolkit Architecture", "Customizing the GT User Interface", "GT IDE Tour and Structure", "GT Book Organization", "Getting Started with GT", "Getting Started with Glamorous Toolkit", "Setting Up GT for Development", "IDE Components", "Entry Points and Tool Integration", "About this version of Glamorous Toolkit", "Setting Up GT for Development", "Technical Analyses", "GT Environment Tour"]' '["Case Studies and Tutorials", "Case Studies in Moldable Development", "Case Studies", "Case Studies and Real-World Examples", "Case Studies and Real-World Applications", "An Example of moldable logging using Beacon", "Ludo Game", "Memory Game", "Glamorous Toolkit as a case study"]' '["Inspector and Custom Views", "Inspector Views and Customization", "Inspector Customization", "Moldable Inspector Patterns", "Inspector Views and Actions", "Inspector actions", "Inspector Frameworks and Phlow", "Inspector Customization", "Phlow Framework", "Inspector actions", "Inspector actions", "Inspector customization", "Inspector Views"]' '["Visualization and Graphics", "Visualization in GT", "Visualization Techniques", "Visualizing Data Structures", "Visualizing Data and Graphs", "Visualizing Code and Data", "Visualizing and Editing Wardley Maps", "Building Graphical Visualizations", "Graph Visualization", "Treemap", "Pharo Integration and Patching", "Performance Profiling", "Visual Animations and Transitions", "Visualizing Code and Data", "Graphics and Visualization", "Custom Views and Visualization", "Data Visualization"]' '["Working with GemStone / GT4GemStone", "Working with GemStone", "GemStone/S Integration", "GT4GemStone Development", "Working with GemStone (Object Databases)", "Porting and Integration", "Integrating with GemStone", "Checking the loaded gt4gemstone version inside a GemStone extent", "Working with Remote Phlow", "Porting GT code to GemStone", "Connecting to the Gemstone repository", "Working with GemStone features", "Directly loading gt4gemstone into a Rowan stone for development", "Manually installing gt4gemstone into a GemStone extent", "Setting up the Gt4Gemstone connection"]' '["User Interface Development and Customization", "User Interface Development", "Building Custom UI Components", "Styling and Theming", "Customizing the GT User Interface", "UI Development with GT", "User Interface Components", "Widgets and User Interface Elements", "GT User Interface Customization", "User Interface Design in GT", "Programming Smalltalk", "Custom Widgets and UI components", "Custom widgets and UI components", "Bloc Visual Properties", "UI Scripting", "User Interface Programming", "UI Architecture", "Building Custom Assistants", "User Interface Layouts", "User Interface Components"]' '["Working with APIs, External Tools & Integration", "Integrating External Tools and Services", "Working with External Tools", "Integrating External Libraries", "Working with APIs", "Integrating External Services", "Integrating with External Systems", "Integration Techniques", "Integrating with External APIs", "Working with Large Language Models (LLMs)", "Working with AI and LLM Integrations", "Setting up Tooling in GT", "Integration with Databases", "Interfacing with External Services (APIs)", "Integrating and Managing LLM Providers"]' '["Testing, Quality Assurance, and Debugging", "Testing and Assertions", "Testing in Moldable Development", "Quality Assurance", "Error Handling", "Debugging and Diagnostics", "Debugging and Error Handling", "Testing and Quality Assurance", "Debugging in Glamorous Toolkit", "Debugging Tools and Techniques", "Debugging Techniques", "Debugging and Stack Inspection", "Unit Testing and Test-Driven Development", "Testing and Simulating UI Interactions", "Moldable Debugging", "Debugging Techniques in Glamorous Toolkit", "Debugging and Troubleshooting", "Testing the Ludo corner cases"]' '["Asynchronous Programming & Concurrency", "Asynchronous Programming", "Promises", "Futures", "Working with Futures, Streams, and Sinks", "Async Programming in GT", "Promises then:, asyncThen:, and then:otherwise: usage", "Running futures at user background priority", "Performance and Optimization"]' '["Working with Databases & Data Management", "Working with Databases", "Database Configuration and Management", "Managing Lepiter Databases", "Database Management", "Data Import and Integration", "Database Management in Glamorous Toolkit", "Persistence and Syncing"]' '["Version Control & Project Setup", "Working with Git and GitHub", "Working with Version Control", "Version Control Integration", "Version Control with Iceberg", "Using Metacello and Baselines", "Setting Up GT for Development", "Managing Releases and Versioning", "Version Control and Git Integration", "Source Code Version Control", "Configuring Version Control", "Maintaining Version Control and Collaboration", "Using the GT Coder", "Working with Git", "Version Control with GitHub"]' '["Scripting and Automation", "Scripting and Automation", "Automating Assistant Workflows", "UI Scripting in GT", "Scripting and Automation in GT", "Scripting in Glamorous Toolkit", "Tool Integration and Automation", "Automated Testing and Logging", "Customization and Scripting"]' '["Parsers, Grammar & Language Analysis", "Parsing Techniques", "Parsing and Grammars", "Language Design and Implementation", "Parsing with PetitParser2", "SmaCC Framework", "Grammar and Parsing Design", "AST and Parsing Internals", "Parsing and Syntax Trees", "Parsing and Code Analysis"]' '["Extending & Customizing GT", "Extending GT with Custom Tools", "Customizing Visualizations in Moldable Development", "Developer Extensions and Packages", "System Configuration and Customization", "Glamorous Toolkit Development", "Tool Extension Methods", "Extending the GT IDE", "Extensions and Interoperability", "Domain-Specific Extensions", "Developing with gt4gemstone"]' '["Learning and Tutorials", "Getting Started with GT", "Getting Started with Lepiter", "Beginner Tutorials", "Tutorials and Guided Examples", "Smalltalk Tutorials", "Example-driven Development", "Example-driven development tutorial", "Case Studies and Tutorials", "How to ...", "Guided Examples", "How-To Guides (General)", "How-To Guides", "FAQs"]' '["Live Documentation & Notebooks", "Live Documentation", "Lepiter Notebooks", "Lepiter Snippet Authoring", "Working with GT Notebooks", "Living Documentation", "Lepiter Architecture and Internals", "Moldable Documentation and Knowledge Management", "Managing Databases and Notebooks", "Lepiter Data Management", "Notebook and Page Usage", "Authoring with Lepiter", "Using the GT Editor", "Editing and Organizing Content", "Working with Lepiter Pages", "Page Navigation and Search"]' '["Project & Dependency Management", "Project Organization and Tracking", "Project and Dependency Management", "Managing Dependencies and Baselines", "Managing Dependencies with Metacello", "Project-specific Customization", "Authoring GT Book Pages", "Dependency Management", "Baselines and Package Management", "Package and Package Tag System in Pharo", "Migration from Pharo 11 to Pharo 12"]' '["Releases, Updates & Installation", "Releasing and Versioning", "Building and Releasing Glamorous Toolkit", "Installing and Updating Glamorous Toolkit", "Installing Glamorous Toolkit", "Installation and Configuration", "Working with GTWorld", "Setting Up and Updating GT", "Tooling and Automation for Moldable Development"]' '["Performance & Profiling", "Performance Profiling", "Performance Analysis and Profiling", "Profiling and Performance Analysis", "Performance and Optimization", "Performance Measurement", "Performance Optimization and Memory Management", "Performance Profiling in Glamorous Toolkit", "Virtual Machine Telemetry"]' '["Learning Other Languages & Interoperability", "Working with JavaScript", "Programming JavaScript", "Working with Rust", "Editing Code in External Languages", "Working with Java", "Programming Java", "Working with Legacy Languages", "Cross-language Integration", "Integrating External Languages", "Programming Languages and Interoperability", "Integrating Multiple Languages"]' '["Modular Architecture & Components", "Glamorous Toolkit Architecture", "Modules and Components", "IDE Components", "GT Architectural Internals", "Glamorous Toolkit Component Documentation", "Components"]' '["Managing the Codebase & Navigation", "Code Querying and Filters", "Searching and Navigation", "Code Navigation and Search", "Code Navigation and Exploration", "Code and Object Search", "Modeling and Visualizing Code", "Querying and Navigating Code", "Object Graph Traversal"]' '["Games & Educational Examples", "Board Game Modeling", "Game Development in GT", "Implementing Games in GT", "Game Modeling Tutorials (Memory Game, Ludo Game)", "Gaming and Simulation", "Example-Driven Development", "Implementing Board Games", "Prototyping in the Playground"]' '["Working with AI & Machine Learning", "Working with GenAI and LLMs", "Working with LLMs", "Integrating Large Language Models (LLMs)", "Working with Large Language Models", "Machine Learning Workflows", "Generative AI", "Integrating Large Language Models", "Embedding and Vector Search", "Integrating AI in Moldable Development", "Working with AI APIs", "Working with LLM APIs", "Fine-tuning Large Language Models"]' '["Data Representation & Modeling", "Domain Modeling", "Executable Domain-Driven Design", "Modeling with Example-Driven Development (EDD)", "Domain-Driven Design in Moldable Development", "Modeling Applications", "Domain Modeling in Moldable Development", "Modeling Money and Price Hierarchies"]' '["Log Analysis & Monitoring", "Logging and Diagnostics", "Debugging and Logging", "Log Analysis and Parsing", "Announcements and Event Handling", "Beacon", "Logging and Monitoring", "Live Visualization and Animation"]' '["System & Environment Configuration", "Configuring the GT Environment", "Environment Configuration", "System Initialization and Versioning", "Pharo Integration and Compatibility", "Patch Management and Upgrading", "Handling Language and Framework Evolution", "Setting Up and Customizing GT", "Configuration and Setup", "Configuring External Services"]' '["Knowledge Base, Documentation & Organization", "Documentation Navigation and Visualization", "Knowledge Base Management", "Organizing and Navigating Notebooks", "Table of Contents", "Glossary and Technology Overviews", "Interactive Documentation", "Documentation with Live Examples"]' '["File & Process Management", "Working with the File System", "Interfacing with External Processes", "Process and Resource Management", "Process Management", "Event Handling and User Interaction", "Variable Binding and Environment Management"]' '["Troubleshooting & Error Recovery", "Troubleshooting and Debugging", "Troubleshooting and Debugging GT", "Error Handling and Debugging", "Debugging and Error Handling", "Error Recovery and Troubleshooting", "Troubleshooting and Error Handling"]' '["Code Analysis & Metrics", "Code Analysis and Metrics", "Measuring and Analyzing the Knowledge Base", "Static Analysis and Code Quality", "Analyzing Feature Toggles", "Code Indexing and Metrics"]' '["Building & Extending Tools with AI", "Integrating AI in Moldable Development", "Building LLM-powered Assistants", "Extending GT with AI capabilities", "Customizing and Extending GT Assistants", "Using GT Book as a Knowledge Base", "Adding the GT book to a LLM to answer questions about GT"]' '["Community, Contribution & Support", "Community & Support", "Contributing to Glamorous Toolkit", "Contributing to Glamorous Toolkit through a GitHub pull request", "Another way to contribute to Glamorous Toolkit through a GitHub pull request"]' '["Pharo & GT Integration", "Pharo Integration", "PharoLink", "GT-Pharo Integration", "Pharo Integration and Patching", "PharoLink snippet", "Pharo Integration and Compatibility", "Handling Language and Framework Evolution"]' '["Widget, Layout & UI Libraries", "Working with Bloc", "Brick Widgets and UI Components", "Building User Interfaces with Bloc", "Widget Libraries", "Bloc UI Framework", "UI Composition", "User Interface Layout", "Building graphical interfaces with Bloc", "Bloc Elements", "Sparta", "Bloc"]' '["Session, State & Context Management", "Session Management", "Session State Management", "Process Management in GT", "Working with Temporary Objects"]' '["Release Engineering & CI", "Continuous Integration and Automation", "Release Engineering", "Release Process and Quality Assurance", "Automating Releases", "Loading and Release Analysis"]' '["Snippets & Examples", "Working with Examples and Snippets", "Example-driven Development", "Example Object", "Snippet Types"]')
]

{ #category : #examples }
TopicClusteringExperiments >> clus3TopicClusterChat [
	"This time we ask it instead to cluster or group the existing topics, 
	and *then* propose a name to cover the group."

	<gtExample>
	| chat |
	chat := GtLlmChat new.
	chat provider instructions: self clusteringPrompt3Simplified.
	chat provider format: PageClassifierChat new format.
	^ chat
]

{ #category : #examples }
TopicClusteringExperiments >> clus3TopicClusterChatResults [
	"The input here is just the list of topics, without duplicates."
	"Caveat: slow -- uses an ad hoc chat without a progress bar."

	<gtExample>
	<noTest>
	| chat results |
	chat := self clus3TopicClusterChat.
	chat sendMessage: self topicListJSON.
	chat provider executions last wait.
	results := chat messages last contentJson at: 'results'.
	^ results
]

{ #category : #examples }
TopicClusteringExperiments >> clus4TopicClusterChat [
	"We provide a specialized format for the list of groups."

	<gtExample>
	| chat |
	chat := GtLlmChat new.
	chat provider instructions: self clusteringPrompt4.
	chat provider format: self clusterFormat.
	^ chat
]

{ #category : #examples }
TopicClusteringExperiments >> clus4TopicClusterChatResults [
	"The input here is just the list of topics, without duplicates."
	"Caveat: slow -- uses an ad hoc chat without a progress bar."


	<gtExample>
	<noTest>
	| chat results |
	chat := self clus4TopicClusterChat.
	chat sendMessage: self topicListJSON.
	chat provider executions last wait.
	results := chat messages last contentJson at: 'results'.
	^ results
]

{ #category : #examples }
TopicClusteringExperiments >> clus5TopicClusterChat [
	"We provide a specialized format for the list of groups."

	<gtExample>
	| chat |
	chat := GtLlmChat new.
	chat provider instructions: self clusteringPrompt5.
	chat provider format: self clusterFormat.
	^ chat
]

{ #category : #examples }
TopicClusteringExperiments >> clus5TopicClusterChatResults [
	"Caveat: very slow -- uses an ad hoc chat without a progress bar."

	<gtExample>
	<noTest>
	| chat results |
	chat := self clus5TopicClusterChat.
	chat sendMessage: self topicListJSON.
	chat provider executions last wait.
	results := chat messages last contentJson at: 'results'.
	^ results
]

{ #category : #examples }
TopicClusteringExperiments >> clusterFormat [
	"We need a special format for the list of lists of results".

	^ {'type' -> 'object'.
		'properties'
			-> {'results'
						-> {'type' -> 'array'.
								'items'
									-> {'type' -> 'array'.
											'items' -> {'type' -> 'string'} asDictionary} asDictionary}
								asDictionary} asDictionary.
		'required' -> {'results'}.
		'additionalProperties' -> false} asDictionary
]

{ #category : #examples }
TopicClusteringExperiments >> clusteringPrompt1 [
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
TopicClusteringExperiments >> clusteringPrompt2 [
	"Similar to clusteringPrompt1, but in the end we ask it not just to propose new topics,
	but rather 30 clusters of topics, each with a representative topic name (existing or new)."

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

Your job is to partition the existing mined topics into thematic groups of similar topics, and to propose either one of the topic names in the group, or possibly a new topic name, to represent the group.

Please propose no more than 40 groups of topics. 

You should return a list of results.
Each result you return should consist of a JSON array of strings, where the first string is your proposed new topic name for a group, and the remaining strings are the original topics of that group.

Please just provide your proposal, without any further explanation.'
]

{ #category : #examples }
TopicClusteringExperiments >> clusteringPrompt3 [
	"This time the input is just the list of topics, and the output should be the partition, with the first string of each group being the selected topic."

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

The input that follows is a list of over 1000 topics mined from the book, which is far too many.

Your job is to partition the existing list of mined topics into thematic groups of similar topics.

Each result you return should consist of a JSON array of strings, where the first string is the topic to represent the group, and the rest are the remaining topics.

Please propose no more than 40 groups of topics.'
]

{ #category : #examples }
TopicClusteringExperiments >> clusteringPrompt3Simplified [
	"This time the input is just the list of topics, and the output should be the partition, with the first string of each group being the selected topic."

	<gtExample>
	^ 'The Glamorous Toolkit (GT) Book consists of over 500 notebook pages documenting various aspects of Moldable Development and the GT IDE that supports it.

The input that follows is a list of over 1000 topics mined from the book, which is far too many.

Your job is to partition the existing list of mined topics into thematic groups of similar topics.

Each result you return should consist of a JSON array of strings, where the first string is the topic to represent the group, and the rest are the remaining topics.

Please propose no more than 40 groups of topics.'
]

{ #category : #examples }
TopicClusteringExperiments >> clusteringPrompt4 [
	"Now the prompt should be in sync with the cluster format. 
	We iterate over the prompt to esnure that:
	(1) every topic appears in exactly one group
	(2) no new topics are introduced
	(3) we have a minimum of groups (ideally 40, but this may be overconstrained)
	We try leaving out the last requirement."

	<gtExample>
	^ 'The Glamorous Toolkit (GT) Book consists of over 500 notebook pages documenting various aspects of Moldable Development and the GT IDE that supports it.

The input that follows is a list of over 1000 topics mined from the book, which is far too many.

Your job is to partition the existing list of mined topics into thematic groups of similar topics.

Each result you return should consist of an array of topics, where the first one is the topic to represent the group, and the rest are the remaining topics. 

Do not introduce any new topics, but only select an existing topic to represent a group.
Make sure that every original topic appears in exactly one group.
'
]

{ #category : #examples }
TopicClusteringExperiments >> clusteringPrompt5 [
	"To simplify the task, we only ask the assistant to cluster the topics, nothing else."

	<gtExample>
	^ 'The Glamorous Toolkit (GT) Book consists of over 500 notebook pages documenting various aspects of Moldable Development and the GT IDE that supports it.

The input that follows is a list of over 1000 topics mined from the book, which is far too many.

Your job is to partition the existing list of mined topics into thematic groups of similar topics.

Please return a result for each group, consisting of the list of topics in that group.

Every topic from the input should appear in exactly one group of the output.
Just return the list of groups, without any further explanation.
'
]

{ #category : #examples }
TopicClusteringExperiments >> topic2pages [
	"Map the mined topics back to their pages. Needed to assess the clustering of topics."

	<gtExample>
	| topic2pages |
	topic2pages := Dictionary new.
	TopicClassifierExperiments new top3ClassifierOnEntireGtBook chats
		do: [ :chat | 
			chat results
				do: [ :topic | (topic2pages at: topic ifAbsentPut: [ OrderedCollection new ]) add: chat page ] ].
	^ topic2pages
]

{ #category : #examples }
TopicClusteringExperiments >> topicClusters [
	<gtExample>
	^ STON fromString: self topicClustersFile contents
]

{ #category : #examples }
TopicClusteringExperiments >> topicClustersExpt5File [
	"This is the output of Experiment 5, a list of 40 groups of topics (missing 93)."
	<gtExample>
	^ FileLocator gtResource
		/ 'feenkcom/gtoolkit-metabook/data/pc-json/topicClusters-v5.json'
]

{ #category : #examples }
TopicClusteringExperiments >> topicClustersExpt5ReducedFile [
	"This is a manually edited version of the output of Experiment 5, reducing the output to a smaller list of topics."
	<gtExample>
	^ FileLocator gtResource
		/ 'feenkcom/gtoolkit-metabook/data/pc-json/topicClusters-v5-reduced.json'
]

{ #category : #examples }
TopicClusteringExperiments >> topicClustersFile [
	"We backup a few versions:
	- v1 has too many new topics and missing topics
	- v2 has only 3 new topics but several hundred topics missing from the groups
	- v3 ..."
	<gtExample>
	^ FileLocator gtResource
		/ 'feenkcom/gtoolkit-metabook/data/pc-json/topicClusters.json'
]

{ #category : #examples }
TopicClusteringExperiments >> topicList [
	"Get the list of topics two ways and check they are the same."

	<gtExample>
	| topicList topicsFromMap |
	topicList := (TopicClassifierExperiments new top3ClassifierOnEntireGtBook chats
			flatCollect: [ :chat | chat results ]) asSet asSortedCollection asArray.

	topicsFromMap := (TopicClusteringExperiments new topicMap
			collect: [ :d | d at: 'results' ]) flatten asSet asSortedCollection asArray.
	self assert: topicList equals: topicsFromMap.

	^ topicList
]

{ #category : #examples }
TopicClusteringExperiments >> topicListJSON [
	<gtExample>
	^ STONJSON toStringPretty: self topicList asGtJson jsonObject
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
