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

// effect on the machine or song
// since this ontology only describe UI interactions and not the hardware logic,
// an effect is a free form text
// for instance
// - set the track step sample to hit
// - increase global master volume
// - set the velocity to 50% 
#Effect: #Text

#Light: "on" | "off" | "dim" | "bright" | "blink" | "flash"
#LightState: [#Light, #Color] | [#Light]
#Action: "press" | "hold" | "release" | "turn_right" | "turn_left"
#ActionSeq: [state=#ControlStateID]: #Action

// The actions one control performs for one input layer: the normal layer
// (`usage`), the Shift layer (`shift_usage`) or a modifier-held gesture
// (`clear_usage`, `duplicate_usage`, `record_usage`). Each field lists what
// happens for that physical action.
// It doesn't describe the state transitions (which is inverted by `fromGesture`)
// It only describe the function on the song, not UI interactions
#Function: {
	press?:      #Effect
	hold?:       #Effect
	release?:    #Effect
	turn_left?:  #Effect
	turn_right?: #Effect
}

#ControlState: {
	// h: a human general description of the control function
	// for instance: control the master filter
	// the description should not repeat already available in the control state (light, function, ...)
	description: #Text
	light?:      #LightState
	// The light shown while Shift mode is on, for the control's Shift function.
	shift_light?: #LightState

	// A: from defines how the control got in that state
	// it's an inversion: instead of each state describing which state it can go 
	// we describe how we can get there
	fromGesture?: #ActionSeq

	// An effect can change the hardware, another screen, or this control's state.
	function: #Function
	// The Shift layer of the control: what it does while Shift is held.
	// FIXME shift mode is permanent until disabled, so a better design would be to
	// transition to another screen state when it is pressed. 
	// I'm ok with clear, duplicate and record. consequence = remove shift_light
	shift_function?: #Function
	// Gestures that begin with a modifier held and then use this control.
	// They live on the control being used, not on the modifier button, so a
	// control owns its complete behaviour; the modifier button's own
	// `usage.hold` only gives the general instruction.
	//
	// clear_usage: Clear held, then this control. Examples: Clear + knob to
	// the right resets both layers of that knob; Clear + knob to the left
	// deletes that knob's automation; Clear + step deletes the hit and all
	// its parameters; Clear + a drum's track button resets its eight knobs.
	clear_function?: #Function
	//
	// duplicate_usage: Duplicate held, then this control. Examples:
	// Duplicate + step copies the step's data and waits for a destination;
	// Duplicate + sample pad A then pad B swaps the two samples;
	// Duplicate + Step Page extends the pattern and copies steps 1-16 to
	// steps 17-32.
	duplicate_function?: #Function
	//
	// record_usage: Record held, then this control. Examples: Record + step
	// writes an automation snapshot into the step (Beta 5.16); Record + a
	// drum knob assigns that parameter to the drum's extra lane (Beta 5.16);
	// Record + a sample pad records a live hit with its velocity.
	record_function?: #Function
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
		description: {en: "Master filter control"}
		light: ["on", colors.white]
		function: {
			turn_left: {en: "Lower the master filter frequency"}
			turn_right: {en: "Raise the master filter frequency"}
		}
	}
	master_volume: {
		description: {en: "Master volume control"}
		function: {
			turn_left: {en: "Lower the master volume"}
			turn_right: {en: "Raise the master volume"}
		}
	}
	// Rear-panel soft switch (User Guide v3, p. 18).
	power: {
		description: {en: "Power switch"}
		function: {
			hold: {en: "Long-press for about one second to turn the unit on or off; the LED lights green while the internal battery charges"}
		}
	}
}

control_states: [key=#ID]: #ControlState
control_states: {
	// ── Drum 1 Note view: pattern step pads (pads 1-16) ──────────────────
	// User Guide v3, p. 60-65: dim pale blue = no hit, bright blue = hit,
	// pink = sample flip, red = step held for sample flip.

	// ── Drum 1 Note view: sample pads (pads 17-32) ───────────────────────
	// User Guide v3, p. 60-65: dim orange = not the active sample,
	// bright orange = active sample, red = sample assigned to a held step.

	// ── Drum 1 Note view: macro knobs (K1-K8) ────────────────────────────
	// RC: all eight knobs are active on a drum. The LED is the drum's
	// orange; its brightness follows the setting (bipolar knobs are dark in
	// the middle). Shift gives the second layer. Clear + knob right resets
	// both layers; Clear + knob left deletes that knob's automation.

	// ── Track buttons ────────────────────────────────────────────────────
	// User Guide v3, p. 16-17 and GUIA 0.2 / 5.1.

	// ── Step buttons ─────────────────────────────────────────────────────
	// User Guide v3, p. 16 and 60-70; GUIA 4.2 / 4.3.

	// ── Other top-panel buttons ──────────────────────────────────────────

	// Step Page (1-16/17-32), User Guide v3, p. 75.
	// Patterns and View Lock, User Guide v3, p. 80.

	// Clear and the four metronome states (GUIA 0.2). The normal LED is off;
	// while Shift is held the LED shows the metronome state.
}

// "previous_state" is a reserved transition target used by transient (held)
// states: it restores the control's state as it was before entering the
// transient state, when no assignment happened during the hold.
#ControlStateID: "previous_state" | or([for k, _ in control_states {k}])

screen_states: [key=#ID]: #ScreenState
screen_states: {
	// -- Drum 1 Note view (User Guide v3, p. 60-65) ----------------------
	// Exhaustive: every pad, knob and button is mapped to a full control state.
	// Rows 1-2 are pattern steps 1-16; rows 3-4 are one page of 16 drum
	// samples. The blank project starts with empty steps, on sample page 1
	// with sample 1 active.

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
				description: {en: "Drum 1 track button (returns to Note view)"}
				light: ["on", colors.orange]
				function: {
					press: {en: "Return to Drum 1's Note view"}
				}
			}
			preset: {
				description: {en: "Preset button in sample view"}
				light: ["on", colors.orange]
				function: {
					press: {en: "Toggle the drum's chromatic and scale view (Preset again)"}
				}
				shift_function: {
					press: {en: "Open the drum's chromatic and scale view (Shift + Preset)"}
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
