package todo

todos: {
	"26-45-023_extract_sibling_pdf_text": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "feature"
		priority: "medium"
		status:   "triage"
		title:    "Extract searchable text from the sibling project's PDFs"
		problem_statement: """
			The ontology review relies on the official documentation in
			`~/projects/circuit-tracks-docs/pdf/` (`user-guide-v3-en.pdf`,
			`programmers-reference-v3-en.pdf` and the localized guides), but those are
			binary PDFs. There is no checked-in text corpus to grep, cite
			page-accurately or reuse in docgen. Add a reproducible extraction step
			(e.g. `pdftotext -layout`, one `.txt` per PDF with page markers, or a
			combined corpus) and keep large outputs out of git. Use the sibling
			project's `manifest.txt` checksums to pin the exact PDFs. Note that
			`pdftotext` is not on `PATH` in this environment; poppler-utils exists in
			the nix store, so the script should locate it or document the dependency.
			extraction occured in ~/projects/circuit-tracks-docs and is commited in git
			"""
		current_examples: [
			"`~/projects/circuit-tracks-docs/pdf/` contains the official PDFs; no extracted text is available in this repo.",
			"Review citations use PDF page numbers manually (e.g. official p. 65) without a searchable source.",
		]
		expected_examples: [
			"A script or documented command regenerates text for every PDF, preserving page boundaries.",
			"Extracted text is searchable with grep and can verify #OfficialRef page/section citations.",
		]
	}
}
