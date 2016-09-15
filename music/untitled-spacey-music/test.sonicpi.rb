PATH = '/home/euwbah/Documents/Sonic Pi Projects/much-ado-about-sonic-pi/music/untitled-spacey-music/'
def import(localdir)
  run_file PATH + localdir
end

import 'core.sonicpi.rb'
import 'fx.sonicpi.rb'
import 'instruments.sonicpi.rb'

# Some directives for sonic-pi-autocomplete atom plugin

#@ play wail 2 :fm

use_bpm 120
set_control_delta! 0.004
live_loop :drs do
  puts "loop"
  with_random_seed ring(8, 2, 3, 2).tick do
    kick ring(0.9, 0.5, 0.7, 0.3).look
    4.times do |rep|
      snare rand
      sleep 0.25
    end
  end
end
