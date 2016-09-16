PATH = '/home/euwbah/Documents/Sonic Pi Projects/much-ado-about-sonic-pi/music/untitled-spacey-music/'
def import(localdir)
  run_file PATH + localdir
end

import 'core.sonicpi.rb'
import 'fx.sonicpi.rb'
import 'instruments.sonicpi.rb'

# Some directives for sonic-pi-autocomplete atom plugin

#@ play wail 2 :fm

use_bpm 90

# XXX: Skips to mvt2 immediately. Delete these lines when rendering
# import 'mvt2.sonicpi.rb'
# stop

ethereal do
  use_synth_defaults note_slide: 0.5, amp: 0.5, amp_slide: 0.5, divisor_slide: 1
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

  i(n, :divisor, 1, {
    2 => :same,
    10 => 1.014,
    12 => 1.001
  })
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

  sleep 8

  n = wail mult(:c5, 12, 8), attack: 0.02, sustain: 0, release: 0.2, amp: 0.1, note_slide: 0.06
  sleep 0.06
  c n, note: mult(:c5, 11.5, 8)
  sleep 0.06

  n = wail mult(:c5, 11.2, 8), attack: 0.05, sustain: 9, release: 2, note_slide: 0.25

  iNote(n, 0.25, {
    0.25 => mult(:c5, 11, 8),
    2 => -1,
    3 => mult(:c4, 14, 5),
    7 => -1,
    7.25 => mult(:c4, 56, 15)
  })

  iAmp(n, 0.25, {
    1.25 => 0.1,
    6.75 => 1,
    7 => 0.2
  })

  sleep 8

  glitchNoise 12

  sleep 8


  f = wail mult(:f3, 1, 1), attack: 12, sustain: 26, release: 25, amp: 0.5
  sleep 15

  2.times do |idx|

    chime :f1, 0.7, 40

    sleep 6

    septmin7 = wail mult(mult(:f4, 5, 4), 3, 2), attack: 0, sustain: 7, release: 3, amp: 0
    septmin3 = wail mult(:f4, 5, 4), attack: 4, sustain: 5, release: 1, amp: 0.12
    wail mult(:f4, 3, 2), attack: 4, sustain: 5, release: 1, amp: 0.1
    wail mult(:f4, 1, 1), attack: 4, sustain: 5, release: 1, amp: 0.1


    iAmp(septmin7, 0.5, {2.5 => 0.6, 3.5 => 0.1, 8 => 0.6, 11 => 0.1})
    iNote(septmin7, 0.5, {3 => -1, 3.5 => mult(mult(:f4, 10, 9), 3, 2)})

    sleep 10

    septmin7 = wail mult(mult(:f4, 5, 4), 3, 2), attack: 1.5, sustain: 10, release: 2
    septmin3 = wail mult(:f4, 5, 4), attack: 4, sustain: 6, release: 1, amp: 0.12
    wail mult(:f4, 3, 2), attack: 4, sustain: 16, release: 1, amp: 0.1
    wail mult(:f4, 1, 1), attack: 4, sustain: 16, release: 1, amp: 0.1

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

    sleep 16

    if idx == 1
      break
    end

    septmin7 = wail mult(mult(:f4, 5, 4), 3, 2), attack: 0, sustain: 14, release: 3, amp: 0
    septmin3 = wail mult(:f4, 5, 4), attack: 4, sustain: 5, release: 1, amp: 0.12


    iAmp(septmin7, 0.5, {2.5 => 0.6, 3.5 => 0.1, 8 => 0.6, 9 => 0.1, 13 => 0.4})
    iNote(septmin7, 0.5, {
      3 => -1, 3.5 => mult(mult(:f4, 10, 9), 3, 2),
      5.5 => -1, 6 => mult(:f4, 5, 4),
      7 => -1, 7.5 => mult(:f4, 7, 5)
    })

    sleep 7.5

    wail mult(:g4, 3, 2), attack: 0.5, sustain: 8, release: 1, amp: 0.12
    wail mult(:g4, 1, 1), attack: 0.5, sustain: 8, release: 1, amp: 0.12

    sleep 5


    wail mult(:e4, 1, 1), attack: 0.5, sustain: 8, release: 1, amp: 0.12

    sleep 6
  end

  # SECOND TIME RPT ENDING
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

  sleep 10

end

import 'mvt2.sonicpi.rb'
