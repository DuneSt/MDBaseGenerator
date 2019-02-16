Class {
	#name : #MDRootClassGenerator,
	#superclass : #MDClassGenerator,
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDRootClassGenerator >> comment [
	^ 'Description
--------------------

I am the root component of {1}. I will contain every components of the application to display.

I have a header.
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	componentInstances:			<aDictionary>	A dictionary keeping for each component class, an instance. This instance can be use when the user change of page to come pack to a previous page.
	componentToDisplay:		<aComponent>	The current page to display as the root content.
	header:						<aComponent>	The header of the page.
' format: {self generator projectName}
]

{ #category : #initialization }
MDRootClassGenerator >> initializeClassMethods [
	super initializeClassMethods.
	self
		addClassMethodIn: 'testing'
			code:
			'canBeRoot
	^ true';
			addClassMethodIn: 'initialization'
			code:
			('initialize
		self environment at: #WADevelopmentConfiguration ifPresent: [ :class | WAAdmin applicationDefaults removeParent: class instance ]. "Remove development tools."
	^ (WAAdmin register: self asApplicationAt: ''{1}'')
		preferenceAt: #sessionClass put: {2};
		addLibrary: JQDeploymentLibrary;
		addLibrary: MDLLibrary;
		addLibrary: {3};
		yourself' format: {self generator projectName. MDSessionClassGenerator instance className. MDFileLibraryClassGenerator instance className});
		addClassMethodIn: 'world menu'
			code:
			('menuCommandOn: aBuilder
	<worldMenu>
	(aBuilder item: #{1})
		order: 20;
		with: [ (aBuilder item: #''Open in default browser'')
				order: 2;
				iconName: #nautilus;
				help: ''Open in the default web browser'';
				action: [ self open ] ]' format: {self generator projectName});
		addClassMethodIn: 'instance creation'
			code:
			('open
	<script>
	| port |
	WAServerManager default adaptors
		ifEmpty: [ (ZnZincServerAdaptor port: (port := 8085)) start ]
		ifNotEmpty: [ :adaptors | 
			adaptors
				detect: #isRunning
				ifFound: [ :anAdaptor | port := anAdaptor server port ]
				ifNone: [ (ZnZincServerAdaptor port: (port := 8085)) start ] ].
	WebBrowser openOn: ''http://localhost:'' , port asString , ''/{1}''' format: {self generator projectName})
]

{ #category : #initialization }
MDRootClassGenerator >> initializeMethods [
	super initializeMethods.
	self
		addMethodIn: 'accessing'
			code:
			'componentInstances
	"I return a dictionary with browsers as keys and their instances as value if they were instantiated at least once."

	^ componentInstances';
		addMethodIn: 'accessing'
			code:
			'componentInstances: aDictionary
	componentInstances := aDictionary';
		addMethodIn: 'accessing'
			code:
			'componentToDisplay
	"Component instance to display in the application."
	
	^ componentToDisplay';
		addMethodIn: 'accessing'
			code:
			'componentToDisplay: aComponent
	componentToDisplay := aComponent';
		addMethodIn: 'accessing'
			code:
			'header
	^ header';
		addMethodIn: 'accessing'
			code:
			'header: aComponent
	header := aComponent';
		addMethodIn: 'components'
			code:
			('defaultHeader
	^ {1} new' format: {self generator headerClassGenerator instance className});
		addMethodIn: 'hooks'
			code:
			'initialRequest: aRequest
	| consumer pageName |
	super initialRequest: aRequest.
	consumer := self requestContext consumer.
	
	"If we are at end, nothing to manage"
	consumer atEnd ifTrue: [ ^ self ].
	
	pageName := consumer peek asLowercase. "Do not make URLs case sensitive in that case"
	
	"Try to find a page corresponding"
	self header possiblePages
		detect: [ :each | each pathName asLowercase = pageName ]
		ifFound: [ :class | 
			self displayInstanceOf: class.

			"If we find a page, we pop the subpart of the path corresponding to the page."
			consumer next ]';
		addMethodIn: 'hooks'
			code:
			'style
	^ ''.mdl-pagination__current{
        box-shadow: inset 0px -4px 0px 0px '
				,
					(self generator accentColor
						code: #A200;
						yourself) asRGBA
				,
					' !important;
    }''';
		addMethodIn: 'updating'
			code:
			'displayInstanceOf: aComponentClass
	self componentToDisplay: (self componentInstances at: aComponentClass ifAbsentPut: [ aComponentClass new ])';
		addMethodIn: 'updating'
			code:
			('updateRoot: anHtmlRoot
	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot title: ''{1}''.
	anHtmlRoot meta
		attributeAt: ''name'' put: ''viewport'';
		content: ''width=device-width, initial-scale=1''{2}'
				format:
					{self generator title . (self generator cssInFileLibrary
						ifTrue: [ '' ]
						ifFalse: [ '.
	anHtmlRoot stylesheet url: (WAUrl absolute: ''https://storage.googleapis.com/code.getmdl.io/1.3.0/material.' , self generator colors , '.min.css'')' ])});
		addMethodIn: 'updating'
			code:
			'updateUrl: aUrl
	super updateUrl: aUrl.
	aUrl addToPath: (self componentToDisplay pathName)'.
	self initializeMethodsRelatedToFooter
]

{ #category : #initialization }
MDRootClassGenerator >> initializeMethodsRelatedToFooter [
	self
		addMethodIn: 'hooks'
			code:
			'children
	^ { self header. self componentToDisplay }';
		addMethodIn: 'initialization'
			code:
			'initialize
	super initialize.
	self header: self defaultHeader.
	self session rootComponent: self.
	self componentInstances: Dictionary new.
	self displayInstanceOf: self header possiblePages first';
		addMethodIn: 'rendering'
			code:
			('renderContentOn: html
	html
		mdlLayout: [ html render: self header.
			html mdlLayoutContent
				class: ''mdl-color-text--grey-600'';
				with: [ html mdlGrid
						noSpacing;
						with: [ html mdlCell
								class: ''{1}'';
								size: 12;
								with: [ html render: self componentToDisplay ] ]] ]' format: {self generator rootHtmlClass})
]

{ #category : #accessing }
MDRootClassGenerator >> name [
	^ 'Root'
]

{ #category : #accessing }
MDRootClassGenerator >> packageTag [
	^ 'Core'
]

{ #category : #accessing }
MDRootClassGenerator >> superclassName [
	^ MDComponentClassGenerator instance className
]

{ #category : #accessing }
MDRootClassGenerator >> variables [
	^ #(#header #componentToDisplay #componentInstances)
]
