package todo

todos: {
	"26-45-018_duplicate_primitives_and_format": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "feature"
		priority: "low"
		status:   "triage"
		title:    "Remove duplicated schema definitions and keep formatting clean"
		problem_statement: """
			`instances.cue:6-42` duplicates the primitives from `schema.cue`, and
			`#ControlStateID`/`#ScreenStateID` are defined in both files. The copies
			can drift. `cue fmt --check` also reports `drum1_note.cue` (one
			trailing-whitespace line). Keep types in `schema.cue` only and run
			`cue fmt .`.
			"""
		current_examples: [
			"`#Locale`, `#Version`, `#ID`, `#Hex`, `#Text`, `#Release`, `#Since`, `#OfficialRef`, `#Color` and the state-id types appear in both files.",
			"`cue fmt --check` lists `drum1_note.cue`.",
		]
		expected_examples: [
			"One definition per type, in `schema.cue`; data-only files contain instances.",
			"`cue fmt --check .` is clean.",
		]
	}
}
