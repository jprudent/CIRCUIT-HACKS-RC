package todo

todos: {
	"26-45-013_jk_page_and_cursor_leds": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "bug"
		priority: "medium"
		status:   "triage"
		title:    "Model J/K page intensity and the play cursor"
		problem_statement: """
			`drum1_note.cue:764-778` gives J and K `light: [\"dim\", colors.white]`
			unconditionally. The official manual (p. 60) says their intensity shows
			the current sample page, so page 1 and page 4 need different states. The
			pattern play cursor also turns the current step white (official p. 21),
			and the Velocity view's selected step pulses blue/white (p. 69). Neither
			cursor state exists.
			"""
		current_examples: [
			"`j_button_state.light` and `k_button_state.light` are always dim white.",
			"`drum1_note_screen_state` has no current-step/play-cursor state.",
		]
		expected_examples: [
			"J/K have page-dependent brightness (at least first/middle/last page).",
			"A playing step/current step state (white or pulsing blue/white) exists.",
		]
	}
}
