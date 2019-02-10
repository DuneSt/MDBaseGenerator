Class {
	#name : #MDSessionClassGenerator,
	#superclass : #MDClassGenerator,
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDSessionClassGenerator >> comment [
	^ 'Description
--------------------

Simple session for the {1}. I save the root component to help with the application management. Each components will be able to access the root component via myself.

Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	rootComponent:		<aComponent>		The root component of the demo. Should be an instance of the root component of the application.
' format: {self generator projectName}
]

{ #category : #initialization }
MDSessionClassGenerator >> initializeMethods [
	super initializeMethods.
	self
		addMethodIn: 'accessing'
			code:
			'rootComponent
	^ rootComponent';
		addMethodIn: 'accessing'
			code:
			'rootComponent: aRootComponent
	rootComponent := aRootComponent'
]

{ #category : #accessing }
MDSessionClassGenerator >> name [
	^ 'Session'
]

{ #category : #accessing }
MDSessionClassGenerator >> packageTag [
	^ 'Core'
]

{ #category : #accessing }
MDSessionClassGenerator >> superclassName [
	^ #WASession
]

{ #category : #accessing }
MDSessionClassGenerator >> variables [
	^ #(#rootComponent)
]
