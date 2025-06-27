Class {
	#name : #GtMetabookVectorIcons,
	#superclass : #BrGlamorousVectorIcons,
	#category : #'GtoolkitMetabook-Icons'
}

{ #category : #icons }
GtMetabookVectorIcons class >> createMetaPage [
	"Based on BrGlamorousVectorIcons class>>#rightSide"

	<script: 'self createMetaPage inspect'>
	^ [ BlElement new
		size: 16 @ 16;
		geometry: (BlSvgPath new
				svg: 'M 1.5 1.5 L 1.5 14.5 L 14.5 14.5 L 14.5 1.5 Z M 2.5 2.5 L 7.5 2.5 L 7.5 13.5 L 2.5 13.5 Z'
				viewbox: (0 @ 0 extent: 16 @ 16));
		background: Color red ] asStencil
]

{ #category : #icons }
GtMetabookVectorIcons class >> openBasePage [
	"Based on BrGlamorousVectorIcons class>>#leftSide"

	<script: 'self openBasePage inspect'>
	^ [ | icon |
	icon := BlElement new
			size: 16 @ 16;
			geometry: (BlSvgPath new
							svg: 'M 7.5 14.5 L 8.5 14.5 L 14.5 14.5 L 14.5 1.5 L 8.5 1.5 L 7.5 1.5 L 1.5 1.5 L 1.5 14.5 Z M 8.5 13.5 L 8.5 2.5 L 13.5 2.5 L 13.5 13.5 Z M 8.5 13.5 L 8.5 2.5'
		
					viewbox: (0 @ 0 extent: 16 @ 16));
			background: Color green muchDarker.
	icon transform
		rotateBy: 90;
		apply.
	icon ] asStencil
]

{ #category : #icons }
GtMetabookVectorIcons class >> openMetaPage [
	"Based on BrGlamorousVectorIcons class>>#rightSide"

	<script: 'self openMetaPage inspect'>
	^ [ BlElement new
		size: 16 @ 16;
		geometry: (BlSvgPath new
					svg: 'M 1.5 1.5 L 1.5 14.5 L 14.5 14.5 L 14.5 1.5 Z M 2.5 2.5 L 7.5 2.5 L 7.5 13.5 L 2.5 13.5 Z'
				viewbox: (0 @ 0 extent: 16 @ 16));
		background: Color blue ] asStencil
]
