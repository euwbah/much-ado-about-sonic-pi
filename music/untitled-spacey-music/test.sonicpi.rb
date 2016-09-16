PATH = '/home/euwbah/Documents/Sonic Pi Projects/much-ado-about-sonic-pi/music/untitled-spacey-music/'
def import(localdir)
  run_file PATH + localdir
end

import 'core.sonicpi.rb'
import 'fx.sonicpi.rb'
import 'instruments.sonicpi.rb'
import 'drummachine.sonicpi.rb'

# Some directives for sonic-pi-autocomplete atom plugin

#@ play wail 2 :fm

use_bpm 144
set_control_delta! 0.004

openHatInstance = nil
live_loop :drs do
  with_random_seed ring(4, 4, 4, 7).tick do
    kick4
    drum_fx_chain do
      use_synth :cnoise
      n = play :c4, cutoff: 30, cutoff_slide: 0.5, res: 0.86, sustain: 0, release: 0, attack: 0.5
      control n, cutoff: 103
      sleep 1
    end
  end
end
