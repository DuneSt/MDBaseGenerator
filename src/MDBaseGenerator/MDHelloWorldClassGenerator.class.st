Class {
	#name : #MDHelloWorldClassGenerator,
	#superclass : #MDClassGenerator,
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDHelloWorldClassGenerator >> comment [
	^ 'Description
--------------------

TODO'
]

{ #category : #initialization }
MDHelloWorldClassGenerator >> initializeClassMethods [
	super initializeClassMethods.
	self
		addClassMethodIn: 'accessing'
			code:
			'pageName
	^ ''Hello world''';
		addClassMethodIn: 'accessing'
			code:
			'priority
	^ 1'
]

{ #category : #initialization }
MDHelloWorldClassGenerator >> initializeMethods [
	super initializeMethods.
	self
		addMethodIn: 'rendering'
		code:
			'renderContentOn: html
	html text: ''Hello world'''
]

{ #category : #accessing }
MDHelloWorldClassGenerator >> name [
	^ 'HelloWorldPage'
]

{ #category : #accessing }
MDHelloWorldClassGenerator >> packageTag [
	^ 'Pages'
]

{ #category : #accessing }
MDHelloWorldClassGenerator >> superclassName [
	^ MDPageClassGenerator instance className
]
