package todo

todos: {
	"26-45-006_color_hex_violet_purple": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "bug"
		priority: "high"
		status:   "triage"
		title:    "Swap the violet/purple hex values and reconcile teal/magenta"
		problem_statement: """
			Official User Guide v3 p. 21 names the tracks: Synth 1 Violet, Synth 2
			Pale Green, MIDI 1 Blue, MIDI 2 Pink, Drum 1 Orange, Drum 2 Yellow,
			Drum 3 Purple, Drum 4 Aqua. The IDs in `instances.cue:56-88` match those
			names, but the hex values are exchanged: the LED table maps Synth 1
			(code 0x32) to magenta #c63ac6 and Drum 3 (0x49) to purple #9865ff
			(`tools/make_manual.py:18-19`, `tools/build_sc15.py:71`). The ontology has
			violet #9865ff and purple #c63ac6, so `synth_1_track_button_state` and
			`drum_3_track_button_state` use the wrong colours. Also verify
			`colors.teal` #00c8b4 and `colors.magenta` #ff00ff; neither is in the LED
			table (table teal #00ffb5, magenta #c63ac6).
			"""
		current_examples: [
			"`colors.violet` = #9865ff; used by Synth 1.",
			"`colors.purple` = #c63ac6; used by Drum 3.",
		]
		expected_examples: [
			"Synth 1 violet = #c63ac6 (LED code 0x32); Drum 3 purple = #9865ff (LED code 0x49).",
			"Teal/magenta values either match the LED table or document the different LED codes they represent.",
		]
	}
}
