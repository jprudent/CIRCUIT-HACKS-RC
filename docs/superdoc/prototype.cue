package ui

// Use CamelCase for types, uncaptitalized snake_case for properties and snake_case for values
// This ontology contains a description of the complete ui: what button does what in which state

// ── primitives ──────────────────────────────────────────────────────────
#Locale: "en" | "es" | "de" | "fr" | "it" | "pt" | "pt-BR" | "ja" | "ko" |
	"ru" | "zh-CN" | "nl" | "pl" | "sv" | "fi" | "da" | "cs" | "et" |
		"hr" | "lv" | "lt" | "ro" | "hu" | "no" | "sl" | "sk" | "el" | "bg"
#Version: =~"^(RC|Beta|SC|B|R)[0-9.]+S?$"
#ID:      =~"^[a-z][a-z0-9]*([_][a-z0-9]+)*$"
#Hex:     =~"^#[0-9a-fA-F]{6}$"
#Group:   "A" | "B" | "C" | "D" | "E"

// Localized copy. en is the fallback; docgen checks the published locales.
#Text: {
	en!:              string
	[locale=#Locale]: string
}

#Release: {
	version!:                #Version
	channel!:                "stable" | "beta" | "fix"
	date?:                   string
	officialFirmwareVersion: #Version
	officialFirmwareBuild:   =~"[0-9]+"
}

// To specify since when a behavior changed or a feature has been introduced
#Since: {
	release!: #ID
	kind!:    "feature" | "fix" | "beta-only"
}

// Reference to official documentation. The checksum identifies the exact PDF
// (see the documentation repository's manifest).
#OfficialRef: {
	doc!:      #ID
	section?:  string
	page?:     int & >=1
	checksum!: =~"^sha256:[0-9a-f]{64}$"
}

#Color: {
	id!:   #ID
	name!: #Text
	hex!:  #Hex
}

colors: [key=#ID]: #Color & {id: key}

// The guide names the colours; it does not give hex values. The hexes below
// come from the project's existing LED table, with dim/bright variants derived
// from the named colour.
colors: {
	// Track colours — User Guide v3, "Getting started", p. 21.
	violet: {
		name: {en: "violet", es: "violeta"}
		hex: "#9865ff"
	}
	pale_green: {
		name: {en: "pale green", es: "verde pálido"}
		hex: "#b6f23d"
	}
	blue: {
		name: {en: "blue", es: "azul"}
		hex: "#1a47ff"
	}
	pink: {
		name: {en: "pink", es: "rosa"}
		hex: "#ff4c7b"
	}
	orange: {
		name: {en: "orange", es: "naranja"}
		hex: "#ff4e13"
	}
	yellow: {
		name: {en: "yellow", es: "amarillo"}
		hex: "#ffff19"
	}
	purple: {
		name: {en: "purple", es: "púrpura"}
		hex: "#c63ac6"
	}
	aqua: {
		name: {en: "aqua", es: "aguamarina"}
		hex: "#00ffb5"
	}

	// State colours used throughout the guide.
	white: {
		name: {en: "white", es: "blanco"}
		hex: "#ffffff"
	}
	dim_white: {
		name: {en: "dim white", es: "blanco tenue"}
		hex: "#9aa0a6"
	}
	red: {
		name: {en: "red", es: "rojo"}
		hex: "#ff0000"
	}
	green: {
		name: {en: "green", es: "verde"}
		hex: "#00ff00"
	}
	pale_red: {
		name: {en: "pale red", es: "rojo pálido"}
		hex: "#ff8682"
	}
	dim_blue: {
		name: {en: "dim blue", es: "azul tenue"}
		hex: "#0d247f"
	}
	bright_blue: {
		name: {en: "bright blue", es: "azul brillante"}
		hex: "#4d6bff"
	}
	sand: {
		name: {en: "sand", es: "arena"}
		hex: "#fff1c4"
	}
	gold: {
		name: {en: "gold", es: "dorado"}
		hex: "#ffaf2f"
	}
}

// ── controls ────────────────────────────────────────────────────────────
// A pad is one of the 32 illuminated pads; knobs are the rotary controls;
// buttons are everything else.
#ControlKind: "pad" | "knob" | "button"

#Line: int

#Column: int
// TODO add check that line is between 1 and 4
// TODO add check that column is between 1 and 8

#Control: {
	id!:  #ID // required; the controls map injects it from the map key
	kind: #ControlKind
	// main function label printed on the device
	onDeviceMainLabel?: #Text
	// label corresponding to Shift mode printed on the device
	onDeviceShiftLabel?: #Text
	// only for the white step pads, row and column
	padGridCoordinates?: [int, int]
	// the natural colour of the control when the machine is off
	materialColor?: #Color
}

