ALWAYS read schema.cue

## Validation 

`cue vet file.cue` to check a CUE file
`cue fmt file.cue` to format a CUE file 

## Improve the ontology

- Read the docs in this repository
- Read the official docs in sibling project ~/projects/circuit-tracks-docs

Warn: The circuit-hack overrides some stock behavior. Like the shift key.

When you implement or change a screen, you can stub any other screen_state, leave a TODO note with all infos you have. But the control_state must not be stubbed.

Reuse wording from the docs

## Convention

### Comments

A human comments starts with `// H: blabla` and can be multiline
An agent comment starts with `// G: blipblip ` and can be multine

example 

// H: bla
// bli
// G: blap
// blip

line 1 and 2 is human, line 3 and 4 are agent

an Agent must NEVER rewrite a human comment without consent and explicit confirmation

### Schema

When assigned a task, you must NEVER change the schema unless explicitely told. You
can propose changes, but no change  without consent and explicit confirmation

## Future

When designin the ontology, keep in mind that it could be used to :
- generate documentation
- used as input to a circuit tracks emulator