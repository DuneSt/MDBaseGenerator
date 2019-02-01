Class {
	#name : #MDClassGenerator,
	#superclass : #Object,
	#instVars : [
		'generator',
		'generatedClass'
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
MDClassGenerator >> className [
	^ self generator prefixed: self name
]

{ #category : #accessing }
MDClassGenerator >> comment [
	^ self subclassResponsibility
]

{ #category : #translating }
MDClassGenerator >> generate [
	generatedClass := self superclass
		subclass: self className
		slots: self variables
		classVariables: {}
		package: self packageName.
		
	generatedClass comment: self comment
]

{ #category : #accessing }
MDClassGenerator >> generator [
	^ generator
]

{ #category : #accessing }
MDClassGenerator >> generator: anObject [
	generator := anObject
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