controls: [key=#ID]: #Control & {id: key}

// Top View, User Guide v3, p. 15-17.
controls: {
	// Rotary controls.
	master_filter: {kind: "knob", onDeviceMainLabel: {en: "Master Filter"}}
	master_volume: {kind: "knob", onDeviceMainLabel: {en: "Master Volume"}}

	// Macro controls 1 to 8. The panel legends describe their default synth functions.
	macro_1: {kind: "knob", onDeviceMainLabel: {en: "1 Oscillator"}}
	macro_2: {kind: "knob", onDeviceMainLabel: {en: "2 Oscillator Mod"}}
	macro_3: {kind: "knob", onDeviceMainLabel: {en: "3 Amp Envelope"}}
	macro_4: {kind: "knob", onDeviceMainLabel: {en: "4 Filter Envelope"}}
	macro_5: {kind: "knob", onDeviceMainLabel: {en: "5 Filter Frequency"}}
	macro_6: {kind: "knob", onDeviceMainLabel: {en: "6 Resonance"}}
	macro_7: {kind: "knob", onDeviceMainLabel: {en: "7 Modulation"}}
	macro_8: {kind: "knob", onDeviceMainLabel: {en: "8 FX"}}

	// Track buttons.
	synth_1: {kind: "button", onDeviceMainLabel: {en: "Synth 1"}}
	synth_2: {kind: "button", onDeviceMainLabel: {en: "Synth 2"}}
	midi_1: {kind: "button", onDeviceMainLabel: {en: "MIDI 1"}}
	midi_2: {kind: "button", onDeviceMainLabel: {en: "MIDI 2"}}
	drum_1: {kind: "button", onDeviceMainLabel: {en: "Drum 1"}}
	drum_2: {kind: "button", onDeviceMainLabel: {en: "Drum 2"}}
	drum_3: {kind: "button", onDeviceMainLabel: {en: "Drum 3"}}
	drum_4: {kind: "button", onDeviceMainLabel: {en: "Drum 4"}}

	// Step buttons. Probability is the Shift function of Pattern Settings.
	note: {kind: "button", onDeviceMainLabel: {en: "Note"}, onDeviceShiftLabel: {en: "Expand"}}
	velocity: {kind: "button", onDeviceMainLabel: {en: "Velocity"}, onDeviceShiftLabel: {en: "Fixed"}}
	gate: {kind: "button", onDeviceMainLabel: {en: "Gate"}, onDeviceShiftLabel: {en: "Micro Step"}}
	pattern_settings: {
		kind: "button"
		onDeviceMainLabel: {en: "Pattern Settings"}
		onDeviceShiftLabel: {en: "Probability"}
	}

	// Other top-panel buttons.
	scales: {kind: "button", onDeviceMainLabel: {en: "Scales"}}
	step_page: {kind: "button", onDeviceMainLabel: {en: "1-16\n17-32"}}
	patterns: {kind: "button", onDeviceMainLabel: {en: "Patterns"}, onDeviceShiftLabel: {en: "View Lock"}}
	mixer: {kind: "button", onDeviceMainLabel: {en: "Mixer"}}
	fx: {kind: "button", onDeviceMainLabel: {en: "FX"}, onDeviceShiftLabel: {en: "Side Chain"}}
	preset: {kind: "button", onDeviceMainLabel: {en: "Preset"}}
	record: {kind: "button", onDeviceMainLabel: {en: "Record"}, onDeviceShiftLabel: {en: "Rec Quantise"}}
	play: {kind: "button", onDeviceMainLabel: {en: "Play"}}
	tempo: {kind: "button", onDeviceMainLabel: {en: "Tempo\nSwing"}, onDeviceShiftLabel: {en: "Tap"}}
	clear: {kind: "button", onDeviceMainLabel: {en: "Clear"}, onDeviceShiftLabel: {en: "Click"}}
	duplicate: {kind: "button", onDeviceMainLabel: {en: "Duplicate"}, onDeviceShiftLabel: {en: "Mutate"}}
	save: {kind: "button", onDeviceMainLabel: {en: "Save"}}
	projects: {kind: "button", onDeviceMainLabel: {en: "Projects"}, onDeviceShiftLabel: {en: "Packs"}}
	shift: {kind: "button", onDeviceMainLabel: {en: "Shift"}}
	j: {kind: "button", onDeviceMainLabel: {en: "J"}}
	k: {kind: "button", onDeviceMainLabel: {en: "K"}}

	// Rear view, p. 18: the soft on/off switch.
	power: {kind: "button", onDeviceMainLabel: {en: "Power"}}

	// 32-pad playing grid, p. 15: 4 rows x 8 columns.
	pad_1_1: {kind: "pad", padGridCoordinates: [1, 1]}
	pad_1_2: {kind: "pad", padGridCoordinates: [1, 2]}
	pad_1_3: {kind: "pad", padGridCoordinates: [1, 3]}
	pad_1_4: {kind: "pad", padGridCoordinates: [1, 4]}
	pad_1_5: {kind: "pad", padGridCoordinates: [1, 5]}
	pad_1_6: {kind: "pad", padGridCoordinates: [1, 6]}
	pad_1_7: {kind: "pad", padGridCoordinates: [1, 7]}
	pad_1_8: {kind: "pad", padGridCoordinates: [1, 8]}
	pad_2_1: {kind: "pad", padGridCoordinates: [2, 1]}
	pad_2_2: {kind: "pad", padGridCoordinates: [2, 2]}
	pad_2_3: {kind: "pad", padGridCoordinates: [2, 3]}
	pad_2_4: {kind: "pad", padGridCoordinates: [2, 4]}
	pad_2_5: {kind: "pad", padGridCoordinates: [2, 5]}
	pad_2_6: {kind: "pad", padGridCoordinates: [2, 6]}
	pad_2_7: {kind: "pad", padGridCoordinates: [2, 7]}
	pad_2_8: {kind: "pad", padGridCoordinates: [2, 8]}
	pad_3_1: {kind: "pad", padGridCoordinates: [3, 1]}
	pad_3_2: {kind: "pad", padGridCoordinates: [3, 2]}
	pad_3_3: {kind: "pad", padGridCoordinates: [3, 3]}
	pad_3_4: {kind: "pad", padGridCoordinates: [3, 4]}
	pad_3_5: {kind: "pad", padGridCoordinates: [3, 5]}
	pad_3_6: {kind: "pad", padGridCoordinates: [3, 6]}
	pad_3_7: {kind: "pad", padGridCoordinates: [3, 7]}
	pad_3_8: {kind: "pad", padGridCoordinates: [3, 8]}
	pad_4_1: {kind: "pad", padGridCoordinates: [4, 1]}
	pad_4_2: {kind: "pad", padGridCoordinates: [4, 2]}
	pad_4_3: {kind: "pad", padGridCoordinates: [4, 3]}
	pad_4_4: {kind: "pad", padGridCoordinates: [4, 4]}
	pad_4_5: {kind: "pad", padGridCoordinates: [4, 5]}
	pad_4_6: {kind: "pad", padGridCoordinates: [4, 6]}
	pad_4_7: {kind: "pad", padGridCoordinates: [4, 7]}
	pad_4_8: {kind: "pad", padGridCoordinates: [4, 8]}
}

// ── screens and states ─────────────────────────────────────────────────
#Screen: {
	id:    #ID
	title: #Text
}

