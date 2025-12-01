Class {
	#name : #BaselineOfGtSecurityVulnerabilitiesVisualization,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtSecurityVulnerabilitiesVisualization
}

{ #category : #loading }
BaselineOfGtSecurityVulnerabilitiesVisualization class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'gt-security-vulnerabilities-visualization' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfGtSecurityVulnerabilitiesVisualization >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GtSecurityVulnerabilitiesVisualization'
		]
]
