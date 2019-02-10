Class {
	#name : #MDComponentClassGenerator,
	#superclass : #MDClassGenerator,
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDComponentClassGenerator >> comment [
	^ 'Description
--------------------

Abstract superclass of all Seaside components of {1}. 

I provide some conveniance methods to be used during the redering of the components.' format: {self generator projectName}
]

{ #category : #initialization }
MDComponentClassGenerator >> initializeMethods [
	super initializeMethods.
	self
		addMethodIn: 'convenience'
			code:
			'display: aComponentInstance
	"Set a component instance as the component to display by the root component."

	self rootComponent componentToDisplay: aComponentInstance';
		addMethodIn: 'convenience'
			code:
			'displayInstanceOf: aComponentClass
	"Set a component class as the component to display by the root component."

	self rootComponent displayInstanceOf: aComponentClass';
		addMethodIn: 'accessing'
			code:
			'rootComponent
	^ self session rootComponent'
]

{ #category : #accessing }
MDComponentClassGenerator >> name [
	^ 'Component'
]

{ #category : #accessing }
MDComponentClassGenerator >> packageTag [
	^ 'Core'
]

{ #category : #accessing }
MDComponentClassGenerator >> superclassName [
	^ #WAComponent
]
