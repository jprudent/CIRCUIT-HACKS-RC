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

// ── screens and states ─────────────────────────────────────────────────
#Screen: {
	id:    #ID
	title: #Text
}

screens: [key=#ID]: #Screen & {id: key}

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

control_states: [key=#ID]: #ControlState

// "previous_state" is a reserved transition target used by transient (held)
// states: it restores the control's state as it was before entering the
// transient state, when no assignment happened during the hold.
#ControlStateID: "previous_state" | or([for k, _ in control_states {k}])

screen_states: [key=#ID]: #ScreenState

// Only the keys of screen_states are valid transition targets.
#ScreenStateID: or([for k, _ in screen_states {k}])
