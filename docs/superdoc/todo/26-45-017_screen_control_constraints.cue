package todo

todos: {
	"26-45-017_screen_control_constraints": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "feature"
		priority: "medium"
		status:   "triage"
		title:    "Constrain screen-state control keys and enforce coverage"
		problem_statement: """
			`#ScreenState.controls` (`schema.cue:166-170`) uses `#ID` as the key, not
			the set of keys in `controls`. A screen state can reference a control that
			does not exist, and nothing enforces that every control is mapped. The
			\"exhaustive\" claim for Drum 1 is manual only. A derived #ControlID and a
			CUE check would make it reliable.
			"""
		current_examples: [
			"`controls: [key=#ID]: #ControlState` accepts any lowercase key.",
			"`drum1_note_screen_state` claims every pad, knob and button is mapped, but CUE does not check it.",
		]
		expected_examples: [
			"Screen controls are keyed by a derived control-id type; missing or unknown controls fail `cue vet`.",
		]
	}
}
