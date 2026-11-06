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
	magenta: {
		name: {en: "magenta", es: "magenta"}
		hex: "#ff00ff"
	}
	teal: {
		name: {en: "teal", es: "verde azulado"}
		hex: "#00c8b4"
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

// Effects are either prose or a transition. Transitions reference screen states and
// control states by ID, so a screen can merge the static controls without
// creating a structural cycle. The valid ID sets are derived below from the
// keys of the concrete screen_states and control_states maps.
#Effect: #Text | #ScreenStateID | #ControlStateID

#Light: "on" | "off" | "dim" | "bright" | "blink" | "flash"
#LightState: [#Light, #Color] | [#Light]

// The actions one control performs for one input layer: the normal layer
// (`usage`), the Shift layer (`shift_usage`) or a modifier-held gesture
// (`clear_usage`, `duplicate_usage`, `record_usage`). Each field lists what
// happens for that physical action; a list may mix prose and state IDs.
#Usage: {
	press?: [...#Effect]
	hold?: [...#Effect]
	release?: [...#Effect]
	turn_left?: [...#Effect]
	turn_right?: [...#Effect]
}

#ControlState: {
	light?: #LightState
	// The light shown while Shift is held, for the control's Shift function.
	shift_light?: #LightState
	// An effect can change the hardware, another screen, or this control's state.
	usage: #Usage
	// The Shift layer of the control: what it does while Shift is held.
    // FIXME shift mode is permanent until disabled, so a better design would be to
    // transition to another screen state when it is pressed
	shift_usage?: #Usage
	// Gestures that begin with a modifier held and then use this control.
	// They live on the control being used, not on the modifier button, so a
	// control owns its complete behaviour; the modifier button's own
	// `usage.hold` only gives the general instruction.
	//
	// clear_usage: Clear held, then this control. Examples: Clear + knob to
	// the right resets both layers of that knob; Clear + knob to the left
	// deletes that knob's automation; Clear + step deletes the hit and all
	// its parameters; Clear + a drum's track button resets its eight knobs.
	clear_usage?: #Usage
	//
	// duplicate_usage: Duplicate held, then this control. Examples:
	// Duplicate + step copies the step's data and waits for a destination;
	// Duplicate + sample pad A then pad B swaps the two samples;
	// Duplicate + Step Page extends the pattern and copies steps 1-16 to
	// steps 17-32.
	duplicate_usage?: #Usage
	//
	// record_usage: Record held, then this control. Examples: Record + step
	// writes an automation snapshot into the step (Beta 5.16); Record + a
	// drum knob assigns that parameter to the drum's extra lane (Beta 5.16);
	// Record + a sample pad records a live hit with its velocity.
	record_usage?: #Usage
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
	// Always active, in every view (User Guide v3, p. 15).
	master_filter: {
		light: ["on", colors.white]
		usage: {
			turn_left: [{en: "Lower the master filter frequency"}]
			turn_right: [{en: "Raise the master filter frequency"}]
		}
	}
	master_volume: {
		usage: {
			turn_left: [{en: "Lower the master volume"}]
			turn_right: [{en: "Raise the master volume"}]
		}
	}
	// Rear-panel soft switch (User Guide v3, p. 18).
	power: {
		usage: {
			hold: [{en: "Long-press for about one second to turn the unit on or off; the LED lights green while the internal battery charges"}]
		}
	}
}

control_states: [key=#ID]: #ControlState
control_states: {
	// ── Drum 1 Note view: pattern step pads (pads 1-16) ──────────────────
	// User Guide v3, p. 60-65: dim pale blue = no hit, bright blue = hit,
	// pink = sample flip, red = step held for sample flip.

	drum_step_pad_state_inactive: {
		light: ["on", colors.dim_blue]
		usage: {
			press: [
				{en: "Assign the active sample to the pattern step; the step lights bright blue"},
				"drum_step_pad_state_active",
			]
			hold: [
				{en: "Hold the step to choose the sample it triggers; the step turns red and the sample pad it uses also turns red"},
				"drum_step_pad_state_held",
			]
		}
		duplicate_usage: {
			press: [{en: "Copy this step's data; then press another step to paste it"}]
		}
		record_usage: {
			press: [{en: "With Record held, write a snapshot of pitch, decay, distortion and EQ into this step (Beta 5.16); the step lights yellow while it is held and still has no hit"}]
		}
	}
	drum_step_pad_state_active: {
		light: ["on", colors.bright_blue]
		usage: {
			press: [
				{en: "Delete the drum hit from the pattern step; the step goes back to dim blue"},
				"drum_step_pad_state_inactive",
			]
			hold: [
				{en: "Hold the step to choose another sample for it; the step and the sample it uses turn red"},
				"drum_step_pad_state_held",
			]
		}
		clear_usage: {
			press: [
				{en: "Delete the hit and all its parameters: velocity, micro steps, probability and sample flip"},
				"drum_step_pad_state_inactive",
			]
		}
		duplicate_usage: {
			press: [{en: "Copy this step's data; then press another step to paste it"}]
		}
		record_usage: {
			press: [{en: "With Record held, write a snapshot of pitch, decay, distortion and EQ into this step (Beta 5.16); the step lights yellow while it is held"}]
		}
	}
	drum_step_pad_state_flipped: {
		light: ["on", colors.pink]
		usage: {
			press: [
				{en: "Delete the drum hit and its sample flip from the pattern step; the step goes back to dim blue"},
				"drum_step_pad_state_inactive",
			]
			hold: [
				{en: "Hold the step to see and change the sample it triggers; the step turns red and that sample's pad also turns red"},
				"drum_step_pad_state_held",
			]
		}
		clear_usage: {
			press: [
				{en: "Delete the hit and all its parameters: velocity, micro steps, probability and sample flip"},
				"drum_step_pad_state_inactive",
			]
		}
		duplicate_usage: {
			press: [{en: "Copy this step's data; then press another step to paste it"}]
		}
		record_usage: {
			press: [{en: "With Record held, write a snapshot of pitch, decay, distortion and EQ into this step (Beta 5.16); the step lights yellow while it is held"}]
		}
	}
	drum_step_pad_state_held: {
		light: ["on", colors.red]
		usage: {
			hold: [{en: "While the step is held, press a sample pad to assign that sample to it; the step becomes pink if the sample is not the active one"}]
			release: [{en: "Let go to return the step to its normal colour: bright blue with the active sample, pink with a flipped sample"}]
		}
	}

	// ── Drum 1 Note view: sample pads (pads 17-32) ───────────────────────
	// User Guide v3, p. 60-65: dim orange = not the active sample,
	// bright orange = active sample, red = sample assigned to a held step.

	drum_sample_pad_state_inactive: {
		light: ["dim", colors.orange]
		usage: {
			press: [
				{en: "Audition the sample and make it the active sample; while a pattern step is held, assign this sample to that step as its sample flip"},
				"drum_sample_pad_state_active",
			]
			hold: [{en: "Play the sample without changing the active sample"}]
		}
		record_usage: {
			press: [{en: "With Record and Play, record a hit with this sample at the current step; with Rec Quantise off it lands on the nearest micro step, and its velocity is the pad's strike"}]
		}
	}
	drum_sample_pad_state_active: {
		light: ["on", colors.orange]
		usage: {
			press: [{en: "Audition the active sample; while a pattern step is held, assign this sample to that step"}]
			hold: [{en: "Play the sample; the active sample does not change"}]
		}
		record_usage: {
			press: [{en: "With Record and Play, record a hit with this sample at the current step; with Rec Quantise off it lands on the nearest micro step, and its velocity is the pad's strike"}]
		}
	}
	drum_sample_pad_state_flip_target: {
		light: ["on", colors.red]
		usage: {
			press: [{en: "The sample assigned to the held step; press another sample pad to choose a different sample for it"}]
			release: [{en: "When the step is let go, the pad returns to bright orange if it is the active sample or dim orange otherwise"}]
		}
	}

	// ── Drum 1 Note view: macro knobs (K1-K8) ────────────────────────────
	// RC: all eight knobs are active on a drum. The LED is the drum's
	// orange; its brightness follows the setting (bipolar knobs are dark in
	// the middle). Shift gives the second layer. Clear + knob right resets
	// both layers; Clear + knob left deletes that knob's automation.

	drum_knob_k1_state: {
		light: ["on", colors.orange]
		usage: {
			turn_left: [{en: "Lower the pitch (the stock pitch control, continuous as on the original); chromatic-view pads transpose on top"}]
			turn_right: [{en: "Raise the pitch"}]
		}
		shift_usage: {
			turn_left: [{en: "Lower the pitch envelope amount"}]
			turn_right: [{en: "Raise the pitch envelope amount"}]
		}
		clear_usage: {
			turn_right: [{en: "Put pitch and pitch envelope back to their defaults; the LED shows lavender"}]
			turn_left: [{en: "Delete the pitch automation in the playing pattern; the LED shows red"}]
		}
		record_usage: {
			turn_left: [{en: "No extra-lane assignment for K1: it is the pitch lane; the extra lane's factory setting is the chromatic pitch"}]
			turn_right: [{en: "No extra-lane assignment for K1: it is the pitch lane; the extra lane's factory setting is the chromatic pitch"}]
		}
	}
	drum_knob_k2_state: {
		light: ["on", colors.orange]
		usage: {
			turn_left: [{en: "Lower the ring-mod frequency"}]
			turn_right: [{en: "Raise the ring-mod frequency"}]
		}
		shift_usage: {
			turn_left: [{en: "Lower the ring-mod amount"}]
			turn_right: [{en: "Raise the ring-mod amount"}]
		}
		clear_usage: {
			turn_right: [{en: "Put ring-mod frequency and amount back to their defaults; the LED shows lavender"}]
			turn_left: [{en: "Delete the ring-mod frequency automation in the playing pattern; the LED shows red"}]
		}
		record_usage: {
			turn_left: [{en: "Assign ring-mod frequency to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}]
			turn_right: [{en: "Assign ring-mod frequency to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}]
		}
	}
	drum_knob_k3_state: {
		light: ["on", colors.orange]
		usage: {
			turn_left: [{en: "Left of centre: shorten the decay (the stock decay control)"}]
			turn_right: [{en: "Past the decay's maximum: add attack (fade-in, up to 1 s); the LED is white"}]
		}
		shift_usage: {
			turn_left: [{en: "Left of centre: move the sample start into the sample (up to 120/128 of the whole sample)"}]
			turn_right: [{en: "Right of centre: cut the sample from the end (up to 120/128); the LED is white"}]
		}
		clear_usage: {
			turn_right: [{en: "Put attack, sample start and cut back to 0; the LED shows lavender"}]
			turn_left: [{en: "Delete the decay automation in the playing pattern; the LED shows red"}]
		}
		record_usage: {
			turn_left: [{en: "No extra-lane assignment for K3; its attack, start and cut have no lane (state locks can store them in Beta 5.16)"}]
			turn_right: [{en: "No extra-lane assignment for K3; its attack, start and cut have no lane (state locks can store them in Beta 5.16)"}]
		}
	}
	drum_knob_k4_state: {
		light: ["on", colors.orange]
		usage: {
			turn_left: [{en: "Lower the filter-envelope amount"}]
			turn_right: [{en: "Raise the filter-envelope amount"}]
		}
		shift_usage: {
			turn_left: [{en: "Choose the previous envelope shape"}]
			turn_right: [{en: "Choose the next envelope shape"}]
		}
		clear_usage: {
			turn_right: [{en: "Put the filter envelope and its shape back to their defaults; the LED shows lavender"}]
			turn_left: [{en: "Delete the filter-envelope automation in the playing pattern; the LED shows red"}]
		}
		record_usage: {
			turn_left: [{en: "Assign the filter envelope to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}]
			turn_right: [{en: "Assign the filter envelope to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}]
		}
	}

	drum_knob_k5_state: {
		light: ["on", colors.orange]
		usage: {
			turn_left: [{en: "Move the filter / EQ down (by default the stock tilt EQ)"}]
			turn_right: [{en: "Move the filter / EQ up"}]
		}
		shift_usage: {
			turn_left: [{en: "Choose the previous filter mode: stock tilt EQ, band-pass, notch, comb or DJ"}]
			turn_right: [{en: "Choose the next filter mode: stock tilt EQ, band-pass, notch, comb or DJ"}]
		}
		clear_usage: {
			turn_right: [{en: "Put the filter / EQ and the filter mode back to their defaults; the LED shows lavender"}]
			turn_left: [{en: "Delete the filter-frequency automation in the playing pattern; the LED shows red"}]
		}
		record_usage: {
			turn_left: [{en: "No extra-lane assignment for K5; the filter mode is a new knob with no lane (state locks can store it in Beta 5.16)"}]
			turn_right: [{en: "No extra-lane assignment for K5; the filter mode is a new knob with no lane (state locks can store it in Beta 5.16)"}]
		}
	}
	drum_knob_k6_state: {
		light: ["on", colors.orange]
		usage: {
			turn_left: [{en: "Lower the resonance"}]
			turn_right: [{en: "Raise the resonance"}]
		}
		// No Shift function on the drums.
		clear_usage: {
			turn_right: [{en: "Put the resonance back to its default; the LED shows lavender"}]
			turn_left: [{en: "Delete the resonance automation in the playing pattern; the LED shows red"}]
		}
		record_usage: {
			turn_left: [{en: "Assign resonance to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}]
			turn_right: [{en: "Assign resonance to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}]
		}
	}
	drum_knob_k7_state: {
		light: ["on", colors.orange]
		usage: {
			turn_left: [{en: "Left of centre: start scan / vibrato amount; each hit starts where the LFO is, from the Shift + K3 start up to a 64th of the sample further for every step of the knob"}]
			turn_right: [{en: "Right of centre: tremolo depth"}]
		}
		shift_usage: {
			turn_left: [{en: "Move the LFO speed towards the synced rates (bipolar: left is synced to the tempo, from 1/16T out to 8 bars)"}]
			turn_right: [{en: "Move the LFO speed towards the free rates (right is free and faster further right; 0.2 at the centre)"}]
		}
		clear_usage: {
			turn_right: [{en: "Put the LFO amount and speed back to their defaults; the LED shows lavender"}]
			turn_left: [{en: "Delete the LFO automation in the playing pattern; the LED shows red"}]
		}
		record_usage: {
			turn_left: [{en: "Assign the LFO amount to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}]
			turn_right: [{en: "Assign the LFO amount to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}]
		}
	}
	drum_knob_k8_state: {
		light: ["on", colors.orange]
		usage: {
			turn_left: [{en: "Left of 0: add bitcrush; otherwise lower the distortion"}]
			turn_right: [{en: "Add distortion"}]
		}
		shift_usage: {
			turn_left: [{en: "Choose the previous distortion type: stock, soft, hard or fold"}]
			turn_right: [{en: "Choose the next distortion type: stock, soft, hard or fold"}]
		}
		clear_usage: {
			turn_right: [{en: "Put distortion and its type back to their defaults and remove the bitcrush; the LED shows lavender"}]
			turn_left: [{en: "Delete the distortion automation in the playing pattern; the LED shows red"}]
		}
		record_usage: {
			turn_left: [{en: "No extra-lane assignment for K8; distortion is in its own lane and the distortion type has no lane (state locks can store it in Beta 5.16)"}]
			turn_right: [{en: "No extra-lane assignment for K8; distortion is in its own lane and the distortion type has no lane (state locks can store it in Beta 5.16)"}]
		}
	}

	// ── Track buttons ────────────────────────────────────────────────────
	// User Guide v3, p. 16-17 and GUIA 0.2 / 5.1.

	drum_1_track_button_state: {
		light: ["on", colors.orange]
		usage: {
			press: [{en: "Keep Drum 1 selected; its Note view stays on screen"}]
			hold: [{en: "Hold Drum 1 and press Drum 2 (or hold Drum 3 and press Drum 4) to make a stereo pair; the same gesture undoes it; not with Shift, Clear or Duplicate held"}]
		}
		clear_usage: {
			press: [{en: "Reset Drum 1's eight knobs, both layers, and delete their automation in the playing pattern"}]
		}
	}
	drum_2_track_button_state: {
		light: ["dim", colors.yellow]
		usage: {
			press: [
				{en: "Open Drum 2's Note view; while Drum 1 is held, pair Drum 2 with it as a stereo pair"},
				"drum2_note_screen_state",
			]
			hold: [{en: "Hold Drum 2 and press Drum 1 to pair them as a stereo pair; the same gesture undoes it"}]
		}
		clear_usage: {
			press: [{en: "Reset Drum 2's eight knobs, both layers, and delete their automation in the playing pattern"}]
		}
	}
	drum_3_track_button_state: {
		light: ["dim", colors.purple]
		usage: {
			press: [
				{en: "Open Drum 3's Note view; while Drum 4 is held, pair Drum 3 with it as a stereo pair"},
				"drum3_note_screen_state",
			]
			hold: [{en: "Hold Drum 3 and press Drum 4 to pair them as a stereo pair; the same gesture undoes it"}]
		}
		clear_usage: {
			press: [{en: "Reset Drum 3's eight knobs, both layers, and delete their automation in the playing pattern"}]
		}
	}
	drum_4_track_button_state: {
		light: ["dim", colors.aqua]
		usage: {
			press: [
				{en: "Open Drum 4's Note view; while Drum 3 is held, pair Drum 4 with it as a stereo pair"},
				"drum4_note_screen_state",
			]
			hold: [{en: "Hold Drum 4 and press Drum 3 to pair them as a stereo pair; the same gesture undoes it"}]
		}
		clear_usage: {
			press: [{en: "Reset Drum 4's eight knobs, both layers, and delete their automation in the playing pattern"}]
		}
	}
	synth_1_track_button_state: {
		light: ["dim", colors.violet]
		usage: {
			press: [
				{en: "Open Synth 1's Note view"},
				"synth1_note_screen",
			]
		}
		clear_usage: {
			press: [{en: "Put Synth 1's eight macros back to the loaded patch's values"}]
		}
		shift_usage: {
			press: [{en: "Open Synth 1's source view (Shift + Synth 1)"}]
		}
	}
	synth_2_track_button_state: {
		light: ["dim", colors.pale_green]
		usage: {
			press: [
				{en: "Open Synth 2's Note view"},
				"synth2_note_screen",
			]
		}
		clear_usage: {
			press: [{en: "Put Synth 2's eight macros back to the loaded patch's values"}]
		}
		shift_usage: {
			press: [{en: "Open Synth 2's source view (Shift + Synth 2)"}]
		}
	}
	midi_1_track_button_state: {
		light: ["dim", colors.blue]
		usage: {
			press: [
				{en: "Open MIDI 1's Note view"},
				"midi1_note_screen",
			]
		}
		clear_usage: {
			press: [{en: "Reset MIDI 1's own-synth engine to its defaults"}]
		}
		shift_usage: {
			press: [{en: "Open MIDI 1's Preset view (Shift + MIDI 1)"}]
		}
	}
	midi_2_track_button_state: {
		light: ["dim", colors.pink]
		usage: {
			press: [
				{en: "Open MIDI 2's Note view"},
				"midi2_note_screen",
			]
		}
		clear_usage: {
			press: [{en: "Reset MIDI 2's own-synth engine to its defaults"}]
		}
		shift_usage: {
			press: [{en: "Open MIDI 2's Preset view (Shift + MIDI 2)"}]
		}
	}

	// ── Step buttons ─────────────────────────────────────────────────────
	// User Guide v3, p. 16 and 60-70; GUIA 4.2 / 4.3.

	note_button_state: {
		light: ["on", colors.orange]
		shift_light: ["on", colors.yellow]
		usage: {
			press: [
				{en: "Open the Expanded Drum View (Note twice)"},
				"drum1_expanded_view",
			]
		}
		shift_usage: {
			press: [
				{en: "Open the Expanded Drum View (Shift + Note)"},
				"drum1_expanded_view",
			]
		}
	}
	velocity_button_state_variable: {
		light: ["off"]
		shift_light: ["on", colors.red]
		usage: {
			press: [
				{en: "Open the Drum 1 Velocity view"},
				"drum1_velocity_view",
			]
		}
		shift_usage: {
			press: [
				{en: "Switch fixed velocity on; with Shift held the button turns green"},
				"velocity_button_state_fixed",
			]
		}
	}
	velocity_button_state_fixed: {
		light: ["off"]
		shift_light: ["on", colors.green]
		usage: {
			press: [
				{en: "Open the Drum 1 Velocity view"},
				"drum1_velocity_view",
			]
		}
		shift_usage: {
			press: [
				{en: "Switch fixed velocity off; with Shift held the button turns red"},
				"velocity_button_state_variable",
			]
		}
	}
	gate_button_state: {
		light: ["off"]
		shift_light: ["on", colors.yellow]
		usage: {
			press: [
				{en: "Open the Drum 1 Gate view, where pads 17-22 set the micro steps"},
				"drum1_gate_view",
			]
		}
		shift_usage: {
			press: [
				{en: "Open the Micro Step view (Shift + Gate)"},
				"drum1_micro_step_view",
			]
		}
	}
	pattern_settings_button_state: {
		light: ["off"]
		shift_light: ["on", colors.yellow]
		usage: {
			press: [
				{en: "Open Drum 1's Pattern Settings view"},
				"drum1_pattern_settings",
			]
		}
		shift_usage: {
			press: [
				{en: "Open the Probability view (Shift + Pattern Settings)"},
				"drum1_probability_view",
			]
		}
	}

	// ── Other top-panel buttons ──────────────────────────────────────────

	scales_button_state: {
		light: ["off"]
		shift_light: ["on", colors.yellow]
		usage: {
			press: [
				{en: "Open the Scales view"},
				"scales_view",
			]
		}
		shift_usage: {
			press: [
				{en: "Open the Scales view with the custom-scale editor"},
				"scales_custom_view",
			]
		}
	}
	// Step Page (1-16/17-32), User Guide v3, p. 75.
	step_page_button_state_16: {
		light: ["on", colors.dim_blue]
		usage: {
			press: [
				{en: "Extend the pattern to 32 steps; Page 1 is shown and the button turns bright blue"},
				"step_page_button_state_32_page1",
			]
		}
		clear_usage: {
			press: [{en: "Set the pattern back to 16 steps; steps 17-32 are kept but do not play"}]
		}
		duplicate_usage: {
			press: [
				{en: "Extend the pattern to 32 steps and copy steps 1-16 to steps 17-32, including automation"},
				"step_page_button_state_32_page1",
			]
		}
	}
	step_page_button_state_32_page1: {
		light: ["on", colors.bright_blue]
		usage: {
			press: [
				{en: "Show Page 2, steps 17-32; the button turns orange"},
				"step_page_button_state_32_page2",
			]
		}
		clear_usage: {
			press: [
				{en: "Set the pattern back to 16 steps; steps 17-32 are kept"},
				"step_page_button_state_16",
			]
		}
		duplicate_usage: {
			press: [
				{en: "Copy steps 1-16 to steps 17-32, overwriting Page 2"},
				"step_page_button_state_32_page1",
			]
		}
	}
	step_page_button_state_32_page2: {
		light: ["on", colors.orange]
		usage: {
			press: [
				{en: "Show Page 1, steps 1-16; the button turns bright blue"},
				"step_page_button_state_32_page1",
			]
		}
		clear_usage: {
			press: [
				{en: "Set the pattern back to 16 steps; steps 17-32 are kept"},
				"step_page_button_state_16",
			]
		}
		duplicate_usage: {
			press: [
				{en: "Copy steps 1-16 to steps 17-32, overwriting Page 2"},
				"step_page_button_state_32_page1",
			]
		}
	}
	// Patterns and View Lock, User Guide v3, p. 80.
	patterns_button_state_view_lock_off: {
		light: ["off"]
		shift_light: ["on", colors.red]
		usage: {
			press: [
				{en: "Open the Patterns view"},
				"patterns_view",
			]
		}
		shift_usage: {
			press: [
				{en: "Turn View Lock on; with Shift held the button turns green when it is active"},
				"patterns_button_state_view_lock_on",
			]
		}
	}
	patterns_button_state_view_lock_on: {
		light: ["off"]
		shift_light: ["on", colors.green]
		usage: {
			press: [
				{en: "Open the Patterns view"},
				"patterns_view",
			]
		}
		shift_usage: {
			press: [
				{en: "Turn View Lock off; with Shift held the button turns red when it is inactive"},
				"patterns_button_state_view_lock_off",
			]
		}
	}

	mixer_button_state: {
		light: ["off"]
		usage: {
			press: [
				{en: "Open the Mixer view; press Mixer again there to open Master FX"},
				"mixer_view",
			]
		}
	}
	fx_button_state: {
		light: ["off"]
		shift_light: ["on", colors.yellow]
		usage: {
			press: [
				{en: "Open the FX view"},
				"fx_view",
			]
		}
		shift_usage: {
			press: [
				{en: "Open the Sidechain view (Shift + FX)"},
				"sidechain_view",
			]
		}
	}
	preset_button_state: {
		light: ["off"]
		shift_light: ["on", colors.yellow]
		usage: {
			press: [
				{en: "Open Drum 1's Preset (sample) view"},
				"drum1_sample_selection",
			]
		}
		shift_usage: {
			press: [
				{en: "Open the drum's chromatic and scale view (Shift + Preset)"},
				"drum1_chromatic_view",
			]
		}
	}
	record_button_state_off: {
		light: ["off"]
		usage: {
			press: [
				{en: "Enter Record Mode; the button lights bright red and the playback cursor turns red"},
				"record_button_state_on",
			]
			hold: [{en: "Momentary Record: record only while the button is held"}]
		}
		shift_usage: {
			press: [{en: "Toggle Record Quantise; with Shift held the button is bright green when quantise is enabled and dim red when it is off"}]
		}
	}
	record_button_state_on: {
		light: ["on", colors.red]
		usage: {
			press: [
				{en: "Leave Record Mode; the button goes dark and the playback cursor returns to white"},
				"record_button_state_off",
			]
			hold: [{en: "Momentary Record: keep recording while held; releasing returns to the previous mode"}]
		}
		shift_usage: {
			press: [{en: "Toggle Record Quantise; with Shift held the button is bright green when quantise is enabled and dim red when it is off"}]
		}
	}
	play_button_state_off: {
		light: ["off"]
		shift_light: ["on", colors.yellow]
		usage: {
			press: [
				{en: "Start playback; the button lights bright green and the playback cursor is white"},
				"play_button_state_on",
			]
			hold: [{en: "With Record armed and the count-in on, start one bar of count-in; Record blinks red"}]
		}
		shift_usage: {
			press: [{en: "Quantize the selected track's pattern; with Shift held the button is yellow and it turns green after quantizing"}]
		}
	}
	play_button_state_on: {
		light: ["on", colors.green]
		shift_light: ["on", colors.yellow]
		usage: {
			press: [
				{en: "Stop playback; the button goes dark"},
				"play_button_state_off",
			]
		}
		shift_usage: {
			press: [{en: "Quantize the selected track's pattern; with Shift held the button is yellow and it turns green after quantizing"}]
		}
	}
	tempo_button_state: {
		light: ["off"]
		shift_light: ["on", colors.yellow]
		usage: {
			press: [
				{en: "Open the Tempo/Swing view; K1 sets the tempo, K2 the swing and K5 the click level"},
				"tempo_view",
			]
		}
		shift_usage: {
			press: [{en: "Tap tempo: tap the button in time with the track"}]
		}
	}

	// Clear and the four metronome states (GUIA 0.2). The normal LED is off;
	// while Shift is held the LED shows the metronome state.
	clear_button_state_no_metronome: {
		light: ["off"]
		shift_light: ["on", colors.red]
		usage: {
			hold: [{en: "Hold Clear and use another control for its Clear gesture: reset a knob, delete a step or delete its automation"}]
		}
		shift_usage: {
			press: [
				{en: "Next metronome state: metronome on; with Shift held the button turns green"},
				"clear_button_state_metronome",
			]
		}
	}
	clear_button_state_metronome: {
		light: ["off"]
		shift_light: ["on", colors.green]
		usage: {
			hold: [{en: "Hold Clear and use another control for its Clear gesture: reset a knob, delete a step or delete its automation"}]
		}
		shift_usage: {
			press: [
				{en: "Next metronome state: count-in only; with Shift held the button turns magenta"},
				"clear_button_state_count_in",
			]
		}
	}
	clear_button_state_count_in: {
		light: ["off"]
		shift_light: ["on", colors.magenta]
		usage: {
			hold: [{en: "Hold Clear and use another control for its Clear gesture: reset a knob, delete a step or delete its automation"}]
		}
		shift_usage: {
			press: [
				{en: "Next metronome state: count-in and metronome; with Shift held the button turns teal"},
				"clear_button_state_both",
			]
		}
	}
	clear_button_state_both: {
		light: ["off"]
		shift_light: ["on", colors.teal]
		usage: {
			hold: [{en: "Hold Clear and use another control for its Clear gesture: reset a knob, delete a step or delete its automation"}]
		}
		shift_usage: {
			press: [
				{en: "Back to no metronome; with Shift held the button turns red"},
				"clear_button_state_no_metronome",
			]
		}
	}
	duplicate_button_state: {
		light: ["off"]
		shift_light: ["on", colors.yellow]
		usage: {
			hold: [{en: "Hold Duplicate and press a step, pad or track button for its Duplicate gesture; for example, Duplicate + step copies the step's data"}]
		}
		shift_usage: {
			press: [{en: "Mutate the selected pattern: shuffle its notes or hits to different steps, with all their step parameters"}]
		}
	}
	save_button_state: {
		light: ["off"]
		usage: {
			press: [{en: "Save the project; in the S builds and the internal-memory pack nothing is written to the card and the LED turns red"}]
		}
	}
	projects_button_state: {
		light: ["off"]
		shift_light: ["on", colors.yellow]
		usage: {
			press: [
				{en: "Open the Projects view"},
				"projects_view",
			]
		}
		shift_usage: {
			press: [
				{en: "Open the Packs view (Shift + Projects)"},
				"packs_view",
			]
		}
	}
	shift_button_state: {
		light: ["off"]
		shift_light: ["on", colors.green]
		usage: {
			hold: [{en: "Hold Shift for the second functions; while it is held the available shortcuts light yellow"}]
			press: [{en: "With Sticky Shift enabled, a press keeps Shift held until it is pressed again; the button is bright green"}]
		}
	}
	j_button_state: {
		light: ["dim", colors.white]
		usage: {
			press: [{en: "Show the previous page of 16 drum samples; the J and K LEDs brighten to show which page is on screen"}]
		}
	}
	k_button_state: {
		light: ["dim", colors.white]
		usage: {
			press: [{en: "Show the next page of 16 drum samples; the J and K LEDs brighten to show which page is on screen"}]
		}
	}
}

// Only the keys of control_states are valid transition targets.
#ControlStateID: or([for k, _ in control_states {k}])

screen_states: [key=#ID]: #ScreenState
screen_states: {
	// -- Drum 1 Note view (User Guide v3, p. 60-65) ----------------------
	// Exhaustive: every pad, knob and button is mapped to a full control state.
	// Rows 1-2 are pattern steps 1-16; rows 3-4 are one page of 16 drum
	// samples. The blank project starts with empty steps, on sample page 1
	// with sample 1 active.

	drum1_note_screen_state: {
		description: {en: "Drum 1 Note view: the two upper rows are pattern steps 1-16; the two lower rows are one page of 16 drum samples. The blank project starts with empty steps, sample page 1 shown and sample 1 active."}
		controls: {
			// Pattern steps 1-16.
			pad_1_1: control_states.drum_step_pad_state_inactive
			pad_1_2: control_states.drum_step_pad_state_inactive
			pad_1_3: control_states.drum_step_pad_state_inactive
			pad_1_4: control_states.drum_step_pad_state_inactive
			pad_1_5: control_states.drum_step_pad_state_inactive
			pad_1_6: control_states.drum_step_pad_state_inactive
			pad_1_7: control_states.drum_step_pad_state_inactive
			pad_1_8: control_states.drum_step_pad_state_inactive
			pad_2_1: control_states.drum_step_pad_state_inactive
			pad_2_2: control_states.drum_step_pad_state_inactive
			pad_2_3: control_states.drum_step_pad_state_inactive
			pad_2_4: control_states.drum_step_pad_state_inactive
			pad_2_5: control_states.drum_step_pad_state_inactive
			pad_2_6: control_states.drum_step_pad_state_inactive
			pad_2_7: control_states.drum_step_pad_state_inactive
			pad_2_8: control_states.drum_step_pad_state_inactive

			// One page of 16 drum samples; sample 1 is the active sample.
			pad_3_1: control_states.drum_sample_pad_state_active
			pad_3_2: control_states.drum_sample_pad_state_inactive
			pad_3_3: control_states.drum_sample_pad_state_inactive
			pad_3_4: control_states.drum_sample_pad_state_inactive
			pad_3_5: control_states.drum_sample_pad_state_inactive
			pad_3_6: control_states.drum_sample_pad_state_inactive
			pad_3_7: control_states.drum_sample_pad_state_inactive
			pad_3_8: control_states.drum_sample_pad_state_inactive
			pad_4_1: control_states.drum_sample_pad_state_inactive
			pad_4_2: control_states.drum_sample_pad_state_inactive
			pad_4_3: control_states.drum_sample_pad_state_inactive
			pad_4_4: control_states.drum_sample_pad_state_inactive
			pad_4_5: control_states.drum_sample_pad_state_inactive
			pad_4_6: control_states.drum_sample_pad_state_inactive
			pad_4_7: control_states.drum_sample_pad_state_inactive
			pad_4_8: control_states.drum_sample_pad_state_inactive

			// The eight macro knobs are the drum's K1-K8.
			macro_1: control_states.drum_knob_k1_state
			macro_2: control_states.drum_knob_k2_state
			macro_3: control_states.drum_knob_k3_state
			macro_4: control_states.drum_knob_k4_state
			macro_5: control_states.drum_knob_k5_state
			macro_6: control_states.drum_knob_k6_state
			macro_7: control_states.drum_knob_k7_state
			macro_8: control_states.drum_knob_k8_state

			// Track and step buttons.
			drum_1:           control_states.drum_1_track_button_state
			drum_2:           control_states.drum_2_track_button_state
			drum_3:           control_states.drum_3_track_button_state
			drum_4:           control_states.drum_4_track_button_state
			synth_1:          control_states.synth_1_track_button_state
			synth_2:          control_states.synth_2_track_button_state
			midi_1:           control_states.midi_1_track_button_state
			midi_2:           control_states.midi_2_track_button_state
			note:             control_states.note_button_state
			velocity:         control_states.velocity_button_state_variable
			gate:             control_states.gate_button_state
			pattern_settings: control_states.pattern_settings_button_state

			// Other top-panel buttons.
			scales:    control_states.scales_button_state
			step_page: control_states.step_page_button_state_16
			patterns:  control_states.patterns_button_state_view_lock_off
			mixer:     control_states.mixer_button_state
			fx:        control_states.fx_button_state
			preset:    control_states.preset_button_state
			record:    control_states.record_button_state_off
			play:      control_states.play_button_state_off
			tempo:     control_states.tempo_button_state
			clear:     control_states.clear_button_state_no_metronome
			duplicate: control_states.duplicate_button_state
			save:      control_states.save_button_state
			projects:  control_states.projects_button_state
			shift:     control_states.shift_button_state
			j:         control_states.j_button_state
			k:         control_states.k_button_state
		} & static_controls
	}

	// -- Drum 1 Expanded view ------------------------------------------
	// TODO: stub. Make exhaustive.
	// User Guide v3, p. 61-62: Shift + Note, or Note twice from Note View,
	// opens Expanded Drum View. All grid pads except 29-32 are disabled;
	// pads 29-32 are the playing pads for Drums 1-4 and use each drum's
	// current active sample. Play in real time or record with Record;
	// Rec Quantise puts hits on a pattern step, otherwise on one of the six
	// micro steps. It works while a pattern is playing too.
	// RC (GUIA 5.3): rows 1-3 are micro-step rollers. Each column belongs to
	// the drum of its mirrored box below: columns 1-4 = Drums 4-1,
	// columns 5-8 = Drums 1-4; the left column is micro steps 1-3 and the
	// right column 4-6. Drum 1 = pads 4, 12, 20 and 5, 13, 21. While a roller
	// is held the drum plays on every step at those micro steps, with the
	// step's velocity or 100 on an empty step; stopped, it runs at the
	// project's tempo from the first press. With Record the hits are written
	// into the pattern. Pads 25-28 mirror the boxes of Drums 4-1.
	drum1_expanded_view: {
		description: {en: "All four drum tracks on one grid: pads 29-32 play Drums 1-4, and rows 1-3 are the RC's micro-step rollers"}
		controls: static_controls
	}

	// -- Drum 1 Velocity view ------------------------------------------
	// TODO: stub. Make exhaustive.
	// User Guide v3, p. 68-70: rows 1-2 are the 16 pattern steps; rows 3-4
	// are a 16-segment velocity fader. The selected step pulses blue/white;
	// the first N fader pads light sand (8 per pad, the last one dim for a
	// remainder). Press a step to hear its hit; press a fader pad to set that
	// step's velocity; holding a step while the pattern plays freezes the
	// fader on that step. Hold a step and press a fader pad to add a ghost
	// hit with that velocity.
	// RC: this is also a drum automation view (Beta 5.16, see
	// drum1_automation_view). Fixed velocity stays on Shift + Velocity.
	drum1_velocity_view: {
		description: {en: "Drum 1 Velocity view: pattern steps on the two upper rows and a 16-segment velocity fader on the two lower rows"}
		controls: static_controls
	}

	// -- Drum 1 Gate view ----------------------------------------------
	// TODO: stub. Make exhaustive.
	// User Guide v3, p. 66-68: rows 1-2 are the pattern steps; pads 17-22 are
	// micro steps 1-6. Press a lit step to display its micro steps; each micro
	// step pad toggles on/off. Several micro steps mean several hits in the
	// step, each with the step's velocity and sample. Adding micro steps to an
	// empty step creates hits with the current default sample. For drums this
	// Gate view is the micro-step editor; the official manual does not give
	// the drums a separate Micro Step view.
	drum1_gate_view: {
		description: {en: "Drum 1 Gate view: pattern steps on the two upper rows and the six micro steps on pads 17-22"}
		controls: static_controls
	}

	// -- Drum 1 Micro Step view -----------------------------------------
	// TODO: stub. Confirm whether the drums expose this state.
	// The official v3 manual calls the drums' micro-step editor Gate View
	// (pads 17-22), not Micro Step. On note tracks Gate twice opens Micro
	// Step (pads 17-22 micro steps, pad 24 Tie, pads 25-30 the step's notes;
	// pad 31 fixed length, pad 32 gate by holding). Drums can light several
	// micro steps in one step. RC's micro-step rollers live in the Expanded
	// Drum View (rows 1-3), not here.
	drum1_micro_step_view: {
		description: {en: "Micro Step view for Drum 1"}
		controls: static_controls
	}

	// -- Drum 1 Pattern Settings ----------------------------------------
	// TODO: stub. Make exhaustive.
	// User Guide v3, p. 53-56; GUIA 4.1. Pads 1-16 = first/last step (stock);
	// pads 17-24 = sync rate; pad 25 opens the Probability view in mode 2
	// (dynamics and random-mutate); pad 26 = Nudge (tap moves the selected
	// range one step back, Shift + pad 26 one step forward); pad 27 = Fractal
	// order; pad 28 = Deconstructed order; pads 29-32 = stock direction and
	// are exclusive with 27/28. The order is saved with the pattern; Clear on
	// the pattern removes it. Shift + pad 25 = the drum's arpeggiator on/off;
	// Shift + pads 27-32 = arpeggio order; Shift + pads 17-24 = arpeggio
	// resolution. On drums the arpeggiator jumps from sample to sample,
	// following the drum's grid while playing and the project tempo while
	// stopped.
	drum1_pattern_settings: {
		description: {en: "Drum 1 Pattern Settings view: first/last step, sync rate, direction, Nudge, orders and the drum arpeggiator"}
		controls: static_controls
	}

	// -- Drum 1 Probability view ----------------------------------------
	// TODO: stub. Make exhaustive.
	// User Guide v3, p. 70; GUIA 4.3. Open with Pattern Settings twice,
	// Shift + Pattern Settings (mode 1) or pad 25 of Pattern Settings
	// (mode 2). Mode 1: row 3 = step probability; row 4 = frequency (the
	// step plays on the last of every n passes, 1-8). Mode 2: row 3 = random
	// dynamics; row 4 = random-mutate. On drums mode 2 pads 18-20 pick
	// another sample +/-1, pads 21/22 the next row (+8) with low/high chance,
	// pads 23/24 a row up or down (+/-8) with low/high chance.
	// Pads 25-27 (Beta 5.16): no dynamics / dynamics lo (with a roller on
	// micro step 4, or 3 and 6) / dynamics hi; pad 28 dark; pad 32 micro
	// steps for the whole drum. Octave sets the drum's factor. The RC tables
	// differ from the beta: see GUIA "Random-mutate in the RCs" and
	// "Dynamics in the RCs".
	drum1_probability_view: {
		description: {en: "Drum 1 Probability view: probability and frequency in mode 1, dynamics and random-mutate in mode 2"}
		controls: static_controls
	}

	// -- Drum 1 Preset (sample) view -------------------------------------
	// TODO: stub. Make exhaustive.
	// User Guide v3, p. 62; GUIA 5.2. The 64 samples are arranged as two
	// pages of 32; Preset opens at the active sample's page (Drum 1/2 on
	// Page 1, Drum 3/4 on Page 2). J/K swap pages. Tap a sample pad to select
	// it and hear it; Shift + pad selects it silently. Clear + pad twice
	// replaces that sample with Master FX's capture (volatile until Save
	// writes it into the pack if it fits). Duplicate + pad A + pad B swaps
	// samples; Duplicate + A, load another pack, Duplicate + B copies A over
	// B. Preset again or Shift + Preset opens the chromatic/scale view. Hold
	// several sample pads to arpeggiate them when the drum's arpeggiator is
	// on.
	drum1_sample_selection: {
		description: {en: "Drum 1 Preset view: the drum's 64 samples, arranged as two pages of 32"}
		controls: {
			drum_1: {
				light: ["on", colors.orange]
				usage: {
					press: [
						{en: "Return to Drum 1's Note view"},
						"drum1_note_screen_state",
					]
				}
			}
			preset: {
				light: ["on", colors.orange]
				usage: {
					press: [
						{en: "Toggle the drum's chromatic and scale view (Preset again)"},
						"drum1_chromatic_view",
					]
				}
				shift_usage: {
					press: [
						{en: "Open the drum's chromatic and scale view (Shift + Preset)"},
						"drum1_chromatic_view",
					]
				}
			}
		} & static_controls
	}

	// -- Drum 1 chromatic and scale view ---------------------------------
	// TODO: stub. Make exhaustive.
	// GUIA 5.3 and the official v3 manual. Shift + Preset, or Preset again in
	// the Preset view, opens the drum's chromatic and scale view. Three rows
	// of notes in the Scales view's scale and root; the sample plays
	// transposed. K1 = pitch offset in semitones; Shift + K1 = fine tuning in
	// cents. RC: the pads transpose in semitones on top of K1 and, while
	// recording, stay on their own step inside the drum's pitch lane;
	// Clear + K1 to the left (held) deletes both. Beta 5.16: with the extra
	// lane on the chromatic pitch, recorded steps go to that lane. RC4.05:
	// while recording (Record + Play) each pad records a hit with its pitch on
	// its own step (the press's micro step and velocity; an empty step gets
	// probability 7); Shift + Play moves the pitch with its hit.
	// Pads 25-28 repeat the boxes of Drums 4-1. Rows 1-3 are micro-step
	// rollers (Drum 1 = pads 4, 12, 20 and 5, 13, 21); while held the drum
	// plays every step at those micro steps, stopped too; Record writes the
	// hits.
	drum1_chromatic_view: {
		description: {en: "Drum 1 chromatic and scale view: the sample transposed along the project's scale and root"}
		controls: static_controls
	}

	// -- Drum 1 automation view (Beta 5.16) ------------------------------
	// TODO: stub. Make exhaustive.
	// GUIA 5.1. A drum's Velocity view with Shift held, or latched by
	// pressing Velocity twice there (again = off; leaving the view too).
	// Steps with automation light yellow; in state locks ramp steps are dim
	// yellow; marked steps are red; the others keep their colour.
	// Shift + a yellow step puts its values on the knobs and in the sound
	// until Shift is let go (the knobs it moves light yellow).
	// Shift + a step without automation marks it red: when it plays, pitch,
	// decay, distortion, EQ and the extra lane's parameter go back to the
	// project's saved values. Clear + step erases its automation and keeps
	// the hit. In state locks, holding a step previews it and tapping another
	// makes a ramp between them. On drums fixed velocity stays on Shift +
	// Velocity; Velocity twice latches this view.
	drum1_automation_view: {
		description: {en: "Drum 1 automation view: steps with automation, previews, marks and ramps (Beta 5.16)"}
		controls: static_controls
	}

	// -- Drum 2 / 3 / 4 Note views ---------------------------------------
	// TODO: stubs. Same layout and controls as drum1_note_screen_state apart
	// from the colour coding (User Guide v3, p. 60): Drum 2 = yellow,
	// Drum 3 = purple, Drum 4 = aqua. Each drum has its own active sample and
	// sample page; Drum 2's Preset opens on Page 1 and Drum 4's on Page 2.
	// RC stereo pair: holding Drum 1 + Drum 2 (or Drum 3 + Drum 4) pairs
	// them; the right drum's button pulses in the left drum's colour and its
	// pattern stops playing, while its pads and MIDI notes still play it
	// alone on the right.
	// TODO: stub. Make exhaustive; the layout above describes what is known.
	drum2_note_screen_state: {
		description: {en: "Drum 2 Note view: the same layout as Drum 1, in yellow"}
		controls: static_controls
	}
	// TODO: stub. Make exhaustive; the layout above describes what is known.
	drum3_note_screen_state: {
		description: {en: "Drum 3 Note view: the same layout as Drum 1, in purple"}
		controls: static_controls
	}
	// TODO: stub. Make exhaustive; the layout above describes what is known.
	drum4_note_screen_state: {
		description: {en: "Drum 4 Note view: the same layout as Drum 1, in aqua"}
		controls: static_controls
	}

	// -- Synth 1 / 2 Note views ------------------------------------------
	// TODO: stubs. Make exhaustive.
	// User Guide v3, p. 27-28; GUIA 2.1. Rows 1-2 are the 16 pattern steps;
	// rows 3-4 are the synth keyboard. Note is lit in the track's colour
	// (Synth 1 violet, Synth 2 pale green). J/K shift the pitch range by
	// octaves. Pressing the track button again opens the source view;
	// Shift + Synth 1/2 does the same from any view. Two note-track buttons
	// held together make a split keyboard. Shift + a key latches it;
	// Shift + a step writes latched notes into that step. Expanded Note view
	// (Note twice) has the chord screen on Shift + pad 8 and the Jankó
	// layout options. Velocity view, Gate view and Micro Step view are the
	// other step views.
	// TODO: stub. Make exhaustive; the layout above describes what is known.
	synth1_note_screen: {
		description: {en: "Synth 1 Note view: pattern steps on the two upper rows and the synth keyboard on the two lower rows"}
		controls: static_controls
	}
	// TODO: stub. Make exhaustive; the layout above describes what is known.
	synth2_note_screen: {
		description: {en: "Synth 2 Note view: pattern steps on the two upper rows and the synth keyboard on the two lower rows"}
		controls: static_controls
	}

	// -- MIDI 1 / 2 Note views -------------------------------------------
	// TODO: stubs. Make exhaustive.
	// User Guide v3, p. 27-28; GUIA 3.1 / 3.8. Rows 1-2 are the 16 pattern
	// steps; rows 3-4 play MIDI notes. The MIDI track can also host its own
	// synth engine; in sample mode the expanded Note view is the sample
	// picker (pads 17-32 = 16 samples, Octave = pages, pads 1-16 = steps).
	// Shift + MIDI 1/2 opens the Preset view; Clear + MIDI 1/2 resets the
	// own-synth engine; pressing the track button again with its Note view
	// on screen opens the Preset view.
	// TODO: stub. Make exhaustive; the layout above describes what is known.
	midi1_note_screen: {
		description: {en: "MIDI 1 Note view: pattern steps on the two upper rows and the MIDI keyboard on the two lower rows"}
		controls: static_controls
	}
	// TODO: stub. Make exhaustive; the layout above describes what is known.
	midi2_note_screen: {
		description: {en: "MIDI 2 Note view: pattern steps on the two upper rows and the MIDI keyboard on the two lower rows"}
		controls: static_controls
	}

	// -- Global views ----------------------------------------------------
	// TODO: stubs. Each needs its own exhaustive control map.

	// GUIA 2.2. Scales button: root and stock scale; Shift + Scales (or
	// Scales twice) opens the custom-scale editor. The note tracks' pads,
	// quantising and random-mutate use the scale; the root and scale are
	// saved with the project.
	// TODO: stub. Make exhaustive.
	scales_view: {
		description: {en: "Scales view: root and stock scale"}
		controls: static_controls
	}

	// GUIA 2.2. Custom-scale editor: up to 7 notes over the root and a free
	// period. Shift + pad 8 toggles the Jankó layout; Octave moves by a
	// semitone (held, an octave). Saved with the project.
	// TODO: stub. Make exhaustive.
	scales_custom_view: {
		description: {en: "Scales view with the custom-scale editor"}
		controls: static_controls
	}

	// User Guide v3, p. 76-80; GUIA 8. Patterns button. Columns = tracks,
	// rows = patterns; two pages selected with J/K. With chain mode
	// (Shift + Octave in this view), each pattern can play n times and jump
	// to another. Shift + Patterns = View Lock.
	// TODO: stub. Make exhaustive.
	patterns_view: {
		description: {en: "Patterns view: the eight patterns of each track and their chains"}
		controls: static_controls
	}

	// User Guide v3, p. 73-74; GUIA 9. Mixer button. Level with Octave up,
	// pan with Octave down, mutes and scenes. Shift + a track pad mutes or
	// unmutes on the next bar; Shift + pads 9-16 set scene repeats; cue mode
	// puts the mix in mono on the left and the cue on the right. Mixer again
	// opens Master FX.
	// TODO: stub. Make exhaustive.
	mixer_view: {
		description: {en: "Mixer view: levels, pans, mutes and scenes"}
		controls: static_controls
	}

	// User Guide v3, p. 81; GUIA 7. FX button. Reverb and delay sends per
	// track; Duplicate resets the sends and effects; Shift + Octave changes
	// the master filter resonance; Shift + pad 25 turns the master filter
	// off / on while keeping its position (RC4).
	// TODO: stub. Make exhaustive.
	fx_view: {
		description: {en: "FX view: reverb and delay sends for each track"}
		controls: static_controls
	}

	// User Guide v3, p. 82; GUIA 8.1. Shift + FX. Each track's sidechain
	// presets plus knobs for attack, hold, decay and depth; master compressor
	// attack and release; one drum can duck another; Synth 1/2 and MIDI 1/2
	// patterns can be the source. J/K switch the Synth and MIDI sidechain
	// views.
	// TODO: stub. Make exhaustive.
	sidechain_view: {
		description: {en: "Sidechain view: ducking presets and knobs for every track"}
		controls: static_controls
	}

	// User Guide v3, p. 91; GUIA 10. Tempo/Swing button. K1 sets the tempo
	// (bright blue), K2 the swing (orange), K5 the click level; Shift + Tempo
	// taps the tempo.
	// TODO: stub. Make exhaustive.
	tempo_view: {
		description: {en: "Tempo/Swing view: tempo, swing and click level"}
		controls: static_controls
	}

	// User Guide v3, p. 96-100; GUIA 11. Projects button. Load and save
	// projects; Duplicate + pad A selects a source, Duplicate + pad B copies
	// it, and the copy can go to another pack.
	// TODO: stub. Make exhaustive.
	projects_view: {
		description: {en: "Projects view: load, save and copy projects"}
		controls: static_controls
	}

	// GUIA 11. Shift + Projects. Load and delete packs; the internal memory
	// pack is protected from the mod's writes.
	// TODO: stub. Make exhaustive.
	packs_view: {
		description: {en: "Packs view: load and delete packs"}
		controls: static_controls
	}

	// GUIA 6.1. Mixer, then Mixer again. Pads 1-6 = effects, 7 = captured
	// sample, 8 = release all, 9-24 = song pointer, 26-30 = assignable
	// slots, 31 = mechanical gesture, 32 = capture. K1-K4 change with the
	// effect; Clear + knob right resets; settings are saved per project.
	// TODO: stub. Make exhaustive.
	master_fx_view: {
		description: {en: "Master FX view: master effects, song pointer, capture and assignable slots"}
		controls: static_controls
	}
}

// Only the keys of screen_states are valid transition targets.
#ScreenStateID: or([for k, _ in screen_states {k}])
