Class {
	#name : #MDDrawerHeaderClassGenerator,
	#superclass : #MDHeaderClassGenerator,
	#category : #MDBaseGenerator
}

{ #category : #initialization }
MDDrawerHeaderClassGenerator >> initializeMethodsRelatedToHeaderKind [
	self
		addMethodIn: 'rendering'
			code:
			('renderContentOn: html
	html
		mdlLayoutHeader: [ 
			html
				mdlLayoutHeaderRow: [ 
					html mdlNavigationLink
						callback: [ "Just refresh" ];
						with: [ html
								mdlLayoutTitle: ''{1}'' ].
					html mdlLayoutSpacer.
					html text: ''Version 0.0.0''. ] ].
	self renderDrawerOn: html' format: {self generator title});
		addMethodIn: 'rendering'
			code:
			'renderDrawerOn: html
	html
		mdlLayoutDrawer: [ 
			html
				mdlNavigation: [ 
					self possiblePages
						do: [ :aClass | 
							html mdlNavigationLink
								beCurrentIf: aClass = self rootComponent componentToDisplay class;
								callback: [ self displayInstanceOf: aClass ];
								with: aClass pageName ] ] ]'
]
