package todo

todos: {
	"26-45-019_localization": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "feature"
		priority: "low"
		status:   "triage"
		title:    "Decide whether the ontology needs Spanish strings"
		problem_statement: """
			`#Text` requires `en` and allows every published locale, but almost all
			descriptions, effects and labels are English-only; only the colour names
			have `es`. The repository docs are ES/EN, and the schema comment says
			docgen checks the published locales. If docgen is meant to produce
			GUIA.md as well as GUIA.en.md, add `es` or document English-only.
			"""
		current_examples: [
			"`colors.violet.name` has en/es; `drum1_note_screen_state.description` has only en.",
		]
		expected_examples: [
			"Either add `es` to every user-visible string or make the English-only policy explicit.",
		]
	}
}
