Class {
	#name : #WorkflowParser,
	#superclass : #Object,
	#category : #GtSecurityVulnerabilitiesVisualization
}

{ #category : #'as yet unclassified' }
WorkflowParser >> parseFolder: aFolderReference [
    | workflows |
    workflows := OrderedCollection new.

    aFolderReference childrenDo: [:each |
        (each extension = 'json') ifTrue: [
            workflows add: (self parseWorkflowFromFile: each)
        ].
    ].

    ^ workflows

]

{ #category : #'as yet unclassified' }
WorkflowParser >> parseWorkflowFromFile: aFileReference [
    | json workflow |
    json := NeoJSONReader fromString: aFileReference contents.

    workflow := Workflow new.
    workflow name: (json at: 'workflow_name').

    (json at: 'history') keysAndValuesDo: [:timestamp :entry |
        | version |
        version := Version new.
        version timestamp: timestamp.

        (entry at: 'vulnerability_list') do: [:vulnDict |
            | vuln |
            vuln := Vulnerability new.
            vuln ruleId: (vulnDict at: 'ruleId').
            vuln message: ((vulnDict at: 'message') at: 'text').
            vuln severity: ((vulnDict at: 'properties') at: 'security_severity') asNumber.
            version addVulnerability: vuln
        ].

        (version workflow: workflow).
		workflow addVersion: version.
    ].

    ^ workflow

]
