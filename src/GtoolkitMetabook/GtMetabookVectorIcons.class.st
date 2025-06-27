Class {
	#name : #GtMetabookVectorIcons,
	#superclass : #BrGlamorousVectorIcons,
	#category : #'GtoolkitMetabook-Icons'
}

{ #category : #icons }
GtMetabookVectorIcons class >> createMetaPage [
	"Based on https://www.svgrepo.com/svg/535309/cloud-arrow-down (up)."

	<script: 'self createMetaPage inspect'>
	^ [ BlElement new
		size: 16 @ 16;
		geometry: (BlSvgPath new
				svg: 'M8 2C10.2091 2 12 3.79086 12 6V7C14.2091 7 16 8.79086 16 11V14H9V11H11V10L8 7L5 10V11H7L7 14H0V10C0 7.79086 1.79086 6 4 6C4 3.79086 5.79086 2 8 2Z'
				viewbox: (0 @ 0 extent: 16 @ 16));
		background: Color red muchLighter ] asStencil
]

{ #category : #icons }
GtMetabookVectorIcons class >> openBasePage [
	"Based on https://www.svgrepo.com/svg/535305/cloud-arrow-up (down)."

	<script: 'self openBasePage inspect'>
	^ [ BlElement new
		size: 16 @ 16;
		geometry: (BlSvgPath new
				svg: 'M8 2C10.2091 2 12 3.79086 12 6V7C14.2091 7 16 8.79086 16 11V14H9L11 12V11H9L9 8L7 8L7 11H5V12L7 14H0V10C0 7.79086 1.79086 6 4 6C4 3.79086 5.79086 2 8 2Z'
				viewbox: (0 @ 0 extent: 16 @ 16));
		background: Color green muchDarker ] asStencil
]

{ #category : #icons }
GtMetabookVectorIcons class >> openMetaPage [
	"Based on https://www.svgrepo.com/svg/535309/cloud-arrow-down (up)."

	<script: 'self openMetaPage inspect'>
	^ [ BlElement new
	size: 16 @ 16;
	geometry: (BlSvgPath new
			svg: 'M8 2C10.2091 2 12 3.79086 12 6V7C14.2091 7 16 8.79086 16 11V14H9V11H11V10L8 7L5 10V11H7L7 14H0V10C0 7.79086 1.79086 6 4 6C4 3.79086 5.79086 2 8 2Z'
			viewbox: (0 @ 0 extent: 16 @ 16));
	background: Color blue ] asStencil
]
