package todo

todos: {
	"26-45-005_modifier_and_value_leds": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "bug"
		priority: "high"
		status:   "triage"
		title:    "Model modifier-held and value-dependent LED states"
		problem_statement: """
			`#ControlState` (`schema.cue:120-140`) only has `light` and `shift_light`.
			The docs require many more LED states: Clear held = bright red (official
			p. 40); Duplicate held = bright green (official p. 40); Record + Shift =
			bright green when Rec Quantise is on and dim red when off (official p. 64);
			Record + step = step yellow (`GUIA.en.md:823`); Record + knob = knob white
			(`GUIA.en.md:824`); knob brightness follows the value and bipolar knobs are
			dark at the centre (`GUIA.en.md:132`); K3 attack is white, Shift start is
			the drum colour and cut is white (`GUIA.en.md:820`); Save is red in S
			builds; Beta 5.16 track buttons flash white for 100 ms.
			"""
		current_examples: [
			"`clear_button_state_*` and `duplicate_button_state` use `light: [\"off\"]` even while held.",
			"All drum knob states use `light: [\"on\", colors.orange]` regardless of value.",
			"`record_button_state_off/on` have no `shift_light` for the quantise state.",
		]
		expected_examples: [
			"Add clear_light/duplicate_light/record_light (or a modifier->light map) and value-dependent brightness.",
			"Add transient lights for blink/flash with a duration where the docs specify one.",
		]
	}
}
