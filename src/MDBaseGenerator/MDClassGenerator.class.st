Class {
	#name : #MDClassGenerator,
	#superclass : #Object,
	#instVars : [
		'generator',
		'methods',
		'classMethods'
	],
	#classInstVars : [
		'instance'
	],
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDClassGenerator class >> generator: aMDBaseGenerator [
	^ instance := self new
		generator: aMDBaseGenerator;
		yourself
]

{ #category : #accessing }
MDClassGenerator class >> instance [
	^ instance ifNil: [ self error: 'This class generator was not initialized.' ]
]

{ #category : #accessing }
MDClassGenerator >> addClassMethodIn: aProtocol code: aString [
	(self classMethods at: aProtocol ifAbsentPut: [ OrderedCollection new ]) add: aString
]

{ #category : #accessing }
MDClassGenerator >> addMethodIn: aProtocol code: aString [
	(self methods at: aProtocol ifAbsentPut: [ OrderedCollection new ]) add: aString
]

{ #category : #accessing }
MDClassGenerator >> classMethods [
	^ classMethods
]

{ #category : #accessing }
MDClassGenerator >> classMethods: anObject [
	classMethods := anObject
]

{ #category : #accessing }
MDClassGenerator >> className [
	^ self generator prefixed: self name
]

{ #category : #accessing }
MDClassGenerator >> comment [
	^ self subclassResponsibility
]

{ #category : #translating }
MDClassGenerator >> generate [
	| generatedClass |
	generatedClass := self superclass
		subclass: self className
		slots: self variables
		classVariables: {}
		package: self packageName.
		
	self
		initializeMethods;
		initializeClassMethods.

	generatedClass comment: self comment.

	self methods keysAndValuesDo: [ :protocol :meths | meths do: [ :method | generatedClass compile: method classified: protocol ] ].

	self classMethods keysAndValuesDo: [ :protocol :meths | meths do: [ :method | generatedClass class compile: method classified: protocol ] ]
]

{ #category : #accessing }
MDClassGenerator >> generator [
	^ generator
]

{ #category : #accessing }
MDClassGenerator >> generator: anObject [
	generator := anObject
]

{ #category : #initialization }
MDClassGenerator >> initialize [
	super initialize.
	methods := Dictionary new.
	classMethods := Dictionary new
]

{ #category : #initialization }
MDClassGenerator >> initializeClassMethods [
	"Nothing by default"
]

{ #category : #initialization }
MDClassGenerator >> initializeMethods [
	"Nothing by default"
]

{ #category : #accessing }
MDClassGenerator >> methods [
	^ methods
]

{ #category : #accessing }
MDClassGenerator >> methods: anObject [
	methods := anObject
]

{ #category : #accessing }
MDClassGenerator >> name [
	^ self subclassResponsibility
]

{ #category : #accessing }
MDClassGenerator >> packageName [
	^ self generator packageName , '-' , self packageTag
]

{ #category : #accessing }
MDClassGenerator >> packageTag [
	^ self subclassResponsibility
]

{ #category : #accessing }
MDClassGenerator >> superclass [
	^ self class environment at: self superclassName asSymbol
]

{ #category : #accessing }
MDClassGenerator >> superclassName [
	^ self subclassResponsibility
]

{ #category : #accessing }
MDClassGenerator >> variables [
	^ #()
]
