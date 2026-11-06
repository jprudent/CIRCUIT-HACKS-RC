package todo

todos: {
	"26-45-020_pad_grid_bounds": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "feature"
		priority: "low"
		status:   "triage"
		title:    "Enforce pad grid bounds and remove the unused Line/Column types"
		problem_statement: """
			`schema.cue:61-75` defines #Line and #Column but `padGridCoordinates`
			uses `[int, int]` and carries TODOs for the 1..4 / 1..8 checks. Use the
			named types with bounds, or define the tuple as
			`[int & >=1 & <=4, int & >=1 & <=8]`.
			"""
		current_examples: [
			"`padGridCoordinates?: [int, int]` with two TODO comments.",
		]
		expected_examples: [
			"`padGridCoordinates?: [#Line, #Column]` with `#Line: int & >=1 & <=4` and `#Column: int & >=1 & <=8`.",
		]
	}
}
