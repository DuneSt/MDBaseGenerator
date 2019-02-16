Class {
	#name : #MDBaseGenerator,
	#superclass : #Object,
	#instVars : [
		'prefix',
		'packageName',
		'projectName',
		'withFooter',
		'withDrawerHeader',
		'rootHtmlClass',
		'title',
		'primaryColor',
		'accentColor',
		'cssInFileLibrary'
	],
	#category : #MDBaseGenerator
}

{ #category : #example }
MDBaseGenerator class >> example [
	self new
		prefix: 'MDE';
		packageName: 'MDExample-WebApplication';
		projectName: 'MDExample';
		withFooter: true;
		withDrawerHeader: false;
		rootHtmlClass: 'mdexample';
		title: 'Application example for MDL.';
		primaryColor: MDLColor deepPurple;
		accentColor: MDLColor pink;
		cssInFileLibrary: true;
		generate
]

{ #category : #accessing }
MDBaseGenerator >> accentColor [
	"This color will be used as accent color (secondary/highlight color) of the MDL application. It should be an instance of MDLColor but cannot be brown, grey or blue grey. For example: `MDLColor pink`."

	<generatorParameter>
	^ accentColor
]

{ #category : #accessing }
MDBaseGenerator >> accentColor: anObject [
	accentColor := anObject
]

{ #category : #accessing }
MDBaseGenerator >> classGenerators [
	^ {MDComponentClassGenerator . MDFileLibraryClassGenerator . MDSessionClassGenerator . MDPageClassGenerator . MDHelloWorldClassGenerator . self headerClassGenerator.
	(self withFooter ifTrue: [ MDFooterClassGenerator ]) . self rootClassGenerator}
]

{ #category : #preprocessing }
MDBaseGenerator >> cleanBeforeGeneration [
	(RPackageOrganizer default packageNamed: self packageName ifAbsent: [ nil ]) ifNotNil: #removeFromSystem
]

{ #category : #accessing }
MDBaseGenerator >> colors [
	^ self primaryColor tint, '-', self accentColor tint
]

{ #category : #accessing }
MDBaseGenerator >> cssInFileLibrary [
	"This parameter should be a boolean. If it is true, the MDL CSS will be stored in the FileLibrary of the application, else the header will reference an external resource."

	<generatorParameter>
	^ cssInFileLibrary
]

{ #category : #accessing }
MDBaseGenerator >> cssInFileLibrary: anObject [
	cssInFileLibrary := anObject
]

{ #category : #generation }
MDBaseGenerator >> generate [
	[ :job | 
	job title: 'Generating application: Validate informations'.
	self validateInformations.
	job
		progress: 0.1;
		title: 'Generating application: Clean'.
	self cleanBeforeGeneration.
	job
		progress: 0.2;
		title: 'Generating application: Generate package'.
	RPackageOrganizer default createPackageNamed: self packageName.
	job
		progress: 0.4;
		title: 'Generating application: Generate classes'.
	self classGenerators do: [ :class | (class generator: self) generate ] displayingProgress: [ :class | 'Generation of ' , class printString ].
	job
		progress: 0.8;
		title: 'Generating application: Open package'.
	self openPackage.
	job
		progress: 1;
		title: 'Generating application: Initialize classes'.
	self initializeClasses ] asJob run
]

{ #category : #accessing }
MDBaseGenerator >> headerClassGenerator [
	^ self withDrawerHeader ifTrue: [ MDDrawerHeaderClassGenerator ] ifFalse: [ MDTabBarHeaderClassGenerator ]
]

{ #category : #postprocessing }
MDBaseGenerator >> initializeClasses [
	{self rootClassGenerator} do: [ :class | self class environment at: class instance className asSymbol ifPresent: #initialize ]
]

{ #category : #postprocessing }
MDBaseGenerator >> openPackage [
	(RPackageOrganizer default packageNamed: self packageName) browse 
]

{ #category : #accessing }
MDBaseGenerator >> packageName [
	"This parameters defines the name of the package containing the application generated. For example: `MyApplication-Seaside`."

	<generatorParameter>
	^ packageName
]

{ #category : #accessing }
MDBaseGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
MDBaseGenerator >> prefix [
	"This parameter defines the prefix of generated classes. For example: `MA`."

	<generatorParameter>
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
MDBaseGenerator >> primaryColor [
	"This color will be used as primary color of the MDL application. It should be an instance of MDLColor. For example: `MDLColor deepPurple`."

	<generatorParameter>
	^ primaryColor
]

{ #category : #accessing }
MDBaseGenerator >> primaryColor: anObject [
	primaryColor := anObject
]

{ #category : #accessing }
MDBaseGenerator >> projectName [
	"This parameter defines the project name. This name will be used as route of the application in Seaside registration and also for some comments. For example: `MyApplication`."

	<generatorParameter>
	^ projectName
]

{ #category : #accessing }
MDBaseGenerator >> projectName: anObject [
	projectName := anObject
]

{ #category : #accessing }
MDBaseGenerator >> rootClassGenerator [
	^ self withFooter
		ifTrue: [ MDRootWithFooterClassGenerator ]
		ifFalse: [ MDRootClassGenerator ]
]

{ #category : #accessing }
MDBaseGenerator >> rootHtmlClass [
	"This parameter defines a css class to add to the root component of the application to help with the CSS. For example: `my-application`."

	<generatorParameter>
	^ rootHtmlClass
]

{ #category : #accessing }
MDBaseGenerator >> rootHtmlClass: anObject [
	rootHtmlClass := anObject
]

{ #category : #accessing }
MDBaseGenerator >> title [
	"This parameter defines the title to display in the tab of the application. For example: `Title of my application!`."

	<generatorParameter>
	^ title
]

{ #category : #accessing }
MDBaseGenerator >> title: anObject [
	title := anObject
]

{ #category : #preprocessing }
MDBaseGenerator >> validateInformations [
	self class environment at: #MaterialDesignLite ifAbsent: [ self error: 'MDL need to be in the image for the generation.' ].
	(Pragma allNamed: #generatorParameter in: self class)
		do: [ :pragma | (self perform: pragma methodSelector) ifNil: [ self error: ('Missing parameter {1}. {2}' format: {pragma methodSelector . pragma method comment allButFirst allButLast}) ] ]
]

{ #category : #accessing }
MDBaseGenerator >> withDrawerHeader [
	"This parameter should be a boolean and defines if the application will have a menu as tabs or as a drawer."

	<generatorParameter>
	^ withDrawerHeader
]

{ #category : #accessing }
MDBaseGenerator >> withDrawerHeader: anObject [
	withDrawerHeader := anObject
]

{ #category : #accessing }
MDBaseGenerator >> withFooter [
	"This parameter defines if the application should have a footer or not."

	<generatorParameter>
	^ withFooter
]

{ #category : #accessing }
MDBaseGenerator >> withFooter: anObject [
	withFooter := anObject
]
