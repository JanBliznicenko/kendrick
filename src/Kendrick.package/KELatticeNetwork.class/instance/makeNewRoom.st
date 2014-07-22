as yet unclassified
makeNewRoom
	|node i j x y loc|
	node := KENetworkNode new.
	nodes add: node.
	"find location of new individual"
	i := (nodes size).
	j := (nodes size) - sqrtNbInd.
	loc := (population indList at: j) location.
	x := (#first value: loc).
	y := (#second value: loc) + (1.0/sqrtNbInd).
	self with: (Array with: i with: j) weight: #contact value: 1.
	(i\\sqrtNbInd) ~= 1 
	ifTrue: [ 
		j := i - 1.
		self with: (Array with: i with: j) weight: #contact value: 1
		 ].
	^ (Array with: x with: y)
	