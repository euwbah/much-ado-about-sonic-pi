PATH = '/home/euwbah/Documents/Sonic Pi Projects/much-ado-about-sonic-pi/music/untitled-spacey-music/'
def import(localdir)
  run_file PATH + localdir
end

import 'core.sonicpi.rb'
import 'fx.sonicpi.rb'
import 'instruments.sonicpi.rb'

# Some directives for sonic-pi-autocomplete atom plugin

#@ play wail 2 :fm

use_bpm 144
set_control_delta! 0.004

instance = binaural :f2, sustain: 1, attack: 0, freq: 300, pulse_width_slide: 4, pulse_width_slide_shape: 1, pulse_width: 0.5
sleep 0.5
ct 4, instance[0], pulse_width: 0.99
s
