Class {
	#name : #BaselineOfVisibilityDeductor,
	#superclass : #BaselineOf,
	#category : #BaselineOfVisibilityDeductor
}

{ #category : #baselines }
BaselineOfVisibilityDeductor >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"Packages"
		spec 
			package: 'VisibilityDeductor';
			package: 'VisibilityDeductor-Tests' with: [ spec requires: #('VisibilityDeductor') ] ].
]
