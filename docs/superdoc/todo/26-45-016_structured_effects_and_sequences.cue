package todo

todos: {
	"26-45-016_structured_effects_and_sequences": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "feature"
		priority: "medium"
		status:   "triage"
		title:    "Decide whether effects and multi-control gestures need structure"
		problem_statement: """
			`#Function` (`schema.cue:112-118`) has press/hold/release/turn directions
			and modifier layers, but no sequence or \"while holding another control\"
			condition. `#Effect` is free text. The docs contain hold Clear + turn a
			knob, hold a step + turn a knob, hold a step + press a sample pad,
			Duplicate + pad A then pad B, Record + step/knob, and Shift + Clear. For
			docgen the prose is enough; for an emulator it is not executable. Decide
			which goal the ontology serves and document the limitation if it stays
			prose-only.
			"""
		current_examples: [
			"`clear_function`/`duplicate_function`/`record_function` exist, but their sequences and conditions are free text.",
			"`#ScreenStateID` is unused, so even \"open view\" effects are not typed.",
		]
		expected_examples: [
			"Either add structured gesture/effect targets (modifiers, held control, sequence, screen) or declare the ontology documentation-only.",
		]
	}
}
