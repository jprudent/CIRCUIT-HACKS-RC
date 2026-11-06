package todo

todos: {
	"26-45-001_held_step_transitions": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "bug"
		priority: "high"
		status:   "triage"
		title:    "Fix held-step transitions and use previous_state"
		problem_statement: """
			`drum1_note.cue:46-89` makes every held step release go to
			`drum_step_pad_state_flipped` (pink), including empty and active steps.
			The reserved `previous_state` target in `instances.cue:410-413` is never used.
			Holding an empty step and releasing without choosing a sample must restore
			the dim-blue no-hit state; holding an active step must restore bright blue.
			`drum_step_pad_state_held_assigned` also always commits a flip: choosing the
			active sample must return the step to bright blue, not pink. The state has
			no `fromGesture` for the cross-control "sample pad pressed while step held"
			transition.

			Doc evidence: official User Guide v3 p. 65; GUIA 5.1.
			"""
		current_examples: [
			"""
				`drum_step_pad_state_flipped.fromGesture` contains:
				`drum_step_pad_state_held: "release"` and
				`drum_step_pad_state_held_assigned: "release"`.
				""",
			"""
				`drum_step_pad_state_held.function.release` mentions only bright blue
				and pink; it omits the dim-blue empty step.
				""",
		]
		expected_examples: [
			"""
				An unassigned held step releases to `previous_state`; an assigned
				active sample releases to `drum_step_pad_state_active`; an assigned
				non-active sample releases to `drum_step_pad_state_flipped`.
				""",
		]
	}
}
