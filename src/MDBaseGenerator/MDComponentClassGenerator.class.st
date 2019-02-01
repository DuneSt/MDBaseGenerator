Class {
	#name : #MDComponentClassGenerator,
	#superclass : #MDClassGenerator,
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDComponentClassGenerator >> comment [
	^ 'Description
--------------------

Abstract superclass of all Seaside components of {1} . 

I provide some conveniance methods to be used during the redering of the components.' format: {self generator projectName}
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
MDComponentClassGenerator >> superclass [
	^ WAComponent
]
