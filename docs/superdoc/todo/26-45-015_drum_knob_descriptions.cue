package todo

todos: {
	"26-45-015_drum_knob_descriptions": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "bug"
		priority: "medium"
		status:   "triage"
		title:    "Correct K3/K7/K5 drum knob descriptions and LED behaviour"
		problem_statement: """
			`drum1_note.cue:169-188`, `211-230` and `250-269` simplify documented
			behaviour. K3: turning left reduces attack to 0 before decay; with Shift,
			start or cut returns to 0 before the other moves; the LEDs are attack
			white, Shift start in the drum colour and cut white (`GUIA.en.md:820`).
			K7: since RC4 left is start scan, not vibrato; the scan never passes the
			cut, and fully left it covers the whole sample (`GUIA.en.md:817`). K5:
			comb is not available in Beta 5.16, where the tilt EQ plays instead
			(`GUIA.en.md:815`).
			"""
		current_examples: [
			"K3: `turn_left` says only \"shorten the decay\"; no attack-first priority or LED colours.",
			"K7: `turn_left` says \"start scan / vibrato amount\"; no cut/sample-length limits.",
			"K5: filter modes list comb unconditionally.",
		]
		expected_examples: [
			"Describe the attack/decay and start/cut priority, and the LED colours.",
			"Version the K7 start-scan and K5 comb behaviour (RC4 vs Beta 5.16).",
		]
	}
}
