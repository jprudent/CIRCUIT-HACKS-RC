package todo

todos: {
	"26-45-002_extra_lane_shift_assignments": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "bug"
		priority: "high"
		status:   "triage"
		title:    "Add the Shift-layer extra-lane assignments for the drum knobs"
		problem_statement: """
			`drum1_note.cue:142-145`, `163-166`, `205-208` and `265-268` miss the
			extra-lane assignments that use Shift. GUIA 5.1 (`GUIA.en.md:824`) lists:
			Shift + K1 = pitch envelope amount; Shift + K2 = ring-mod amount;
			Shift + K4 = envelope shape; Shift + K7 = LFO speed. K1 currently says
			"no extra-lane assignment", which is wrong: K1 alone is the pitch lane,
			but Shift + K1 assigns the pitch envelope. K6 (resonance), K3, K5 and K8
			are correct as written. Also document that Clear + K1 left erases the
			chromatic-pitch lane in Beta 5.16.
			"""
		current_examples: [
			"K1: `record_function.turn_left` and `turn_right` say \"No extra-lane assignment for K1\".",
			"K2/K4/K7: only the unshifted parameter is assigned.",
		]
		expected_examples: [
			"K1: K1 alone = pitch lane; Shift + K1 = pitch envelope amount.",
			"K2: Shift + K2 = ring-mod amount; K4: Shift + K4 = envelope shape; K7: Shift + K7 = LFO speed.",
		]
	}
}
