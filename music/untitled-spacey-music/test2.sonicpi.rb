PATH = '/home/euwbah/Documents/Sonic Pi Projects/much-ado-about-sonic-pi/music/untitled-spacey-music/'
def import(localdir)
  run_file PATH + localdir
end

import 'core.sonicpi.rb'
import 'instruments.sonicpi.rb'
import 'fx.sonicpi.rb'
import 'drummachine.sonicpi.rb'

# Some directives for sonic-pi-autocomplete atom plugin

#@ play wail 2 :fm

use_bpm 90

stereoize 0.001, 0.9 do
  chime :f1, 1, 10
end
