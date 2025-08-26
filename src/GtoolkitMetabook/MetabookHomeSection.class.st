Class {
	#name : #MetabookHomeSection,
	#superclass : #GtHomeMultiCardSection,
	#category : #'GtoolkitMetabook-Sections'
}

{ #category : #initialization }
MetabookHomeSection >> cardPriorities [
	<gtExample>
	<return: #Array>
	^ #(metabookProjectCard metabookOverviewCard)
]

{ #category : #'as yet unclassified' }
MetabookHomeSection >> defaultPriority [
	^ 20
]

{ #category : #card }
MetabookHomeSection >> metabookOverviewCard [
	<gtSectionCard>
	<gtExample>
	<return: #GtHomePageCard>
	^ GtHomeCard page
		title: 'Metabook overview';
		description: 'Metabook overview';
		setPriority;
		pageName: 'Metabook overview';
		databaseName: 'feenkcom/gtoolkit-metabook/gtmetabook';
		assertInvariant;
		yourself
]

{ #category : #card }
MetabookHomeSection >> metabookProjectCard [
	<gtSectionCard>
	<gtExample>
	<return: #GtHomePageCard>
	^ GtHomeCard page
		title: 'Metabook project';
		description: 'Metabook project';
		setPriority;
		pageName: 'Metabook project';
		databaseName: 'feenkcom/gtoolkit-metabook/lepiter';
		assertInvariant;
		yourself
]

{ #category : #initialization }
MetabookHomeSection >> sectionTitle [
	^ 'Metabook Section'
]
