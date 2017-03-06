set_volume! 0.1

use_debug false

sleep 0.01

use_bpm 84

#@ play p 0

define :chd do | name |
  
end

abmaj9 = [:ab3, :c4, :f4, :g4, :bb4]
gmin9 = [:g3, :d4, :fd4, :a4, :bb4]
fmin9 = [:f3, :c4, :eb4, :g4, :bb4]
dbh7 = [:db4, :f4, :gb4, :bd4]
csuss = [:c4, :fu4, :g4, :as4]
csus711 = [:c4, :f4, :g4, :bb4]

p_abmaj9 = abmaj9 + [:ab2]
p_gmin9 = gmin9 + [:g2]
p_fmin9 = fmin9 + [:f2]
p_dbh7 = dbh7 + [:db3]
p_csuss = csuss + [:c3]
p_csus711 = csus711 + [:c3]

lerper :pulsecut, 50

with_fx :compressor, relax_time: 0.2, threshold: 0.3 do
  live_loop :pulse do
    with_random_seed ring(1337)[look] do
      oldcut = pulsecut['val']
      lerp pulsecut, 80, 110, 8
      with_fx :echo, phase: 0.625, mix: 0.5, decay: 4 do
        with_fx :rlpf, cutoff: oldcut, cutoff_slide: 15, res: 0.5 do | pulselpf |
          control pulselpf, cutoff: pulsecut['val']
          tick
          pulser ring(p_fmin9, p_abmaj9, p_csuss, p_gmin9)[look], 20, 0.2, permute([1, 0, 0.9, 0.1, 0.4], 5)
        end
      end
    end
  end

  live_loop :kicks do
    with_random_seed ring(*range(0, 16))[look] do
      sync :kick
      tick
      sample :bd_fat, amp: 3
      sample :bd_fat, amp: 2, rate: 1.3
      if look % 2 != 1
        sleep 1
      else
        flag1 = rand < 0.6
        if flag1
          sleep 0.4
          sample :bd_fat, amp: 1, rate: 1.7
          sleep 0.2
          sample :bd_fat, amp: 2, rate: 1.4
          sleep 0.4
        else
          sleep 0.65
          sample :bd_fat, amp: 2, rate: 1.7
          sleep 0.35
        end
      end

      # sleep 3
    end
  end

  live_loop :snares do
    with_fx :gverb, room: 100, mix: 0.2 do
      sleep 1
      sample :sn_dolf
      sleep 1
      cue :kick
    end
  end
end

live_loop :arp do
  with_random_seed ring(1337)[look] do
    tick
    use_synth :dpulse
    subdiv = 5
    beats = 5*4
    phrase = 4
    phrase = phrase || beats
    notes = ring(*permute(ring(fmin9, abmaj9, csuss, gmin9)[look], phrase))
    with_fx :rhpf, cutoff: 79, res: 0.5 do
      with_fx :gverb, room: 300, mix: 0.95 do
        beats.times do | x |

          p notes[x], amp: 0.2, release: 0.15, pulse_width: 0.45, detune: 0.05
          sleep 1.0 / subdiv
        end
      end
    end
  end
end
