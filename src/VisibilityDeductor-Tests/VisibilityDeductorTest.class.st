Class {
	#name : #VisibilityDeductorTest,
	#superclass : #TestCase,
	#instVars : [
		'detector'
	],
	#category : #'VisibilityDeductor-Tests'
}

{ #category : #initialization }
VisibilityDeductorTest >> setUp [
	super setUp.
	detector := VisibilityDeductor new.
]

{ #category : #tests }
VisibilityDeductorTest >> testIsPackagePrivate [
	self assert: (detector isPackagePrivate: self class package)
]

{ #category : #tests }
VisibilityDeductorTest >> testIsPackagePublic [
	self assert: (detector isPackagePublic: detector class package)
]
