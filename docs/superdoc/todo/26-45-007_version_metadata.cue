package todo

todos: {
	"26-45-007_version_metadata": #Todo & {
		date: "2026-11-06"
		related_todos: []
		type:     "bug"
		priority: "high"
		status:   "triage"
		title:    "Make Release/Since/OfficialRef usable and version the states"
		problem_statement: """
			`schema.cue:21-42` defines #Release, #Since and #OfficialRef, but none is
			used. The types cannot represent the docs either: #Version rejects
			"Beta 5.16" (space) and "1.2.1" (the official firmware in GUIA.en.md:3);
			#Release.officialFirmwareVersion is typed #Version, so it cannot hold
			1.2.1; #Since.release is #ID, so it cannot hold RC4 or Beta 5.16. As a
			result, Beta 5.16-only behaviour (extra lane, state locks, automation
			view, Velocity twice latching automation), RC4 behaviour (start scan and
			comb filter caveats) and the RC4/Beta split are only in prose.
			"""
		current_examples: [
			"`#Version` = `^(RC|Beta|SC|B|R)[0-9.]+S?$`.",
			"`#Since.release!: #ID`; `#ID` is lowercase-only.",
			"`#Release`, `#Since` and `#OfficialRef` are never referenced.",
		]
		expected_examples: [
			"Separate #ReleaseId from #FirmwareVersion; allow \"Beta 5.16\" and \"1.2.1\".",
			"Add since?: #Since and official_ref?: #OfficialRef to control states, functions and screen states.",
		]
	}
}
