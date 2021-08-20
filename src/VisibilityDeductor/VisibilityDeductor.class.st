Class {
	#name : #VisibilityDeductor,
	#superclass : #Object,
	#category : #VisibilityDeductor
}

{ #category : #testing }
VisibilityDeductor >> isBaselineClass: aClass [
	^ (aClass inheritsFrom: BaselineOf) or: [
		aClass name beginsWith: 'BaselineOf' ]
]

{ #category : #testing }
VisibilityDeductor >> isBaselinePackage: aPackage [
	^ aPackage name beginsWith: 'BaselineOf'
]

{ #category : #api }
VisibilityDeductor >> isClassPrivate: aClass [
	(self isPackagePrivate: aClass package)
		ifTrue: [ ^ true ].
		
	^ (self isTestClass: aClass) or: [
		(self isBaselineClass: aClass) or: [ 
			(self isTraitClass: aClass) or: [
				(self isExampleClass: aClass) or: [
					(self isHelpClass: aClass) ] ] ] ]
]

{ #category : #api }
VisibilityDeductor >> isClassPublic: aClass [
	^ (self isClassPrivate: aClass) not
]

{ #category : #testing }
VisibilityDeductor >> isExampleClass: aClass [
	^ (aClass name beginsWith: 'Example') or: [
		aClass name endsWith: 'Example' ]
]

{ #category : #testing }
VisibilityDeductor >> isExampleMethod: aMethod [
	^ (aMethod selector beginsWith: 'example') or: [ 
		aMethod selector endsWithAnyOf:
			#(Example Example1 Example2 Example3 Example4 Example5 Example6 Example7 Example8 Example9) ]
]

{ #category : #testing }
VisibilityDeductor >> isExamplePackage: aPackage [
	^ aPackage name endsWithAnyOf: #('-Examples' '-Example')
]

{ #category : #testing }
VisibilityDeductor >> isHelpClass: aClass [
	^ (aClass inheritsFrom: CustomHelp) or: [ 
		aClass inheritsFrom: CustomHelp2 ]
]

{ #category : #testing }
VisibilityDeductor >> isHelpPackage: aPackage [
	^ aPackage name endsWith: '-Help'
]

{ #category : #testing }
VisibilityDeductor >> isInitializeMethod: aMethod [
	^ aMethod selector = 'initialize'
]

{ #category : #testing }
VisibilityDeductor >> isMethodInPrivateProtocol: aMethod [
	^ aMethod protocol isNotNil and: [
		aMethod protocol includesSubstring: 'private' ]
]

{ #category : #api }
VisibilityDeductor >> isMethodPrivate: aMethod [
	(self isClassPrivate: aMethod methodClass)
		ifTrue: [ ^ true ].
		
	(self isMethodInPrivateProtocol: aMethod)
		ifTrue: [ ^ true ].
		
	(self isInitializeMethod: aMethod)
		ifTrue: [ ^ true ].
		
	^ self isExampleMethod: aMethod
]

{ #category : #api }
VisibilityDeductor >> isMethodPublic: aMethod [
	^ (self isMethodPrivate: aMethod) not
]

{ #category : #api }
VisibilityDeductor >> isPackagePrivate: aPackage [
	^ (self isTestPackage: aPackage) or: [
		(self isExamplePackage: aPackage) or: [
			(self isHelpPackage: aPackage) or: [ 
				self isBaselinePackage: aPackage ] ] ]
]

{ #category : #api }
VisibilityDeductor >> isPackagePublic: aPackage [
	^ (self isPackagePrivate: aPackage) not
]

{ #category : #testing }
VisibilityDeductor >> isTestClass: aClass [
	^ (aClass inheritsFrom: TestCase) or: [
		aClass name endsWith: 'Test' ]
]

{ #category : #testing }
VisibilityDeductor >> isTestPackage: aPackage [
	^ ('-' split: aPackage name) includesAnyOf: #(Test Tests)
]

{ #category : #testing }
VisibilityDeductor >> isTraitClass: aClass [
	^ (aClass inheritsFrom: Trait) or: [ 
		(aClass name beginsWith: 'T') and: [ aClass name second isUppercase ] ]
]
