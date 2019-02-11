Class {
	#name : #MDPageClassGenerator,
	#superclass : #MDClassGenerator,
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDPageClassGenerator >> comment [
	^ 'Description
--------------------

I am an abstract component. My subclasses represent the main pages of the application.

Each page should have a name that will be used in the URLs and a priority for the menus.'
]

{ #category : #initialization }
MDPageClassGenerator >> initializeClassMethods [
	super initializeClassMethods.
	self
		addClassMethodIn: 'testing'
			code:
			('isAbstract
	^ self = {1}' format: {self className});
		addClassMethodIn: 'accessing'
			code:
			'pageName
	"Title of the page that will be used in menus and URLs."

	^ self subclassResponsibility';
		addClassMethodIn: 'accessing'
			code:
			'pagesToDisplay
	^ (self allSubclasses reject: #isAbstract) sorted: #priority ascending';
		addClassMethodIn: 'accessing'
			code:
			'pathName
	"Use to define the URL name"

	^ self pageName copyWithout: $  ';
		addClassMethodIn: 'accessing'
			code:
			'priority
	^ self subclassResponsibility'
]

{ #category : #initialization }
MDPageClassGenerator >> initializeMethods [
	super initializeMethods.
	self
		addMethodIn: 'accessing'
		code:
			'pathName
	^ self class pathName'
]

{ #category : #accessing }
MDPageClassGenerator >> name [
	^ 'Page'
]

{ #category : #accessing }
MDPageClassGenerator >> packageTag [
	^ 'Core'
]

{ #category : #accessing }
MDPageClassGenerator >> superclassName [
	^ MDComponentClassGenerator instance className
]
