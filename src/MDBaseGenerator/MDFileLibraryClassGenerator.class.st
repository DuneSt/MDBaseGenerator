Class {
	#name : #MDFileLibraryClassGenerator,
	#superclass : #MDClassGenerator,
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDFileLibraryClassGenerator >> comment [
	^ 'TODO'
]

{ #category : #initialization }
MDFileLibraryClassGenerator >> initializeMethods [
	"Nothing by default"

	| library url fileName |
	super initializeMethods.
	self generator cssInFileLibrary ifFalse: [ ^ self ].
	library := self class environment at: self className asSymbol.
	fileName := 'material.' , self generator colors , '.min.css'.
	url := 'https://storage.googleapis.com/code.getmdl.io/1.3.0/'
		, fileName.
	library addFileNamed: fileName contents: (ZnEasy get: url) contents.
	self
		addMethodIn: 'accessing'
		code:
			('selectorsToInclude
	^ #({1})' format: {(library asSelector: fileName)})
]

{ #category : #accessing }
MDFileLibraryClassGenerator >> name [
	^ 'Library'
]

{ #category : #accessing }
MDFileLibraryClassGenerator >> packageTag [
	^ 'Utils'
]

{ #category : #accessing }
MDFileLibraryClassGenerator >> superclassName [
	^ #WAFileLibrary
]
