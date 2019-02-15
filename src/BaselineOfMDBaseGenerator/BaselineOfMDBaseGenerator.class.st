Class {
	#name : #BaselineOfMDBaseGenerator,
	#superclass : #BaselineOf,
	#category : #BaselineOfMDBaseGenerator
}

{ #category : #baseline }
BaselineOfMDBaseGenerator >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Dependencies"
			self materialDesignLite: spec.

			"Packages"
			spec package: 'MDBaseGenerator' with: [ spec requires: #('MaterialDesignLite') ] ]
]

{ #category : #dependencies }
BaselineOfMDBaseGenerator >> materialDesignLite: spec [
	spec
		baseline: 'MaterialDesignLite'
		with: [ spec repository: 'github://DuneSt/MaterialDesignLite:v2.x.x/src' ]
]

{ #category : #accessing }
BaselineOfMDBaseGenerator >> projectClass [
	^ MetacelloCypressBaselineProject
]
