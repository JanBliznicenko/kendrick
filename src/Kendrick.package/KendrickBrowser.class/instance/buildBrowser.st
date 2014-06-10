building
buildBrowser
	"build the browser"
	browser := GLMTabulator new initialExtent: 1500@1000.
	browser title: 'Kendrick Browser';
	act: [:p | p update]
		icon: GLMUIThemeExtraIcons glamorousRefresh
		entitled: 'Update the Browser'.
"	browser
		act: [ :b | b entity add: KEModel new ]
		icon: GLMUIThemeExtraIcons glamorousAdd
		entitled: 'Add an item in the collection'."
	browser
		act: [ :b | b entity removeLast ]
		icon: GLMUIThemeExtraIcons glamorousRemove
		entitled: 'Remove the select Model on the Browser'.
	browser 
		row:[ :rows | rows
			column: #models;
			column: #compartments;
			column: #equations;
			column: #parameters.] size: 180;
		row: #options size: 70;
		row: [ :a | a
			column: #graph;
			column: #view] .

	"Panel of models"
	browser transmit
		to: #models;
		andShow: [ :a | 
			a title: 'Models'.
			self modelsIn: a ].	
			
     "Panel of compartments"
	browser transmit
		from: #models;
		to: #compartments;
		andShow: [ :a |
			a title:'Compartments'. 
			self compartimentsIn: a.].		
						
	"Panel of equations"
	browser transmit
		from: #models;
		to: #equations;
		andShow: [ :a | 
					a title: 'Equations'.
					self equationsIn: a ].	
					
	"Panel of parameters"
	browser transmit
		from: #models;
		to: #parameters;
		andShow: [ :a | 
					a title: 'Parameters'.
					self parametresIn: a ].
	
	"Panel of different options"
	browser transmit
		from: #models;
		to:#options;
		andShow:[ :b | b dropDownList
			title: 'Options';
			display:[#('Deterministic Simulation' 'Stochastic Simulation' 'Individual Base Simulation' 'Models like Box')];
			selectedIndex: 4
			].
	"Panel for list the different graph"
	browser transmit
		from: #models;
		from: #options;
		to:#graph;
		andShow:[ :a :m :o|
				o ='Models like Box' ifTrue:[
					self boxViewIn: a.].
				o='Deterministic Simulation' ifTrue:[
					self deterministicSimulationIn: a.
					].
				o='Stochastic Simulation' ifTrue:[
					self stochasticSimulationIn: a.].
				o='Individual Base Simulation' ifTrue:[
					self individualBasedSimulationIn: a.].
			].
		"Panel for visualization of select graph"
		browser transmit
		from: #graph;
		to:#view;
		andShow:[ :a | 
			self graphView:a]