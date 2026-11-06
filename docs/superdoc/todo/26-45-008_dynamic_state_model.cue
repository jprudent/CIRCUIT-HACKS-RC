package todo

todos: {
	"26-45-008_dynamic_state_model": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "exploration"
		priority: "medium"
		status:   "triage"
		title:    "Decide how to model data-dependent UI state (active sample, page, cursor, track)"
		problem_statement: """
			`#ScreenState.controls` pins one state per control. There is no mechanism
			to update other controls when one changes and no screen data model.
			Selecting a new sample pad should deactivate the old one; there is no
			active -> inactive transition. J/K page changes replace all 16 sample pads;
			Step Page changes replace the visible steps; the play cursor should move;
			selecting another drum track changes all track-button LEDs. The current
			model can show two active sample pads and cannot move the cursor. This is
			acceptable for a documentation snapshot, but it is the main blocker for
			using the ontology as emulator input.
			"""
		current_examples: [
			"`drum_sample_pad_state_active` has no transition to inactive; `inactive` has no fromGesture.",
			"`drum1_note_screen_state` always shows sample page 1, sample 1 active and all steps empty.",
			"No state represents the white play cursor (official p. 21).",
		]
		expected_examples: [
			"Either document the ontology as a static documentation snapshot, or introduce pattern/page/cursor/selected-track data with derived controls.",
		]
	}
}
