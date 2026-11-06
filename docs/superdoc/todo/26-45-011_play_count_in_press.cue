package todo

todos: {
	"26-45-011_play_count_in_press": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "bug"
		priority: "medium"
		status:   "triage"
		title:    "Count-in is triggered by Play, not by holding Play"
		problem_statement: """
			`drum1_note.cue:619-633` puts the count-in under
			`play_button_state_off.function.hold`. GUIA 0.2 (`GUIA.en.md:124`) says
			Play with Record armed and the count-in on starts one bar of count-in.
			There is no long-press requirement. The `hold` field is also used for the
			stock momentary view behaviour, so the current mapping is misleading.
			"""
		current_examples: [
			"`play_button_state_off.function.hold` contains the count-in description.",
		]
		expected_examples: [
			"Count-in is a press of Play when Record is armed and count-in is on; model the armed/count-in condition explicitly.",
		]
	}
}
