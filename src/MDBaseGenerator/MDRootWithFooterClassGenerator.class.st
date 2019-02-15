Class {
	#name : #MDRootWithFooterClassGenerator,
	#superclass : #MDRootClassGenerator,
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDRootWithFooterClassGenerator >> comment [
	^ 'Description
--------------------

I am the root component of {1}. I will contain every components of the application to display.

I have a header and a footer.
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	componentInstances:			<aDictionary>	A dictionary keeping for each component class, an instance. This instance can be use when the user change of page to come pack to a previous page.
	componentToDisplay:		<aComponent>	The current page to display as the root content.
	footer:						<aComponent>	The footer of the page.
	header:						<aComponent>	The header of the page.
' format: {self generator projectName}
]

{ #category : #initialization }
MDRootWithFooterClassGenerator >> initializeMethodsRelatedToFooter [
	self
		addMethodIn: 'accessing'
			code:
			'footer
	^ footer';
		addMethodIn: 'accessing'
			code:
			'footer: aComponent
	footer := aComponent';
		addMethodIn: 'components'
			code:
			('defaultFooter
	^ {1} new' format: {MDFooterClassGenerator instance className});
		addMethodIn: 'hooks'
			code:
			'children
	^ { self header. self componentToDisplay. self footer }';
		addMethodIn: 'initialization'
			code:
			'initialize
	super initialize.
	self header: self defaultHeader.
	self footer: self defaultFooter.
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
								with: [ html render: self componentToDisplay ] ].
					html render: self footer ] ]' format: {self generator rootHtmlClass})
]

{ #category : #accessing }
MDRootWithFooterClassGenerator >> variables [
	^ super variables , #(#footer)
]
