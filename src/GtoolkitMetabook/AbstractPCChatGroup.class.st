"
I am an abstract parent for entities that hold a collection of PC Chats.
"
Class {
	#name : #AbstractPCChatGroup,
	#superclass : #PCEntity,
	#instVars : [
		'process',
		'mutex'
	],
	#category : #'GtoolkitMetabook-TopicMining'
}

{ #category : #testing }
AbstractPCChatGroup class >> isAbstract [
	^ self == AbstractPCChatGroup
]

{ #category : #announcements }
AbstractPCChatGroup >> announcer [
	self subclassResponsibility
]

{ #category : #view }
AbstractPCChatGroup >> chats [
	self subclassResponsibility
]

{ #category : #'instance creation' }
AbstractPCChatGroup >> freshCopy [
	self subclassResponsibility
]

{ #category : #action }
AbstractPCChatGroup >> gtActionMenuFor: anAction [
	"Additional menu items to be added here ...
	 (add random pages, add pages matching a query, sort, etc)."

	<gtAction>
	^ anAction dropdown
		priority: 50;
		tooltip: 'Menu';
		icon: BrGlamorousVectorIcons hamburger;
		content: [ :aButton | 
			BrGlamorousSimpleContextMenuContent new
				items: {'Empty result chats'
							-> [ :e | 
								e phlow
									spawnObject: (self
											pcChatGroupWithItems: (self chats select: [ :chat | chat results isEmpty ])) ]};
				yourself ]
]

{ #category : #view }
AbstractPCChatGroup >> gtChatsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Chats';
		priority: 10;
		items: [ self chats ];
		column: 'Page'
			text: [ :each | each page title ]
			width: 300;
		column: 'Result[1]'
			text: [ :each | (each resultsWithDefaults: 3) first ]
			width: 150;
		column: 'Result[2]'
			text: [ :each | (each resultsWithDefaults: 3) second ]
			width: 150;
		column: 'Result[rest]'
			text: [ :each | '; ' join: ((each resultsWithDefaults: 3) allButFirst: 2) ]
			width: 150;
		actionUpdateButton;
		updateWhen: PCResultsUpdatedAnnouncement in: self announcer
]

{ #category : #action }
AbstractPCChatGroup >> gtClearResultsAction: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Clear the results';
		priority: 30;
		icon: BrGlamorousVectorIcons close;
		action: [ :aButton | self chats do: #clearResults ]
]

{ #category : #action }
AbstractPCChatGroup >> gtLoadResultsAction: anAction [
	<gtAction>
	self jsonFile ifNil: [ ^ anAction empty ].
	self jsonFile ifEmpty: [ ^ anAction empty ].
	^ anAction button
		tooltip: 'Load results from stored JSON';
		priority: 32;
		icon: BrGlamorousIcons loadfromdisk;
		action: [ :aButton | aButton phlow spawnObject: self loadJSONresults ]
]

{ #category : #view }
AbstractPCChatGroup >> gtPromptStringFor: aView [
	<gtView>
	^ aView forward
		title: 'Prompt';
		priority: 42;
		object: [ self prompt ];
		view: #gtPromptFor:;
		actionUpdateButton
]

{ #category : #action }
AbstractPCChatGroup >> gtSendRequestAction: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Send requests to chats' " missing results (' , self missingResults printString , ')'";
		priority: 20;
		icon: BrGlamorousVectorIcons play;
		action: [ :aButton | self requestResults ]
]

{ #category : #search }
AbstractPCChatGroup >> gtSpotterForPageContent: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page content';
		priority: 14;
		items: [ self chats ];
		itemsLimit: Float infinity;
		itemName: #pageString;
		sendCategory: [ :aCategory :aStep :thisSearch | self pcChatGroupWithItems: aCategory items contents ];
		filterBySubstring
]

{ #category : #search }
AbstractPCChatGroup >> gtSpotterForPageTitles: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page titles';
		priority: 12;
		items: [ self chats ];
		itemsLimit: Float infinity;
		itemName: #pageTitle;
		sendCategory: [ :aCategory :aStep :thisSearch | self pcChatGroupWithItems: aCategory items contents ];
		filterBySubstring
]

{ #category : #search }
AbstractPCChatGroup >> gtSpotterForResults: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page titles';
		priority: 16;
		items: [ self chats ];
		itemsLimit: Float infinity;
		itemName: #resultsJoined;
		sendCategory: [ :aCategory :aStep :thisSearch | self pcChatGroupWithItems: aCategory items contents ];
		filterBySubstring
]

{ #category : #action }
AbstractPCChatGroup >> gtStoreJSONAction: anAction [
	<gtAction>
	self jsonFile ifNil: [ ^ anAction empty ].
	self jsonFile ifEmpty: [ ^ anAction empty ].
	^ anAction button
		tooltip: 'Store JSON';
		priority: 40;
		icon: BrGlamorousIcons savetodisk;
		action: [ :aButton | aButton phlow spawnObject: self saveToJSONfile ]
]

{ #category : #initialization }
AbstractPCChatGroup >> initialize [
	super initialize.
	mutex := Mutex new.
]

{ #category : #accessing }
AbstractPCChatGroup >> jsonFile [
	self subclassResponsibility
]

{ #category : #serialization }
AbstractPCChatGroup >> loadJSONresults [
	self subclassResponsibility
]

{ #category : #serialization }
AbstractPCChatGroup >> pcChatGroupWithItems: aChatCollection [
	self subclassResponsibility
]

{ #category : #accessing }
AbstractPCChatGroup >> prompt [
	self subclassResponsibility
]

{ #category : #action }
AbstractPCChatGroup >> requestResults [
	"NB: Async version"

	| title jobs |
	mutex
		critical: [ process
				ifNil: [ title := 'Sending chat requests'.
					jobs := self chats collect: [ :chat | [ chat requestResults ] ].
					process := [ [ :job | 
						job title: title.
						jobs
							withIndexDo: [ :each :index | 
								job
									progress: index / jobs size;
									title: each printString.
								each value ] ] asJob run.	"NB: second CS is within the forked process"
						mutex critical: [ process := nil ] ] fork ]
				ifNotNil: [ self inform: 'A request is already running!' ] ]
]

{ #category : #serialization }
AbstractPCChatGroup >> saveToJSONfile [
	self subclassResponsibility
]
