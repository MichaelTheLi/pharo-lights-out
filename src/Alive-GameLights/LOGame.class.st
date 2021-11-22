Class {
	#name : #LOGame,
	#superclass : #BorderedMorph,
	#instVars : [
		'cells'
	],
	#category : #'Alive-GameLights'
}

{ #category : #accessing }
LOGame >> cellsPerSide [
   "The number of cells along each side of the game"
	^ 10
]

{ #category : #initialization }
LOGame >> initialize [			
	| sampleCell width height n |
	super initialize.
	n := self cellsPerSide.
	sampleCell := LOCell new.
	width := sampleCell width.
	height := sampleCell height.
	
   self bounds: (5@5 extent: (width * n) @ (height * n) + (2 * self borderWidth)).
   cells := Array2D new: n tabulate: [ :i :j | self newCellAt: i at: j].

]

{ #category : #logic }
LOGame >> newCellAt: i at: j [

	"Create a cell for position (i,j) and add it to my on-screen
representation at the appropriate screen position. Answer the
new cell"

	| newCell origin |
	newCell := LOCell new.
	origin := self innerBounds origin.
	self addMorph: newCell.
	newCell position:
		(i - 1) * newCell width @ ((j - 1) * newCell height) + origin.
	^ newCell mouseAction: [ self toggleNeighboursOfCellAt: i at: j ]
]

{ #category : #logic }
LOGame >> toggleNeighboursOfCellAt: i at: j [

	i > 1
		ifTrue: [ (cells at: i - 1 at: j) toggleState ].
	i < self cellsPerSide
		ifTrue: [ (cells at: i + 1 at: j) toggleState ].
	j > 1
		ifTrue: [ (cells at: i at: j - 1) toggleState ].
	j < self cellsPerSide
		ifTrue: [ (cells at: i at: j + 1) toggleState ]
]
