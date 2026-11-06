package todo

todos: {
	"26-45-003_modifier_aware_gestures": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "bug"
		priority: "high"
		status:   "triage"
		title:    "Make fromGesture modifier-aware (Shift/Clear/Duplicate/Record)"
		problem_statement: """
			`#ActionSeq` (`schema.cue:101-104`) maps a state to one of press/hold/
			release/turn_left/turn_right and has no modifier. As a result the state
			graph says these are plain presses when the docs require modifiers:
			the metronome states use Shift + Clear (`GUIA.en.md:123`); View Lock uses
			Shift + Patterns (official p. 80); fixed velocity uses Shift + Velocity
			(`GUIA.en.md:127`); and Step Page Clear/Duplicate transitions cannot be
			expressed at all. The `shift_function` text is usually right, but the
			`fromGesture` graph is not. This blocks using the ontology as an emulator
			input.
			"""
		current_examples: [
			"`clear_button_state_metronome.fromGesture` says `clear_button_state_no_metronome: \"press\"`.",
			"`patterns_button_state_view_lock_on.fromGesture` says `view_lock_off: \"press\"`.",
			"`velocity_button_state_fixed.fromGesture` says `variable: \"press\"`.",
		]
		expected_examples: [
			"Gestures carry their modifier(s), e.g. shift+press, clear+press, duplicate+press, record+press.",
			"States reached by Shift+Clear, Shift+Patterns and Shift+Velocity are not reachable by a plain press.",
		]
	}
}
