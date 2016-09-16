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

synths, filter = binaural :f1, sustain: 1, attack: 0, pulse_width: 0.5, centre: 1000

c synths, 
