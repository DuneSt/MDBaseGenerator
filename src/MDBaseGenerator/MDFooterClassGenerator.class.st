Class {
	#name : #MDFooterClassGenerator,
	#superclass : #MDClassGenerator,
	#category : #MDBaseGenerator
}

{ #category : #accessing }
MDFooterClassGenerator >> comment [
	^ 'Description
--------------------

A footer for the application with all the useful links.'
]

{ #category : #initialization }
MDFooterClassGenerator >> initializeMethods [
	super initializeMethods.
	self
		addMethodIn: 'accessing'
			code:
			'links
	^ OrderedDictionary
		with: ''MDL for Seaside'' -> ''https://github.com/DuneSt/MaterialDesignLite''
		with: ''Pharo'' -> ''http://pharo.org/''
		with: ''Seaside'' -> ''https://github.com/SeasideSt/Seaside''';
		addMethodIn: 'rendering'
			code:
			('renderContentOn: html
	html
		mdlMiniFooter: [ html
				mdlMiniFooterLeftSection: [ html mdlLogo: ''{1}''.
					html
						mdlMiniFooterLinkList: [ self links
								keysAndValuesDo: [ :label :url | 
									html
										listItem: [ html anchor
												url: url;
												with: label ] ] ] ].
			html mdlMiniFooterRightSection: [ html mdlMiniFooterLinkList: [ html listItem: [ html text: ''Contact: TODO'' ] ] ] ]' format: { self generator projectName })
]

{ #category : #accessing }
MDFooterClassGenerator >> name [
	^ 'Footer'
]

{ #category : #accessing }
MDFooterClassGenerator >> packageTag [
	^ 'Core'
]

{ #category : #accessing }
MDFooterClassGenerator >> superclassName [
	^ MDComponentClassGenerator instance className
]
