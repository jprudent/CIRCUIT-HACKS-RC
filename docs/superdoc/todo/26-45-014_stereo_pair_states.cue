package todo

todos: {
	"26-45-014_stereo_pair_states": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "feature"
		priority: "medium"
		status:   "triage"
		title:    "Add stereo-pair states for Drum 2/4 in the Drum 1 note view"
		problem_statement: """
			The Drum 1 note view is claimed exhaustive, but Drum 2/4 can be in a stereo
			pair (`GUIA.en.md:834-855`): the right drum's button pulses in the master's
			colour, its pattern stops playing, its pads and MIDI notes play it alone on
			the right, and its knobs become deviations from Drum 1/3. The ontology only
			has dim yellow/purple/aqua states for Drum 2/3/4 and no paired variant.
			The Drum 2/4 note-screen stubs also miss the deviation knob behaviour.
			"""
		current_examples: [
			"`drum_2_track_button_state.light` is `[\"dim\", colors.yellow]`; no pulse/paired state.",
			"`drum2_note_screen_state` says only \"same layout as Drum 1, in yellow\".",
		]
		expected_examples: [
			"A paired state for Drum 2/4 (button pulse, pattern stopped, pads/MIDI alone).",
			"Knob states for Drum 2/4 deviations in the paired note view.",
		]
	}
}
