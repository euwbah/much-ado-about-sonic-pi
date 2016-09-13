PATH = '/home/euwbah/Documents/Sonic Pi Projects/much-ado-about-sonic-pi/music/untitled-spacey-music/'
def import(localdir)
  run_file PATH + localdir
end

import 'core.sonicpi.rb'
import 'instruments.sonicpi.rb'
import 'fx.sonicpi.rb'

# Some directives for sonic-pi-autocomplete atom plugin

#@ play wail 2 :fm

use_bpm 90

ethereal do
    use_synth_defaults note_slide: 0.5, amp: 0.5, amp_slide: 0.5

    septmin7 = wail mult(mult(:f4, 5, 4), 3, 2), attack: 0, sustain: 4.5, release: 0.4, amp: 0
    septmin3 = wail mult(:f4, 5, 4), attack: 4, sustain: 5, release: 1, amp: 0.12


    iAmp(septmin7, 0.5, {2.5 => 0.6, 3.5 => 0.1,})
    iNote(septmin7, 0.5, {
      3 => -1, 3.5 => mult(mult(:f4, 10, 9), 3, 2)
    })

    sleep 5.8

    n = wail mult(:f4, 10, 4), attack: 0.074, sustain: 0.05, release: 0, amp: 0.2, note_slide: 0.04
    sleep 0.08
    c n, note: mult(:f4, 9.1, 4)
    sleep 0.04

    septmin7 = wail mult(:f4, 9, 4), attack: 0.1, sustain: 4, release: 4, amp: 0.3
    iAmp(septmin7, 0.5, {2.5 => 0.6, 3.5 => 0.1})
    iNote(septmin7, 0.5, {
      1 => -1, 1.5 => mult(:g4, 5, 3)
    })

    sleep 1.5

    wail mult(:g4, 3, 2), attack: 0.5, sustain: 8, release: 1, amp: 0.12
    wail mult(:g4, 1, 1), attack: 0.5, sustain: 8, release: 1, amp: 0.12
    wail mult(:e4, 1, 1), attack: 0.5, sustain: 8, release: 1, amp: 0.12

    sleep 6
end
