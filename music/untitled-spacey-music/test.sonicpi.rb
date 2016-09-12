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
end)
