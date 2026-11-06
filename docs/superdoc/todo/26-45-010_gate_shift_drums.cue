package todo

todos: {
	"26-45-010_gate_shift_drums": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "exploration"
		priority: "medium"
		status:   "triage"
		title:    "Confirm whether Shift+Gate opens a separate Micro Step view on drums"
		problem_statement: """
			`drum1_note.cue:438-448` says Shift + Gate opens the Micro Step view on a
			drum. GUIA 4.2 (`GUIA.en.md:700-716`) titles Micro Step as a note-track
			view; the official manual says the drums' Gate View is the micro-step
			editor (p. 66). The ontology's own `drum1_micro_step_view` stub says
			\"Confirm whether the drums expose this state\". Test on the device or
			against the firmware before keeping the mapping.
			"""
		current_examples: [
			"`gate_button_state.shift_function.press` says \"Open the Micro Step view (Shift + Gate)\".",
			"`drum1_micro_step_view` exists as a stub with a TODO.",
		]
		expected_examples: [
			"If drums have no separate Micro Step view, remove the shift function and the stub; otherwise document how it differs from Gate View.",
		]
	}
}
