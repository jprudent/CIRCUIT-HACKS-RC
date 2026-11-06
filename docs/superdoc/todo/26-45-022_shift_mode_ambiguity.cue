package todo

todos: {
	"26-45-022_shift_mode_ambiguity": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "exploration"
		priority: "low"
		status:   "triage"
		title:    "Clarify Shift behaviour: momentary, sticky or permanent"
		problem_statement: """
			The FIXME at `schema.cue:137-139` says Shift mode is \"permanent until
			disabled\", while the official manual describes momentary Shift plus an
			optional Sticky Shift (bright green when on). AGENTS.md warns that the
			hack overrides some stock behaviour \"like the shift key\". The current
			`shift_button_state` does not model either Sticky Shift or a permanent
			mode cleanly: its `shift_light` is green while held, which the official
			manual associates with Sticky Shift being on. Confirm the intended RC
			behaviour and model it explicitly.
			"""
		current_examples: [
			"`shift_button_state.shift_light` is `[\"on\", colors.green]` while Shift is held.",
			"`shift_button_state.function.press` mentions Sticky Shift, but there is no sticky on/off state.",
		]
		expected_examples: [
			"Model momentary held, Sticky Shift on/off, and any RC permanent mode as distinct states.",
		]
	}
}
