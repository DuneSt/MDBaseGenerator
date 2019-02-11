Class {
	#name : #MDHeaderClassGenerator,
	#superclass : #MDClassGenerator,
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDHeaderClassGenerator >> comment [
	^ 'Description
--------------------

I am the reader of the application.'
]

{ #category : #initialization }
MDHeaderClassGenerator >> initializeMethods [
	super initializeMethods.
	self
		addMethodIn: 'accessing'
		code:
			('possiblePages
	^ {1} pagesToDisplay' format: {MDPageClassGenerator instance className}).
	self initializeMethodsRelatedToHeaderKind
]

{ #category : #initialization }
MDHeaderClassGenerator >> initializeMethodsRelatedToHeaderKind [
	self subclassResponsibility
]

{ #category : #accessing }
MDHeaderClassGenerator >> name [
	^ 'Header'
]

{ #category : #accessing }
MDHeaderClassGenerator >> packageTag [
	^ 'Core'
]

{ #category : #accessing }
MDHeaderClassGenerator >> superclassName [
	^ MDComponentClassGenerator instance className
]
