Class {
	#name : #MDBaseGenerator,
	#superclass : #Object,
	#instVars : [
		'prefix',
		'packageName',
		'projectName'
	],
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDBaseGenerator >> classGenerators [
	^ { MDComponentClassGenerator }
]

{ #category : #preprocessing }
MDBaseGenerator >> cleanBeforeGeneration [
	(RPackageOrganizer default packageNamed: self packageName ifAbsent: [ nil ]) ifNotNil: #removeFromSystem
]

{ #category : #generation }
MDBaseGenerator >> generate [
	self validateInformations.
	self cleanBeforeGeneration.
	RPackageOrganizer default createPackageNamed: self packageName.
	self classGenerators do: [ :class | (class generator: self) generate ].
	self openPackage.
	self openLastInstructions
]

{ #category : #postprocessing }
MDBaseGenerator >> openLastInstructions [
	Transcript clear; open.
	(String streamContents: [ :s | s << 'Application generated with success.
Now you can implement the missing parts to get your application!
	1) TODO']) logCr
]

{ #category : #postprocessing }
MDBaseGenerator >> openPackage [
	(RPackageOrganizer default packageNamed: self packageName) browse 
]

{ #category : #accessing }
MDBaseGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
MDBaseGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
MDBaseGenerator >> prefix [
	^ prefix
]

{ #category : #accessing }
MDBaseGenerator >> prefix: anObject [
	prefix := anObject
]

{ #category : #accessing }
MDBaseGenerator >> prefixed: aString [
	^ self prefix , aString
]

{ #category : #accessing }
MDBaseGenerator >> projectName [
	^ projectName
]

{ #category : #accessing }
MDBaseGenerator >> projectName: anObject [
	projectName := anObject
]

{ #category : #preprocessing }
MDBaseGenerator >> validateInformations [
	self prefix ifNil: [ self error: 'Generator needs a prefix for the classes to generate. Example: ''MDE'' will generate classes begining with MDE.' ].
	self packageName ifNil: [ self error: 'Generator needs a package name where to generate the code.' ].
	self projectName ifNil: [ self error: 'Generator needs a project name.' ].
	self class environment at: #MaterialDesignLite ifAbsent: [ self error: 'MDL need to be in the image for the generation.' ]
]
