package todo

todos: {
	"26-45-009_screen_registry_and_transitions": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "feature"
		priority: "medium"
		status:   "triage"
		title:    "Connect screens, screen states and transitions"
		problem_statement: """
			`instances.cue:255-266` has only `screens.drum_1_note`, while
			`screen_states` uses `drum1_note_screen_state`, `drum1_expanded_view`,
			`synth1_note_screen`, etc. There is no `screen` field linking a state to a
			title, and #ScreenStateID (`schema.cue:188`, `instances.cue:770`) is never
			referenced. Function text says \"Open the Drum 1 Velocity view\" but there
			is no machine-readable target. Naming suffixes are inconsistent.
			"""
		current_examples: [
			"`screens.drum_1_note` vs `screen_states.drum1_note_screen_state`.",
			"`note_button_state.function.press` mentions Expanded Drum View only in prose.",
		]
		expected_examples: [
			"Screen states carry a screen reference and functions carry a typed screen target (e.g. screen?: #ScreenStateID).",
			"One naming convention for all screen-state keys.",
		]
	}
}
