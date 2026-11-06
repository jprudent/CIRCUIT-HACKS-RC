package todo

#Todo: {
	date: string
	related_todos: [...#Todo]
	type:     "bug" | "feature" | "exploration"
	priority: "high" | "medium" | "low"
	// when created, it's triage until it has been reviewed and set to "backlog"
	status:          "triage" | "backlog" | "wip" | "done"
	wip_git_branch?: string
	// a short title that describes what to do
	title:             string
	problem_statement: string
	current_examples?: [...string]
	expected_examples?: [...string]
}
