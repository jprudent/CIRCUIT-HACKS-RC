package ui

control_states: [key=#ID]: #ControlState
control_states: {

	drum_step_pad_state_no_hit: {
		description: {en: "Pattern step with no drum hit"}
		fromGesture: {
			drum_step_pad_state_active:  "press"
			drum_step_pad_state_flipped: "press"
		}
		light: ["on", colors.dim_blue]
		function: {
			press: {en: "Assign the active sample to the pattern step; the step lights bright blue"}
			hold: {en: "Hold the step to choose the sample it triggers; the step turns red and the sample pad it uses also turns red"}
		}
		duplicate_function: {
			press: {en: "Copy this step's data; then press another step to paste it"}
		}
		record_function: {
			press: {en: "With Record held, write a snapshot of pitch, decay, distortion and EQ into this step (Beta 5.16); the step lights yellow while it is held and still has no hit"}
		}
	}

	drum_step_pad_state_active: {
		description: {en: "Pattern step with a drum hit"}
		fromGesture: {
			drum_step_pad_state_no_hit: "press"
		}
		light: ["on", colors.bright_blue]
		function: {
			press: {en: "Delete the drum hit from the pattern step; the step goes back to dim blue"}
			hold: {en: "Hold the step to choose another sample for it; the step and the sample it uses turn red"}
		}
		clear_function: {
			press: {en: "Delete the hit and all its parameters: velocity, micro steps, probability and sample flip"}
		}
		duplicate_function: {
			press: {en: "Copy this step's data; then press another step to paste it"}
		}
		record_function: {
			press: {en: "With Record held, write a snapshot of pitch, decay, distortion and EQ into this step (Beta 5.16); the step lights yellow while it is held"}
		}
	}

	drum_step_pad_state_flipped: {
		description: {en: "Pattern step with a sample flip"}
		fromGesture: {
			drum_step_pad_state_held_assigned: "release"
			drum_step_pad_state_held:          "release"
		}
		light: ["on", colors.pink]
		function: {
			press: {en: "Delete the drum hit and its sample flip from the pattern step; the step goes back to dim blue"}
			hold: {en: "Hold the step to see and change the sample it triggers; the step turns red and that sample's pad also turns red"}
		}
		clear_function: {
			press: {en: "Delete the hit and all its parameters: velocity, micro steps, probability and sample flip"}
		}
		duplicate_function: {
			press: {en: "Copy this step's data; then press another step to paste it"}
		}
		record_function: {
			press: {en: "With Record held, write a snapshot of pitch, decay, distortion and EQ into this step (Beta 5.16); the step lights yellow while it is held"}
		}
	}

	drum_step_pad_state_held: {
		description: {en: "Pattern step being held to choose a sample"}
		fromGesture: {
			drum_step_pad_state_no_hit:  "hold"
			drum_step_pad_state_active:  "hold"
			drum_step_pad_state_flipped: "hold"
		}
		light: ["on", colors.red]
		function: {
			hold: {en: "While the step is held, press a sample pad to assign that sample to it; the step becomes pink if the sample is not the active one (flip)"}
			release: {en: "Let go to return the step to its normal colour: bright blue with the active sample, pink with a flipped sample"}
		}
	}

	drum_step_pad_state_held_assigned: {
		description: {en: "Pattern step held with a sample assigned (triggered by pressing a sample pad during the hold)"}
		light: ["on", colors.red]
		function: {
			hold: {en: "A sample is now assigned to the held step; keep holding to pick another, or let go to commit the flip"}
			release: {en: "Let go: the step becomes pink with the assigned (flipped) sample"}
		}
	}

	drum_sample_pad_state_inactive: {
		description: {en: "Drum sample pad (not the active sample)"}
		light: ["dim", colors.orange]
		function: {
			press: {en: "Audition the sample and make it the active sample; while a pattern step is held, assign this sample to that step as its sample flip (the held step moves to drum_step_pad_state_held_assigned)"}
			hold: {en: "Play the sample without changing the active sample"}
		}
		record_function: {
			press: {en: "With Record and Play, record a hit with this sample at the current step; with Rec Quantise off it lands on the nearest micro step, and its velocity is the pad's strike"}
		}
	}

	drum_sample_pad_state_active: {
		description: {en: "Drum sample pad (the active sample)"}
		fromGesture: {
			drum_sample_pad_state_inactive: "press"
		}
		light: ["on", colors.orange]
		function: {
			press: {en: "Audition the active sample; while a pattern step is held, assign this sample to that step"}
			hold: {en: "Play the sample; the active sample does not change"}
		}
		record_function: {
			press: {en: "With Record and Play, record a hit with this sample at the current step; with Rec Quantise off it lands on the nearest micro step, and its velocity is the pad's strike"}
		}
	}

	drum_sample_pad_state_flip_target: {
		description: {en: "Sample assigned to the held step"}
		light: ["on", colors.red]
		function: {
			press: {en: "The sample assigned to the held step; press another sample pad to choose a different sample for it"}
			release: {en: "When the step is let go, the pad returns to bright orange if it is the active sample or dim orange otherwise"}
		}
	}

	drum_knob_k1_state: {
		description: {en: "Drum macro knob 1"}
		light: ["on", colors.orange]
		function: {
			turn_left: {en: "Lower the pitch (the stock pitch control, continuous as on the original); chromatic-view pads transpose on top"}
			turn_right: {en: "Raise the pitch"}
		}
		shift_function: {
			turn_left: {en: "Lower the pitch envelope amount"}
			turn_right: {en: "Raise the pitch envelope amount"}
		}
		clear_function: {
			turn_right: {en: "Put pitch and pitch envelope back to their defaults; the LED shows lavender"}
			turn_left: {en: "Delete the pitch automation in the playing pattern; the LED shows red"}
		}
		record_function: {
			turn_left: {en: "No extra-lane assignment for K1: it is the pitch lane; the extra lane's factory setting is the chromatic pitch"}
			turn_right: {en: "No extra-lane assignment for K1: it is the pitch lane; the extra lane's factory setting is the chromatic pitch"}
		}
	}

	drum_knob_k2_state: {
		description: {en: "Drum macro knob 2"}
		light: ["on", colors.orange]
		function: {
			turn_left: {en: "Lower the ring-mod frequency"}
			turn_right: {en: "Raise the ring-mod frequency"}
		}
		shift_function: {
			turn_left: {en: "Lower the ring-mod amount"}
			turn_right: {en: "Raise the ring-mod amount"}
		}
		clear_function: {
			turn_right: {en: "Put ring-mod frequency and amount back to their defaults; the LED shows lavender"}
			turn_left: {en: "Delete the ring-mod frequency automation in the playing pattern; the LED shows red"}
		}
		record_function: {
			turn_left: {en: "Assign ring-mod frequency to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}
			turn_right: {en: "Assign ring-mod frequency to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}
		}
	}

	drum_knob_k3_state: {
		description: {en: "Drum macro knob 3"}
		light: ["on", colors.orange]
		function: {
			turn_left: {en: "Left of centre: shorten the decay (the stock decay control)"}
			turn_right: {en: "Past the decay's maximum: add attack (fade-in, up to 1 s); the LED is white"}
		}
		shift_function: {
			turn_left: {en: "Left of centre: move the sample start into the sample (up to 120/128 of the whole sample)"}
			turn_right: {en: "Right of centre: cut the sample from the end (up to 120/128); the LED is white"}
		}
		clear_function: {
			turn_right: {en: "Put attack, sample start and cut back to 0; the LED shows lavender"}
			turn_left: {en: "Delete the decay automation in the playing pattern; the LED shows red"}
		}
		record_function: {
			turn_left: {en: "No extra-lane assignment for K3; its attack, start and cut have no lane (state locks can store them in Beta 5.16)"}
			turn_right: {en: "No extra-lane assignment for K3; its attack, start and cut have no lane (state locks can store them in Beta 5.16)"}
		}
	}

	drum_knob_k4_state: {
		description: {en: "Drum macro knob 4"}
		light: ["on", colors.orange]
		function: {
			turn_left: {en: "Lower the filter-envelope amount"}
			turn_right: {en: "Raise the filter-envelope amount"}
		}
		shift_function: {
			turn_left: {en: "Choose the previous envelope shape"}
			turn_right: {en: "Choose the next envelope shape"}
		}
		clear_function: {
			turn_right: {en: "Put the filter envelope and its shape back to their defaults; the LED shows lavender"}
			turn_left: {en: "Delete the filter-envelope automation in the playing pattern; the LED shows red"}
		}
		record_function: {
			turn_left: {en: "Assign the filter envelope to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}
			turn_right: {en: "Assign the filter envelope to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}
		}
	}

	drum_knob_k5_state: {
		description: {en: "Drum macro knob 5"}
		light: ["on", colors.orange]
		function: {
			turn_left: {en: "Move the filter / EQ down (by default the stock tilt EQ)"}
			turn_right: {en: "Move the filter / EQ up"}
		}
		shift_function: {
			turn_left: {en: "Choose the previous filter mode: stock tilt EQ, band-pass, notch, comb or DJ"}
			turn_right: {en: "Choose the next filter mode: stock tilt EQ, band-pass, notch, comb or DJ"}
		}
		clear_function: {
			turn_right: {en: "Put the filter / EQ and the filter mode back to their defaults; the LED shows lavender"}
			turn_left: {en: "Delete the filter-frequency automation in the playing pattern; the LED shows red"}
		}
		record_function: {
			turn_left: {en: "No extra-lane assignment for K5; the filter mode is a new knob with no lane (state locks can store it in Beta 5.16)"}
			turn_right: {en: "No extra-lane assignment for K5; the filter mode is a new knob with no lane (state locks can store it in Beta 5.16)"}
		}
	}

	drum_knob_k6_state: {
		description: {en: "Drum macro knob 6"}
		light: ["on", colors.orange]
		function: {
			turn_left: {en: "Lower the resonance"}
			turn_right: {en: "Raise the resonance"}
		}
		// No Shift function on the drums.
		clear_function: {
			turn_right: {en: "Put the resonance back to its default; the LED shows lavender"}
			turn_left: {en: "Delete the resonance automation in the playing pattern; the LED shows red"}
		}
		record_function: {
			turn_left: {en: "Assign resonance to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}
			turn_right: {en: "Assign resonance to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}
		}
	}

	drum_knob_k7_state: {
		description: {en: "Drum macro knob 7"}
		light: ["on", colors.orange]
		function: {
			turn_left: {en: "Left of centre: start scan / vibrato amount; each hit starts where the LFO is, from the Shift + K3 start up to a 64th of the sample further for every step of the knob"}
			turn_right: {en: "Right of centre: tremolo depth"}
		}
		shift_function: {
			turn_left: {en: "Move the LFO speed towards the synced rates (bipolar: left is synced to the tempo, from 1/16T out to 8 bars)"}
			turn_right: {en: "Move the LFO speed towards the free rates (right is free and faster further right; 0.2 at the centre)"}
		}
		clear_function: {
			turn_right: {en: "Put the LFO amount and speed back to their defaults; the LED shows lavender"}
			turn_left: {en: "Delete the LFO automation in the playing pattern; the LED shows red"}
		}
		record_function: {
			turn_left: {en: "Assign the LFO amount to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}
			turn_right: {en: "Assign the LFO amount to the drum's extra lane (Beta 5.16); the knob lights white while Record is held"}
		}
	}

	drum_knob_k8_state: {
		description: {en: "Drum macro knob 8"}
		light: ["on", colors.orange]
		function: {
			turn_left: {en: "Left of 0: add bitcrush; otherwise lower the distortion"}
			turn_right: {en: "Add distortion"}
		}
		shift_function: {
			turn_left: {en: "Choose the previous distortion type: stock, soft, hard or fold"}
			turn_right: {en: "Choose the next distortion type: stock, soft, hard or fold"}
		}
		clear_function: {
			turn_right: {en: "Put distortion and its type back to their defaults and remove the bitcrush; the LED shows lavender"}
			turn_left: {en: "Delete the distortion automation in the playing pattern; the LED shows red"}
		}
		record_function: {
			turn_left: {en: "No extra-lane assignment for K8; distortion is in its own lane and the distortion type has no lane (state locks can store it in Beta 5.16)"}
			turn_right: {en: "No extra-lane assignment for K8; distortion is in its own lane and the distortion type has no lane (state locks can store it in Beta 5.16)"}
		}
	}

	drum_1_track_button_state: {
		description: {en: "Drum 1 track selector"}
		light: ["on", colors.orange]
		function: {
			press: {en: "Keep Drum 1 selected; its Note view stays on screen"}
			hold: {en: "Hold Drum 1 and press Drum 2 (or hold Drum 3 and press Drum 4) to make a stereo pair; the same gesture undoes it; not with Shift, Clear or Duplicate held"}
		}
		clear_function: {
			press: {en: "Reset Drum 1's eight knobs, both layers, and delete their automation in the playing pattern"}
		}
	}

	drum_2_track_button_state: {
		description: {en: "Drum 2 track selector"}
		light: ["dim", colors.yellow]
		function: {
			press: {en: "Open Drum 2's Note view; while Drum 1 is held, pair Drum 2 with it as a stereo pair"}
			hold: {en: "Hold Drum 2 and press Drum 1 to pair them as a stereo pair; the same gesture undoes it"}
		}
		clear_function: {
			press: {en: "Reset Drum 2's eight knobs, both layers, and delete their automation in the playing pattern"}
		}
	}

	drum_3_track_button_state: {
		description: {en: "Drum 3 track selector"}
		light: ["dim", colors.purple]
		function: {
			press: {en: "Open Drum 3's Note view; while Drum 4 is held, pair Drum 3 with it as a stereo pair"}
			hold: {en: "Hold Drum 3 and press Drum 4 to pair them as a stereo pair; the same gesture undoes it"}
		}
		clear_function: {
			press: {en: "Reset Drum 3's eight knobs, both layers, and delete their automation in the playing pattern"}
		}
	}

	drum_4_track_button_state: {
		description: {en: "Drum 4 track selector"}
		light: ["dim", colors.aqua]
		function: {
			press: {en: "Open Drum 4's Note view; while Drum 3 is held, pair Drum 4 with it as a stereo pair"}
			hold: {en: "Hold Drum 4 and press Drum 3 to pair them as a stereo pair; the same gesture undoes it"}
		}
		clear_function: {
			press: {en: "Reset Drum 4's eight knobs, both layers, and delete their automation in the playing pattern"}
		}
	}

	synth_1_track_button_state: {
		description: {en: "Synth 1 track selector"}
		light: ["dim", colors.violet]
		function: {
			press: {en: "Open Synth 1's Note view"}
		}
		clear_function: {
			press: {en: "Put Synth 1's eight macros back to the loaded patch's values"}
		}
		shift_function: {
			press: {en: "Open Synth 1's source view (Shift + Synth 1)"}
		}
	}

	synth_2_track_button_state: {
		description: {en: "Synth 2 track selector"}
		light: ["dim", colors.pale_green]
		function: {
			press: {en: "Open Synth 2's Note view"}
		}
		clear_function: {
			press: {en: "Put Synth 2's eight macros back to the loaded patch's values"}
		}
		shift_function: {
			press: {en: "Open Synth 2's source view (Shift + Synth 2)"}
		}
	}

	midi_1_track_button_state: {
		description: {en: "MIDI 1 track selector"}
		light: ["dim", colors.blue]
		function: {
			press: {en: "Open MIDI 1's Note view"}
		}
		clear_function: {
			press: {en: "Reset MIDI 1's own-synth engine to its defaults"}
		}
		shift_function: {
			press: {en: "Open MIDI 1's Preset view (Shift + MIDI 1)"}
		}
	}

	midi_2_track_button_state: {
		description: {en: "MIDI 2 track selector"}
		light: ["dim", colors.pink]
		function: {
			press: {en: "Open MIDI 2's Note view"}
		}
		clear_function: {
			press: {en: "Reset MIDI 2's own-synth engine to its defaults"}
		}
		shift_function: {
			press: {en: "Open MIDI 2's Preset view (Shift + MIDI 2)"}
		}
	}

	note_button_state: {
		description: {en: "Note view button"}
		light: ["on", colors.orange]
		shift_light: ["on", colors.yellow]
		function: {
			press: {en: "Open the Expanded Drum View (Note twice)"}
		}
		shift_function: {
			press: {en: "Open the Expanded Drum View (Shift + Note)"}
		}
	}

	velocity_button_state_variable: {
		description: {en: "Velocity mode: variable"}
		fromGesture: {
			velocity_button_state_fixed: "press"
		}
		light: ["off"]
		shift_light: ["on", colors.red]
		function: {
			press: {en: "Open the Drum 1 Velocity view"}
		}
		shift_function: {
			press: {en: "Switch fixed velocity on; with Shift held the button turns green"}
		}
	}

	velocity_button_state_fixed: {
		description: {en: "Velocity mode: fixed"}
		fromGesture: {
			velocity_button_state_variable: "press"
		}
		light: ["off"]
		shift_light: ["on", colors.green]
		function: {
			press: {en: "Open the Drum 1 Velocity view"}
		}
		shift_function: {
			press: {en: "Switch fixed velocity off; with Shift held the button turns red"}
		}
	}

	gate_button_state: {
		description: {en: "Gate view button"}
		light: ["off"]
		shift_light: ["on", colors.yellow]
		function: {
			press: {en: "Open the Drum 1 Gate view, where pads 17-22 set the micro steps"}
		}
		shift_function: {
			press: {en: "Open the Micro Step view (Shift + Gate)"}
		}
	}

	pattern_settings_button_state: {
		description: {en: "Pattern settings button"}
		light: ["off"]
		shift_light: ["on", colors.yellow]
		function: {
			press: {en: "Open Drum 1's Pattern Settings view"}
		}
		shift_function: {
			press: {en: "Open the Probability view (Shift + Pattern Settings)"}
		}
	}

	scales_button_state: {
		description: {en: "Scales view button"}
		light: ["off"]
		shift_light: ["on", colors.yellow]
		function: {
			press: {en: "Open the Scales view"}
		}
		shift_function: {
			press: {en: "Open the Scales view with the custom-scale editor"}
		}
	}

	step_page_button_state_16: {
		description: {en: "Step page: 16 steps"}
		fromGesture: {
			step_page_button_state_32_page1: "press"
		}
		light: ["on", colors.dim_blue]
		function: {
			press: {en: "Extend the pattern to 32 steps; Page 1 is shown and the button turns bright blue"}
		}
		clear_function: {
			press: {en: "Set the pattern back to 16 steps; steps 17-32 are kept but do not play"}
		}
		duplicate_function: {
			press: {en: "Extend the pattern to 32 steps and copy steps 1-16 to steps 17-32, including automation"}
		}
	}

	step_page_button_state_32_page1: {
		description: {en: "Step page: 32 steps, page 1"}
		fromGesture: {
			step_page_button_state_16:       "press"
			step_page_button_state_32_page1: "press"
			step_page_button_state_32_page2: "press"
		}
		light: ["on", colors.bright_blue]
		function: {
			press: {en: "Show Page 2, steps 17-32; the button turns orange"}
		}
		clear_function: {
			press: {en: "Set the pattern back to 16 steps; steps 17-32 are kept"}
		}
		duplicate_function: {
			press: {en: "Copy steps 1-16 to steps 17-32, overwriting Page 2"}
		}
	}

	step_page_button_state_32_page2: {
		description: {en: "Step page: 32 steps, page 2"}
		fromGesture: {
			step_page_button_state_32_page1: "press"
		}
		light: ["on", colors.orange]
		function: {
			press: {en: "Show Page 1, steps 1-16; the button turns bright blue"}
		}
		clear_function: {
			press: {en: "Set the pattern back to 16 steps; steps 17-32 are kept"}
		}
		duplicate_function: {
			press: {en: "Copy steps 1-16 to steps 17-32, overwriting Page 2"}
		}
	}

	patterns_button_state_view_lock_off: {
		description: {en: "Patterns: View Lock off"}
		fromGesture: {
			patterns_button_state_view_lock_on: "press"
		}
		light: ["off"]
		shift_light: ["on", colors.red]
		function: {
			press: {en: "Open the Patterns view"}
		}
		shift_function: {
			press: {en: "Turn View Lock on; with Shift held the button turns green when it is active"}
		}
	}

	patterns_button_state_view_lock_on: {
		description: {en: "Patterns: View Lock on"}
		fromGesture: {
			patterns_button_state_view_lock_off: "press"
		}
		light: ["off"]
		shift_light: ["on", colors.green]
		function: {
			press: {en: "Open the Patterns view"}
		}
		shift_function: {
			press: {en: "Turn View Lock off; with Shift held the button turns red when it is inactive"}
		}
	}

	mixer_button_state: {
		description: {en: "Mixer view button"}
		light: ["off"]
		function: {
			press: {en: "Open the Mixer view; press Mixer again there to open Master FX"}
		}
	}

	fx_button_state: {
		description: {en: "FX view button"}
		light: ["off"]
		shift_light: ["on", colors.yellow]
		function: {
			press: {en: "Open the FX view"}
		}
		shift_function: {
			press: {en: "Open the Sidechain view (Shift + FX)"}
		}
	}

	preset_button_state: {
		description: {en: "Preset view button"}
		light: ["off"]
		shift_light: ["on", colors.yellow]
		function: {
			press: {en: "Open Drum 1's Preset (sample) view"}
		}
		shift_function: {
			press: {en: "Open the drum's chromatic and scale view (Shift + Preset)"}
		}
	}

	record_button_state_off: {
		description: {en: "Record mode: off"}
		fromGesture: {
			record_button_state_on: "press"
		}
		light: ["off"]
		function: {
			press: {en: "Enter Record Mode; the button lights bright red and the playback cursor turns red"}
			hold: {en: "Momentary Record: record only while the button is held"}
		}
		shift_function: {
			press: {en: "Toggle Record Quantise; with Shift held the button is bright green when quantise is enabled and dim red when it is off"}
		}
	}

	record_button_state_on: {
		description: {en: "Record mode: on"}
		fromGesture: {
			record_button_state_off: "press"
		}
		light: ["on", colors.red]
		function: {
			press: {en: "Leave Record Mode; the button goes dark and the playback cursor returns to white"}
			hold: {en: "Momentary Record: keep recording while held; releasing returns to the previous mode"}
		}
		shift_function: {
			press: {en: "Toggle Record Quantise; with Shift held the button is bright green when quantise is enabled and dim red when it is off"}
		}
	}

	play_button_state_off: {
		description: {en: "Playback: stopped"}
		fromGesture: {
			play_button_state_on: "press"
		}
		light: ["off"]
		shift_light: ["on", colors.yellow]
		function: {
			press: {en: "Start playback; the button lights bright green and the playback cursor is white"}
			hold: {en: "With Record armed and the count-in on, start one bar of count-in; Record blinks red"}
		}
		shift_function: {
			press: {en: "Quantize the selected track's pattern; with Shift held the button is yellow and it turns green after quantizing"}
		}
	}

	play_button_state_on: {
		description: {en: "Playback: playing"}
		fromGesture: {
			play_button_state_off: "press"
		}
		light: ["on", colors.green]
		shift_light: ["on", colors.yellow]
		function: {
			press: {en: "Stop playback; the button goes dark"}
		}
		shift_function: {
			press: {en: "Quantize the selected track's pattern; with Shift held the button is yellow and it turns green after quantizing"}
		}
	}

	tempo_button_state: {
		description: {en: "Tempo view button"}
		light: ["off"]
		shift_light: ["on", colors.yellow]
		function: {
			press: {en: "Open the Tempo/Swing view; K1 sets the tempo, K2 the swing and K5 the click level"}
		}
		shift_function: {
			press: {en: "Tap tempo: tap the button in time with the track"}
		}
	}

	clear_button_state_no_metronome: {
		description: {en: "Clear button: no metronome"}
		fromGesture: {
			clear_button_state_both: "press"
		}
		light: ["off"]
		shift_light: ["on", colors.red]
		function: {
			hold: {en: "Hold Clear and use another control for its Clear gesture: reset a knob, delete a step or delete its automation"}
		}
		shift_function: {
			press: {en: "Next metronome state: metronome on; with Shift held the button turns green"}
		}
	}

	clear_button_state_metronome: {
		description: {en: "Clear button: metronome on"}
		fromGesture: {
			clear_button_state_no_metronome: "press"
		}
		light: ["off"]
		shift_light: ["on", colors.green]
		function: {
			hold: {en: "Hold Clear and use another control for its Clear gesture: reset a knob, delete a step or delete its automation"}
		}
		shift_function: {
			press: {en: "Next metronome state: count-in only; with Shift held the button turns magenta"}
		}
	}

	clear_button_state_count_in: {
		description: {en: "Clear button: count-in only"}
		fromGesture: {
			clear_button_state_metronome: "press"
		}
		light: ["off"]
		shift_light: ["on", colors.magenta]
		function: {
			hold: {en: "Hold Clear and use another control for its Clear gesture: reset a knob, delete a step or delete its automation"}
		}
		shift_function: {
			press: {en: "Next metronome state: count-in and metronome; with Shift held the button turns teal"}
		}
	}

	clear_button_state_both: {
		description: {en: "Clear button: metronome and count-in"}
		fromGesture: {
			clear_button_state_count_in: "press"
		}
		light: ["off"]
		shift_light: ["on", colors.teal]
		function: {
			hold: {en: "Hold Clear and use another control for its Clear gesture: reset a knob, delete a step or delete its automation"}
		}
		shift_function: {
			press: {en: "Back to no metronome; with Shift held the button turns red"}
		}
	}

	duplicate_button_state: {
		description: {en: "Duplicate button"}
		light: ["off"]
		shift_light: ["on", colors.yellow]
		function: {
			hold: {en: "Hold Duplicate and press a step, pad or track button for its Duplicate gesture; for example, Duplicate + step copies the step's data"}
		}
		shift_function: {
			press: {en: "Mutate the selected pattern: shuffle its notes or hits to different steps, with all their step parameters"}
		}
	}

	save_button_state: {
		description: {en: "Save button"}
		light: ["off"]
		function: {
			press: {en: "Save the project; in the S builds and the internal-memory pack nothing is written to the card and the LED turns red"}
		}
	}

	projects_button_state: {
		description: {en: "Projects view button"}
		light: ["off"]
		shift_light: ["on", colors.yellow]
		function: {
			press: {en: "Open the Projects view"}
		}
		shift_function: {
			press: {en: "Open the Packs view (Shift + Projects)"}
		}
	}

	shift_button_state: {
		description: {en: "Shift mode button"}
		light: ["off"]
		shift_light: ["on", colors.green]
		function: {
			hold: {en: "Hold Shift for the second functions; while it is held the available shortcuts light yellow"}
			press: {en: "With Sticky Shift enabled, a press keeps Shift held until it is pressed again; the button is bright green"}
		}
	}

	j_button_state: {
		description: {en: "Previous sample page button"}
		light: ["dim", colors.white]
		function: {
			press: {en: "Show the previous page of 16 drum samples; the J and K LEDs brighten to show which page is on screen"}
		}
	}

	k_button_state: {
		description: {en: "Next sample page button"}
		light: ["dim", colors.white]
		function: {
			press: {en: "Show the next page of 16 drum samples; the J and K LEDs brighten to show which page is on screen"}
		}
	}
}

screen_states: [key=#ID]: #ScreenState
screen_states: {

	drum1_note_screen_state: {
		description: {en: "Drum 1 Note view: the two upper rows are pattern steps 1-16; the two lower rows are one page of 16 drum samples. The blank project starts with empty steps, sample page 1 shown and sample 1 active."}
		controls: {
			// Pattern steps 1-16.
			pad_1_1: control_states.drum_step_pad_state_no_hit
			pad_1_2: control_states.drum_step_pad_state_no_hit
			pad_1_3: control_states.drum_step_pad_state_no_hit
			pad_1_4: control_states.drum_step_pad_state_no_hit
			pad_1_5: control_states.drum_step_pad_state_no_hit
			pad_1_6: control_states.drum_step_pad_state_no_hit
			pad_1_7: control_states.drum_step_pad_state_no_hit
			pad_1_8: control_states.drum_step_pad_state_no_hit
			pad_2_1: control_states.drum_step_pad_state_no_hit
			pad_2_2: control_states.drum_step_pad_state_no_hit
			pad_2_3: control_states.drum_step_pad_state_no_hit
			pad_2_4: control_states.drum_step_pad_state_no_hit
			pad_2_5: control_states.drum_step_pad_state_no_hit
			pad_2_6: control_states.drum_step_pad_state_no_hit
			pad_2_7: control_states.drum_step_pad_state_no_hit
			pad_2_8: control_states.drum_step_pad_state_no_hit

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
}
