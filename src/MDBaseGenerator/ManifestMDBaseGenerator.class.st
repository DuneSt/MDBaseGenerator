"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMDBaseGenerator,
	#superclass : #PackageManifest,
	#category : #'MDBaseGenerator-Manifest'
}

{ #category : #'code-critics' }
ManifestMDBaseGenerator class >> ruleRBMissingTranslationsInMenusRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#MDBaseGenerator)) #'2019-02-11T01:26:29.294316+01:00') )
]
