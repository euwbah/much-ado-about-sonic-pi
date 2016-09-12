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

ethereal( lambda do
            use_synth_defaults note_slide: 0.5, amp: 0.5, amp_slide: 0.5
            n = wail mult(:c4, 10, 4), sustain: 4, attack: 1, release: 2
            sleep 2
            c n, note: mult(:c4, 9, 4)
            sleep 8


            n = wail mult(:c4, 8, 4), sustain: 9, attack: 2, release: 1, amp: 0.4
            iAmp(n, 0.5, {2 => 0.8,
                          3 => 0.3,
                          6 => 1,
                          8 => 0.6,
                          12 => 0.2})
            iNote(n, 0.5, {1.5 => mult(:c4, 8, 4),
                           2 => mult(:c4, 15, 8),
                           11.5 => mult(:c4, 15, 8),
                           12 => mult(:c4, 13, 8)})
            sleep 16

            n = wail mult(:c5, 5, 4), sustain: 5, amp: 0 # e5

            iAmp(n, 0.5, {
              2 => 0.8,
              3 => 0.3,
              5 => 0.1
            })

            iNote(n, 0.5, {
              3.5 => -1,
              4 => mult(:c5, 6, 4)
            })

            sleep 7

            n = wail mult(:c5, 12, 8), attack: 0.02, sustain: 0, release: 0.2, amp: 0.1

            sleep 0.125

            n = wail mult(:c5, 11.5, 8), attack: 0.05, sustain: 4

            iNote(n, 0.25, {
              0.25 => mult(:c5, 11, 8),
              2 => -1,
              3 => mult(:c4, 14, 5),
              10 => -1,
              11 => mult(:c4, 9, 4)
            })

            sleep 14

            sleep 7

            f = wail mult(:f3, 1, 1), attack: 12, sustain: 26, release: 7, amp: 0.5
            sleep 12

            septmin7 = wail mult(mult(:f4, 5, 4), 3, 2), attack: 0, sustain: 7, release: 3, amp: 0
            septmin3 = wail mult(:f4, 5, 4), attack: 4, sustain: 5, release: 1, amp: 0.2
            wail mult(:f4, 3, 2), attack: 4, sustain: 5, release: 1, amp: 0.2
            wail mult(:f4, 1, 1), attack: 4, sustain: 5, release: 1, amp: 0.2


            iAmp(septmin7, 0.5, {2.5 => 0.6, 3.5 => 0.1, 8 => 0.6, 11 => 0.1})
            iNote(septmin7, 0.5, {3 => -1, 3.5 => mult(mult(:f4, 10, 9), 3, 2)})

            sleep 10

            septmin7 = wail mult(mult(:f4, 5, 4), 3, 2), attack: 1.5, sustain: 10, release: 2
            septmin3 = wail mult(:f4, 5, 4), attack: 4, sustain: 6, release: 1, amp: 0.2
            wail mult(:f4, 3, 2), attack: 4, sustain: 6, release: 1, amp: 0.2
            wail mult(:f4, 1, 1), attack: 4, sustain: 6, release: 1, amp: 0.2

            iAmp(septmin7, 0.5, {
                   2 => 0.6,
                   3 => 0.1,
                   5 => 0.6,
                   6 => 0.3,
                   10 => 0.5,
                   13 => 0.1
            })

            iNote(septmin7, 0.5, {
                    3 => -1,
                    4 => mult(mult(:f4, 13, 9), 3, 2),
                    6 => -1,
                    6.5 => mult(mult(:f4, 15, 9), 3, 2),
                    7.5 => -1,
                    8 => mult(mult(:f4, 10, 9), 3, 2)
            })
end)
