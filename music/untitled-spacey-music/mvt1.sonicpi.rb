PATH = '~/Documents/Sonic\ Pi\ Projects/much-ado-about-sonic-pi/music/untitled-spacey-music/'
def import(localdir)
  run_file PATH + localdir
end

import '/core.sonicpi.rb'

#@ play wail 2 :fm

def wail(*args)
  use_synth :fm
  play *args
end


#interpolate amp in separate thread
#note, resolution in beats, hash of time => value
def iAmp(n, res, values)
  in_thread do
    beat = 0
    prev_amp_value = n.args[:amp]
    #By beat (timestamp - res), the control for final target value must be sent
    values.each do |timestamp, amp_value|
      ticksleft = (timestamp - beat) / res
      currtick = 1 #currtick starts with one due to aforementioned reason... ^^^^
      while currtick <= ticksleft
        c n, amp: (1.0 * (ticksleft - currtick) / ticksleft * (prev_amp_value - amp_value)) + amp_value
        currtick += 1
        beat += res
        sleep res
      end
      prev_amp_value = amp_value
    end
  end
end


#similar to iAmp
def iNote(n, res, values)
  in_thread do
    beat = 0
    prev_note_value = n.args[:note]
    values.each do |timestamp, note_value|
      ticksleft = (timestamp - beat) / res
      currtick = 1
      print beat, timestamp, note_value
      while currtick <= ticksleft
        print ticksleft, currtick
        if note_value != -1
          c n, note: (1.0 * (ticksleft - currtick) / ticksleft * (prev_note_value - note_value)) + note_value
        end
        currtick += 1
        beat += res
        sleep res
      end
      if note_value != -1
        prev_note_value = note_value
      end
    end
  end
end

#Custom FX chain for ethereal sound
#foo is a lambda fn with 0 args
def ethereal(foo)
  with_fx :rlpf, cutoff: 95, res: 0.01 do
    with_fx :echo, phase: 1.5, decay: 11, mix: 0.3 do
      with_fx :gverb, mix: 0.45, damp: 0.5, room: 25, release: 6, spread: 0.8 do
        foo.call
      end
    end
  end
end



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

            sleep 7

            f = wail mult(:f3, 1, 1), attack: 12, sustain: 26, release: 7, amp: 0.5
            sleep 12

            septmin7 = wail mult(mult(:f4, 5, 4), 3, 2), attack: 0, sustain: 6, release: 1, amp: 0
            septmin3 = wail mult(:f4, 5, 4), attack: 4, sustain: 5, release: 1, amp: 0.2
            wail mult(:f4, 3, 2), attack: 4, sustain: 5, release: 1, amp: 0.2
            wail mult(:f4, 1, 1), attack: 4, sustain: 5, release: 1, amp: 0.2


            iAmp(septmin7, 0.5, {2.5 => 0.6, 3.5 => 0.1, 8 => 0.6, 11 => 0.1})
            iNote(septmin7, 0.5, {3 => -1, 3.5 => mult(mult(:f4, 10, 9), 3, 2)})

            sleep 10

            septmin7 = wail mult(mult(:f4, 5, 4), 3, 2), attack: 0.5, sustain: 10, release: 1
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
