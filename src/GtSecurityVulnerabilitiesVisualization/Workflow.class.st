Class {
	#name : #Workflow,
	#superclass : #Object,
	#instVars : [
		'nameversions',
		'versions'
	],
	#category : #'GtSecurityVulnerabilitiesVisualization-Model'
}

{ #category : #'as yet unclassified' }
Workflow >> aString [
]

{ #category : #'as yet unclassified' }
Workflow >> addVersion [
]

{ #category : #'as yet unclassified' }
Workflow >> addVersion: aVersion [
    (self versions) add: aVersion.
]

{ #category : #'as yet unclassified' }
Workflow >> gtVersionsFor: aView [
    <gtView>
    ^ aView list
        title: 'Versions';
        items: self versions
]

{ #category : #'as yet unclassified' }
Workflow >> name [
^ name
]

{ #category : #'as yet unclassified' }
Workflow >> name: aString [
    name := aString
]

{ #category : #'as yet unclassified' }
Workflow >> versions [
    ^ versions ifNil: [ versions := OrderedCollection new ].

]
