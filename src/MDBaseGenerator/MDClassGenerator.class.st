Class {
	#name : #MDClassGenerator,
	#superclass : #Object,
	#instVars : [
		'generator',
		'methods',
		'classMethods'
	],
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDClassGenerator class >> generator: aMDBaseGenerator [
	^ self new
		generator: aMDBaseGenerator;
		yourself
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
	classMethods := Dictionary new.
	self
		initializeMethods;
		initializeClassMethods
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
	^ self subclassResponsibility
]

{ #category : #accessing }
MDClassGenerator >> variables [
	^ #()
]
