"
A KEDiagramBuilder allows to plot multiple simulations outcomes.

Instance Variables
	data:		<Collection>
	legends:		<OrderedCollection>
	xLabel:		<String>
	yLabel:		<String>
	legendTitle: <String>

data
	- Collection of DataFrame to be plotted.

legends
	- xxxxx

xLabel
	- Label for x axis

yLabel
	- Label for y axis

legendTitle
	- Legend of the plot
"
Class {
	#name : #KEDiagramBuilder,
	#superclass : #KEGraphBuilder,
	#instVars : [
		'xLabel',
		'yLabel',
		'legends',
		'legendTitle'
	],
	#category : #'Kendrick-Core'
}

{ #category : #'as yet unclassified' }
KEDiagramBuilder >> build [
	| b normalize lb |
	self buildLegends.
	b := RTGrapher new.
	b extent: 400 @ 200.
	normalize := RTMultiLinearColorForIdentity new
		objects: self legends;
		colors: (RTColorPalette qualitative colors: 9 scheme: 'Set1').
	1 to: legends size do: [ :i | 
		| ds |
		ds := RTData new.
		ds noDot.
		ds points: (data at: i) rowNames.
		ds x: #yourself.
		ds y: [ :x | ((data at: i) row: x) contents first ].
		ds connectColor: (normalize rtValue: (legends at: i)).
		b add: ds ].
	xLabel ifNil: [ b axisX title: 'Time (days)' ] ifNotNil: [ b axisX title: xLabel ].
	yLabel
		ifNil: [ b axisY title: 'Number of individuals' ]
		ifNotNil: [ b axisY title: yLabel ].
	b axisY noDecimal.
	lb := RTLegendBuilder new.
	lb view: b view.
	self legendTitle ifNil: [ legendTitle := 'Compartments' ].
	lb addText: legendTitle.
	1 to: legends size do: [ :i | 
		| c |
		c := normalize rtValue: (legends at: i).
		lb addColor: c text: (legends at: i) ].
	lb build.
	b view @ RTZoomableView.
	^ b
]

{ #category : #'as yet unclassified' }
KEDiagramBuilder >> buildLegends [
	legends ifNil: [ legends := data collect: [ :each | each columnNames first ] ]
]

{ #category : #accessing }
KEDiagramBuilder >> data: aCollection [
	super data: aCollection.
	self buildLegends
]

{ #category : #accessing }
KEDiagramBuilder >> legendTitle [
	^ legendTitle
]

{ #category : #accessing }
KEDiagramBuilder >> legendTitle: aString [
	legendTitle := aString
]

{ #category : #accessing }
KEDiagramBuilder >> legends [
	^ legends
]

{ #category : #'as yet unclassified' }
KEDiagramBuilder >> legends: aCollection [
	legends := aCollection
]

{ #category : #'as yet unclassified' }
KEDiagramBuilder >> open [
	^ self build open
]

{ #category : #'as yet unclassified' }
KEDiagramBuilder >> view [
	^ self build view
]

{ #category : #accessing }
KEDiagramBuilder >> xLabel [
	^ xLabel
]

{ #category : #accessing }
KEDiagramBuilder >> xLabel: aString [
	xLabel := aString
]

{ #category : #accessing }
KEDiagramBuilder >> yLabel [
	^ yLabel
]

{ #category : #accessing }
KEDiagramBuilder >> yLabel: aString [
	yLabel := aString
]
