Class {
	#name : #MDTabBarHeaderClassGenerator,
	#superclass : #MDHeaderClassGenerator,
	#category : #MDBaseGenerator
}

{ #category : #initialization }
MDTabBarHeaderClassGenerator >> initializeMethodsRelatedToHeaderKind [
	self
		addMethodIn: 'rendering'
		code:
			('renderContentOn: html
	html mdlLayoutHeader
		waterfall;
		with: [ html
				mdlLayoutHeaderRow: [ html mdlNavigationLink
						callback: [ "Just refresh" ];
						with: [ html
								mdlLayoutTitle: ''{1}'' ].
					html mdlLayoutSpacer.
					html text: ''Version 0.0.0''. ].
			html
				mdlLayoutTabBar: [ self possiblePages
						do: [ :aClass | 
							html mdlLayoutTab
								callback: [ self displayInstanceOf: aClass ];
								isActiveIf: aClass = self rootComponent componentToDisplay class;
								with: aClass pageName ] ] ]' format: {self generator title copyReplaceAll: '''' with: ''''''})
]
