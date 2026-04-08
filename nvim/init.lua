require("config.pre")
require("config.python")
require("config.lazy")
require("config.commands")
require("config.claude")
require("plenary")
require("config.telescope")
require("config.lsp")
require("config.mason")
require("config.nvim-treesitter")
require("config.origami")
require("config.telekasten")
require("config.lualine")
require('todo-comments')
require('config.mini')
require("config.editing")
require("config.just")
require("config.render-markdown")
require('daily-cycle').setup({
  PracticeKey = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"},
  PracticeScale = {
    values = {
        "Major (Vamp I^7)",
        "Major (Vamp II-7 V7 I^7)",
        "Dorian (Vamp II-7)",
        "Dorian (II-7 V7)",
        "Mixolydian (Vamp V7)",
        "Minor Pentaonic (Root is V, i.e. G MinPent on G7, Vamp II-7 V-7)",
        "Minor Pentaonic (Simple Blues Form, I7 IV7 I7 II7 V7 I7)",
        "Major Pentaonic (Root is V, i.e. G MajPent on G7, Vamp II-7 V-7)",
        "Major Pentaonic (Vamp I^7)",
        "Major Pentaonic (Simple Blues Form, I7 IV7 I7 II7 V7 I7)",
        "b3 Pentaonic (Root is V, i.e. G b3Pent on G7, Vamp II-7 V-7)",
        "b3 Pentaonic (Simple Blues Form, I7 IV7 I7 II7 V7 I7)",
        "Major Bebop (Vamp I^7)",
        "Melodic Minor (Vamp I-^7)",
        "Locrian (Vamp ii-7b5)",
        "Lydian (Vamp I^7#11)",
        "Harmonic Minor (I-^7)",
        "Minor Bebop (II-7 V7)",
        "Altered (Vamp V7Alt I-7)",
        "Altered (Vamp V7Alt I^7)",
        "Altered (Simple Blues Form, I7 IV7 I7 II7 V7 I7)",
        "Phygian Dominant (Vamp V7Alt I-7)",
        "Phygian Dominant (Vamp V7Alt I^7)",
        "Phygian Dominant (Simple Blues Form, I7 IV7 I7 II7 V7 I7)",
        "Diminished (WholeHalf Start on 3rd, Vamp V7Alt I-7)",
        "Diminished (WholeHalf Start on 3rd, Vamp V7Alt I^7)",
        "Diminished (WholeHalf Start on 3rd, Simple Blues Form, I7 IV7 I7 II7 V7 I7)",
        "Dominant Bebop (Vamp V7Alt I-7)",
        "Dominant Bebop (Vamp V7Alt I^7)",
        "Dominant Bebop (Simple Blues Form, I7 IV7 I7 II7 V7 I7)",
        "Lydian Dominant (Vamp V7#11 I-7)",
        "Lydian Dominant (Vamp V7#11 I^7)",
        "Lydian Dominant (Simple Blues Form, I7 IV7 I7 II7 V7 I7)",
    },
    cycle = "custom",
    days = 24
  },
  PianoTwoHandTechEx = {
    values = {
        -- "Major Shearing Block Chords",
        -- "Major Drop Two Block Chords",
        "Minor Shearing Block Chords",
        -- "Minor Drop Two Block Chords",
        -- "Dominant Shearing Block Chords",
        -- "Dominant Drop Two Block Chords",
        -- "Bebop (Barry Harris) Drop Two Block Chords",
    },
    cycle = "custom",
    days = 12
  },
  PianoLHHandTechEx = {
    values = {
        "On/Off Shells,",
        "On/Off 3 Note Rootless",
        "On/Off 4 Note Rootless",
        "On/Off Quartal",
        "Walking Bass",
    },
    cycle = "custom",
    days = 12
  },
  PianoRHHandTechEx = {
    values = {
        "Scale 8n Ascending / Decending",
        "Scale 8t Ascending / Decending",

        "Arpeggio 8n Ascending / Decending",
        "Arpeggio 8t Ascending / Decending",

        "Scale 8n in Groups of 3 (123, 234, 345...)",
        "Scale 8t in Groups of 3 (123, 234, 345...)",

        "Scale 8n in Groups of 4 (1234, 2345, 3456...)",
        "Scale 8t in Groups of 4 (1234, 2345, 3456...)",

        "Scale 8n Alternating (1352, 3564, 57R6...)",
        "Scale 8t Alternating (1352, 3564, 57R6...)",

        "Coltrane Maj 1235 8n (R235, ^Octave, then decend 532R)",
        "Coltrane Maj 1235 8t (R235, ^Octave, then decend 532R)",
        "Coltrane Min 1345 8n (R345, ^Octave, then decend 543R)",
        "Coltrane Min 1345 8t (R345, ^Octave, then decend 543R)",
        "Diatonic Coltrane 8n (C-R235, D-R345, E-R345, F-R235..)",
        "Diatonic Coltrane 8t (C-R235, D-R345, E-R345, F-R235..)",

        "Coltrane.2 Maj 1325 8n (R325, ^Octave, then decend 532R)",
        "Coltrane.2 Maj 1325 8t (R325, ^Octave, then decend 532R)",
        "Coltrane.2 Min 1435 8n (R325, ^Octave, then decend 534R)",
        "Coltrane.2 Min 1435 8t (R325, ^Octave, then decend 534R)",
        "Diatonic.2 Coltrane 8n (C-R325, D-R435, E-R435, F-R325..)",
        "Diatonic.2 Coltrane 8t (C-R325, D-R435, E-R435, F-R325..)",

        "Coltrane.3 Maj 1325 8n (R325, ^Octave, then decend 532R)",
        "Coltrane.3 Maj 1325 8t (R325, ^Octave, then decend 532R)",
        "Coltrane.3 Min 1435 8n (R325, ^Octave, then decend 534R)",
        "Coltrane.3 Min 1435 8t (R325, ^Octave, then decend 534R)",
        "Diatonic.3 Coltrane 8n (C-R325, D-R435, E-R435, F-R325..)",
        "Diatonic.3 Coltrane 8t (C-R325, D-R435, E-R435, F-R325..)",

        "Diatonic Triads 8n (R35, 246, 357, etc) ",
        "Diatonic Triads 8t (R35, 246, 357, etc) ",
        "Diatonic 7th Broken Chords 8n (R357, 357R, 57R3, etc)",
        "Diatonic 7th Broken Chords 8t (R357, 357R, 57R3, etc)",
        "Diatonic 7th Broken Chords 8n + Scale (R3576543, 246R7654, 3579R765, ...)",
        "Diatonic 7th Broken Chords 8t + Scale (R3576543, 246R7654, 3579R765, ...)",

        "Upper Lower neighbour outlining arpeggio 8n",
        "Upper Lower neighbour outlining arpeggio 8t",
    },
    cycle = "custom",
    days = 24
  },
  BassTechEx = {
    values = {
        "Scale 8n Ascending / Decending",
        "Scale 8t Ascending / Decending",

        "Arpeggio 8n Ascending / Decending",
        "Arpeggio 8t Ascending / Decending",

        "Scale 8n in Groups of 3 (123, 234, 345...)",
        "Scale 8t in Groups of 3 (123, 234, 345...)",

        "Scale 8n in Groups of 4 (1234, 2345, 3456...)",
        "Scale 8t in Groups of 4 (1234, 2345, 3456...)",

        "Scale 8n Alternating (1352, 3564, 57R6...)",
        "Scale 8t Alternating (1352, 3564, 57R6...)",

        "Coltrane Maj 1235 8n (R235, ^Octave, then decend 532R)",
        "Coltrane Maj 1235 8t (R235, ^Octave, then decend 532R)",
        "Coltrane Min 1345 8n (R345, ^Octave, then decend 543R)",
        "Coltrane Min 1345 8t (R345, ^Octave, then decend 543R)",
        "Diatonic Coltrane 8n (C-R235, D-R345, E-R345, F-R235..)",
        "Diatonic Coltrane 8t (C-R235, D-R345, E-R345, F-R235..)",

        "Coltrane.2 Maj 1325 8n (R325, ^Octave, then decend 532R)",
        "Coltrane.2 Maj 1325 8t (R325, ^Octave, then decend 532R)",
        "Coltrane.2 Min 1435 8n (R325, ^Octave, then decend 534R)",
        "Coltrane.2 Min 1435 8t (R325, ^Octave, then decend 534R)",
        "Diatonic.2 Coltrane 8n (C-R325, D-R435, E-R435, F-R325..)",
        "Diatonic.2 Coltrane 8t (C-R325, D-R435, E-R435, F-R325..)",

        "Coltrane.3 Maj 1325 8n (R325, ^Octave, then decend 532R)",
        "Coltrane.3 Maj 1325 8t (R325, ^Octave, then decend 532R)",
        "Coltrane.3 Min 1435 8n (R325, ^Octave, then decend 534R)",
        "Coltrane.3 Min 1435 8t (R325, ^Octave, then decend 534R)",
        "Diatonic.3 Coltrane 8n (C-R325, D-R435, E-R435, F-R325..)",
        "Diatonic.3 Coltrane 8t (C-R325, D-R435, E-R435, F-R325..)",

        "Diatonic Triads 8n (R35, 246, 357, etc) ",
        "Diatonic Triads 8t (R35, 246, 357, etc) ",
        "Diatonic 7th Broken Chords 8n (R357, 357R, 57R3, etc)",
        "Diatonic 7th Broken Chords 8t (R357, 357R, 57R3, etc)",
        "Diatonic 7th Broken Chords 8n + Scale (R3576543, 246R7654, 3579R765, ...)",
        "Diatonic 7th Broken Chords 8t + Scale (R3576543, 246R7654, 3579R765, ...)",

        "Upper Lower neighbour outlining arpeggio 8n",
        "Upper Lower neighbour outlining arpeggio 8t",
    },
    cycle = "custom",
    days = 24
  }
})
