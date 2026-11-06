package todo

todos: {
	"26-45-012_step_page_transitions": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "bug"
		priority: "medium"
		status:   "triage"
		title:    "Fix Step Page transition targets"
		problem_statement: """
			`drum1_note.cue:474-525` has contradictory transitions. The 16-step state
			says it is reached from `32_page1` on press, but page-1 press shows page 2.
			`32_page1.fromGesture` also has a self-loop on press, while its
			`function.press` says \"Show Page 2\". The 16-step state is actually
			reached by Clear from a 32-step state, which #ActionSeq cannot express.
			Official User Guide v3 pp. 75-76.
			"""
		current_examples: [
			"`step_page_button_state_16.fromGesture` includes `32_page1: \"press\"`.",
			"`step_page_button_state_32_page1.fromGesture` includes itself.",
		]
		expected_examples: [
			"16 -> 32 page 1 on press; page 1 -> page 2 on press; page 2 -> page 1 on press; Clear from 32 -> 16.",
			"Represent Clear/Duplicate transitions explicitly rather than as plain presses.",
		]
	}
}
