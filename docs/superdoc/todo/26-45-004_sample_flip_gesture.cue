package todo

todos: {
	"26-45-004_sample_flip_gesture": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "bug"
		priority: "high"
		status:   "triage"
		title:    "Model the stock sample-flip gesture and make flip_target reachable"
		problem_statement: """
			`drum1_note.cue:91-125` only models hold-step + press-sample. The stock
			gesture also works the other way: hold a sample pad (it turns red), then
			press step pads (official User Guide v3 p. 63; GUIA 5.2). The `hold`
			actions on `drum_sample_pad_state_inactive` and `_active` only play the
			sample. `drum_sample_pad_state_flip_target` has no `fromGesture`, and its
			`function.press` is a state description rather than an action, so the red
			sample-pad state cannot be entered or left formally.
			"""
		current_examples: [
			"`drum_sample_pad_state_inactive.function.hold` says only \"Play the sample without changing the active sample\".",
			"`drum_sample_pad_state_flip_target` has no `fromGesture` and no transitions back to active/inactive.",
		]
		expected_examples: [
			"Hold sample pad -> red flip-preparation state; then press one or more step pads to assign the flip.",
			"Release the step or sample pad -> the sample pad returns to bright orange (active) or dim orange (inactive).",
		]
	}
}
