Class {
	#name : #GtMetabookVectorIcons,
	#superclass : #BrGlamorousVectorIcons,
	#category : #'GtoolkitMetabook-Icons'
}

{ #category : #icons }
GtMetabookVectorIcons class >> fadedLeftSide [
	"Based on BrGlamorousVectorIcons class>>#leftSide"
	<script: 'self fadedLeftSide inspect'>

	^ [ BlElement new
		size: 16@16;
		geometry: (BlSvgPath new
			svg: 'M 7.5 14.5 L 8.5 14.5 L 14.5 14.5 L 14.5 1.5 L 8.5 1.5 L 7.5 1.5 L 1.5 1.5 L 1.5 14.5 Z M 8.5 13.5 L 8.5 2.5 L 13.5 2.5 L 13.5 13.5 Z M 8.5 13.5 L 8.5 2.5'
			viewbox: (0@0 extent: 16@16));
		background: Color veryLightGray ] asStencil
]

{ #category : #icons }
GtMetabookVectorIcons class >> fadedRightSide [
	"Based on BrGlamorousVectorIcons class>>#rightSide"
	<script: 'self fadedRightSide inspect'>

	^ [ BlElement new
		size: 16@16;
		geometry: (BlSvgPath new
			svg: 'M 1.5 1.5 L 1.5 14.5 L 14.5 14.5 L 14.5 1.5 Z M 2.5 2.5 L 7.5 2.5 L 7.5 13.5 L 2.5 13.5 Z'
			viewbox: (0@0 extent: 16@16));
		background: Color veryLightGray ] asStencil
]

{ #category : #icons }
GtMetabookVectorIcons class >> leftSide [
	<script: 'self leftSide inspect'>
	^ super leftSide
]

{ #category : #icons }
GtMetabookVectorIcons class >> rightSide [
	<script: 'self rightSide inspect'>

	^ super rightSide
]
