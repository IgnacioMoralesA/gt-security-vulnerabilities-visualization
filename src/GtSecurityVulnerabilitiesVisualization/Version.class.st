Class {
	#name : #Version,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'vulnerabilities',
		'workflow'
	],
	#category : #'GtSecurityVulnerabilitiesVisualization-Model'
}

{ #category : #'as yet unclassified' }
Version >> addVulnerability: aVulnerability [
	(self vulnerabilities) add: aVulnerability.
]

{ #category : #'as yet unclassified' }
Version >> gtVulnerabilityRectangleFor: aView [
    <gtView>
    ^ aView explicit
        title: 'Vulnerability Rectangle';
        stencil: [
            | size color rect |
            size := self vulnerabilityCount max: 1.

            color := (self workflow versions size >= 5)
                ifTrue: [ Color green ]
                ifFalse: [ Color red ].

            rect := BlElement new.
            rect background: color.
            rect geometry: (BlRectangleGeometry new
                                width: size * 40;
                                height: size * 40).

            rect
        ].

]

{ #category : #'as yet unclassified' }
Version >> timestamp [
	^ timestamp
]

{ #category : #'as yet unclassified' }
Version >> timestamp: aString [
	timestamp := aString.
]

{ #category : #'as yet unclassified' }
Version >> vulnerabilities [
	^ vulnerabilities ifNil: [ vulnerabilities := OrderedCollection new ].
]

{ #category : #'as yet unclassified' }
Version >> vulnerabilityCount [
	^ self vulnerabilities size
]

{ #category : #'as yet unclassified' }
Version >> workflow [
	^ workflow
]

{ #category : #'as yet unclassified' }
Version >> workflow: aWorkflow [
	workflow := aWorkflow.
]