screens: [key=#ID]: #Screen & {id: key}
screens: {
	drum_1_note: {
		title: {en: "Drum 1 note view"}
	}
}

#Action: "press" | "hold" | "release" | "turn_left" | "turn_right"

// Effects are either prose or a transition. Transitions reference screen states and
// control states by ID, so a screen can merge the static controls without
// creating a structural cycle. The valid ID sets are derived below from the
// keys of the concrete screen_states and control_states maps.
#Effect: #Text | #ScreenStateID | #ControlStateID

#Light: "on" | "off" | "dim" | "bright" | "blink" | "flash"
#LightState: [#Light, #Color] | [#Light]

#ControlState: {
	light?: #LightState
	// An effect can change the hardware, another screen, or this control's state.
	usage: {
		press?: [...#Effect]
		hold?: [...#Effect]
		release?: [...#Effect]
		turn_left?: [...#Effect]
		turn_right?: [...#Effect]
	}
}

#ScreenState: {
	description: #Text
	// Active controls in that state.
	controls: [key=#ID]: #ControlState
}

// The hardware starts from a blank project.

// static controls always have the same effect, whatever the screen state they are in

static_controls: [key=#ID]: #ControlState
static_controls: {
	synth_1: {light: ["on", colors.violet], usage: {press: ["synth1_note_screen"]}}
	master_volume: {usage: {
		turn_left: [{en: "Lower the master volume"}]
		turn_right: [{en: "Raise the master volume"}]
	}}
	// fixme shift is contextual to a screen
	// shift: {light: ["on", colors.green], usage: {press: [{en: "Toggle sticky shift"}]}}
}

control_states: [key=#ID]: #ControlState
control_states: {
	// -- Drum 1 note view (User Guide v3, p. 60-61)

	drum_step_pad_state_inactive: {
		light: ["on", colors.dim_blue]
		usage: {
			press: [
				{en: "Assign the active sample to the pattern step"},
				"drum_step_pad_state_active",
			]
		}
	}
	drum_step_pad_state_active: {
		light: ["on", colors.bright_blue]
		usage: {
			press: [
				{en: "Unassign the active sample from the pattern step"},
				"drum_step_pad_state_inactive",
			]
		}
	}
}

// Only the keys of control_states are valid transition targets.
#ControlStateID: or([for k, _ in control_states {k}])

screen_states: [key=#ID]: #ScreenState
screen_states: {
	// -- Drum 1 note view (User Guide v3, p. 60-61)

	drum1_note_screen_state: {
		description: {en: "The first programmable drum track"}
		controls: {
			pad_1_1: control_states.drum_step_pad_state_inactive
			drum_1: {light: ["on", colors.orange], usage: {}}
			preset: {light: ["on", colors.dim_white], usage: {press: ["drum1_sample_selection"]}}
		} & static_controls
	}

	// -- Drum 1 sample selection (User Guide v3, p. 62)

	drum1_sample_selection: {
		description: {en: "Four rows of samples to select for the current drum track"}
		controls: {
			drum_1: {light: ["on", colors.orange], usage: {press: ["drum1_note_screen_state"]}}
			preset: {light: ["on", colors.orange], usage: {
				//TODO
			}}
		} & static_controls
	}

	// -- Synth 1 note view (User Guide v3, p. 27)

	synth1_note_screen: {
		description: {en: "The first programmable synth track"}
		controls: {} & static_controls
	}
}

// Only the keys of screen_states are valid transition targets.
#ScreenStateID: or([for k, _ in screen_states {k}])
