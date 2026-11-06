package todo

todos: {
	"26-45-021_labels_and_comments": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "feature"
		priority: "low"
		status:   "triage"
		title:    "Align J/K labels with the panel and tag new comments"
		problem_statement: """
			The panel art shows only down/up triangles on the two page/octave buttons,
			while `controls.j`/`controls.k` use `onDeviceMainLabel` \"J\"/\"K\" (the
			manual's names). Choose a label that matches the device or the docs. Also
			follow the AGENTS comment convention for new comments (`// H:` human,
			`// G:` agent); existing untagged comments should be left alone without
			consent.
			"""
		current_examples: [
			"`j`/`k` `onDeviceMainLabel` = \"J\"/\"K\"; the panel shows triangles.",
			"New comments in the superdoc are currently untagged.",
		]
		expected_examples: [
			"Labels match the panel or use the manual's Octave names consistently.",
			"New comments use the H/G prefix convention.",
		]
	}
}
