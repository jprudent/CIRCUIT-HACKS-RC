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

// Reference to official documentation
#OfficialRef: {
	doc!:     #ID
	section?: string
	page?:    int & >=1
	checksum: string
}

#Color: {
    id!: #ID
  	name!: #Text
	hex!:  #Hex  
}

colors: [key=#ID]: #Color & { id: key }

colors: {
	green: {
		name: {en: "green", es: "verde", fr: "vert"}
		hex: "#0ed70e" // TODO find the proper color reference
	}
}
// a pad is the white zone constiting of white pads on the hardware. there are 32
// knobs are located in the upper part 
// buttons are all the other buttons. They can have 2 shapes: square or halved-square
#ControlKind: "pad" | "knob" | "button"

#Line: int
#Column: int
// TODO add check that line is between 1 and 4
// TODO add check that line is between 1 and 8

#Control: {
	id!:  #ID // required; the controls map injects it from the map key
	kind: #ControlKind
	// main function label printed on the device
	onDeviceMainLabel?: #Text
	// label corresponding to Shift mode printed on the device
	onDeviceShiftLabel?: #Text
	// only for the white step pads, line 
	padGridCoordinates?: [int, int],
    // the natural color when the machine is off
    materialColor: #Color
}

controls: [key=#ID]: #Control & {id: key}
controls: {
	master_volume: {kind: "knob", onDeviceMainLabel: {en: "Master Volume"}}
	pad_1_5: {kind: "pad", padGridCoordinates: [1, 5]}
	tempo: {kind: "button", onDeviceMainLabel: {en: "Tempo\nSwing"}, onDeviceShiftLabel: {en: "Tap"}}
	// TODO complete list of controls
}
#Screen: {
	id:    #ID
	title: #Text
}

screens: [key=#ID]: #Screen & {id: key}
screens: {
	drum1Note: {
        title: {en: "Drum 1 note view"}
	}
}

#Action: "press" | "hold" | "release" | "turn_left" | "turn_right"

// an action sequence is a list of actions, for instance:
// [[hold controls.pad_1_1] [press controls.pad_3_2] [release controls.pad_1_1]]

#ActionSequence: [...[#Action, #Control]]
#Effect: #Text | #ScreenState 
#Light: "on" | "blink"
#LightState: [#Light, #Color?]

#ControlState: {
	light?: #LightState
    // an effect could be 
    // - a change on the hardware, for instance for the master_volume knob, {turn_right "increase master volume"}
    // - a transition to another screen
    // - a change in it's own state
    usage: {#Action: [...#Effect]}
}

#ScreenState: {
    description: #Text
    // active controls in that state
    controls: {#Control: #ControlState}
}

// I'm considering that the hardware starts from a blank project

// static controls always have the same effect, whatever the screen state they are in
static_controls: {
    controls.synth1: {light: ["on", colors.dim_white], usage: {press: [synth1_note_screen] }}
    // TODO continue

}
// -- drum1 note screen (from official doc)

drum_step_pad_state_inactive: {
    {light: ["on", colors.dim_blue],
     usage: { [press] [
        {:en "Assign the active sample to pattern step"}
        drum1_step_pad_state_active]]}}}

drum_step_pad_state_active: {
    {light: ["on", colors.light_blue],
     usage: { press [
        {:en "unassign the active sample to pattern step"}
        drum1_step_pad_state_inactive]]}}} 

drum1_note_screen_state: {
    description: {en: "The first programmable drum track"}
    controls: {
        controls.pad_1_1: drum1_step_pad_state_inactive
        controls.drum1: {light: ["on" colors.orange], usage: {}}
        controls.preset {light: ["on" dim.white], usage: {press [drum1_sample_selection]}}        
    } & static_controls
}

drum1_sample_selection: {
    description: {en: "4 rows of samples to select for the current drum track"}
    controls: {
        controls.drum1: {light: ["on" colors.orange], usage: {press [drum1_note_screen_state]}}
        // TODO continue
    } & static_controls
}

synth1_note_screen: {
    description: {en: "The first programmable synth track"}
    controls: {
        //TODO continue
    } & static_controls
}
