set_volume! 0.05

sleep 0.1

define :n do |x|
  octave = x[-1].to_i
  note = x[0..-2].downcase.to_sym
  freqs = [:a, :au, :as, :bb, :bd, :b, :bu, :cd, :c,
           :cu, :cs, :db, :dd, :d, :du, :ds, :eb, :ed, :e,
           :eu, :fd, :f, :fu, :fs, :gb, :gd, :g, :gu, :gs,
           :ab, :ad]

  idx = freqs.index(note);
  basefreq = 440.0 * 2.0**(idx / 31.0)
  octave -= 4.0
  if idx >= 7
    octave -= 1.0
  end

  basefreq *= 2.0**octave

  return hz_to_midi(basefreq)
end

#@ play p 0

define :p do |note, *args|
  note = [note] if not note.kind_of?(Array)
  return play note.map{|nt| n(nt)}, *args

end

define :fives do
  with_fx :rlpf, cutoff: 90, res: 0.1 do
    use_synth :mod_fm
    use_synth_defaults divisor: 0.5004, depth: 1, mod_range: 24, mod_pulse_width: 0.08
    x = 0
    ct = 20
    mult = 5
    chd1 = ring(:b3, :c4, :e4, :g4, :b4)
    chd2 = ring(:bb3, :c4, :eb4, :g4, :bb4)
    chd3 = ring(:ab3, :c4, :eb4, :f4, :eb4)
    currchd = nil
    (ct * mult - x).times do
      currchd =
        case (x / mult)
        when 0, 8
          chd1
        when 4, 12
          chd2
        when 16
          chd3
        else
          currchd
        end
      p currchd[x], amp: 0.7 + 0.1 * (x % mult) + rand(0.12) - 0.06
      x += 1
      sleep 1.0 / mult
    end
  end
end

define :fours do
  with_fx :rlpf, cutoff: 90, res: 0.6 do
    use_synth :tri
    x = 0
    ct = 20
    mult = 4
    chd1 = ring(:d5, :b4, :g4, :e4)
    chd2 = ring(:d5, :bb4, :g4, :eb4)
    chd3 = ring(:d5, :bb4, :g4, :f4)
    chd4 = ring(:d5, :c5, :bb4, :g4)
    currchd = nil
    (ct * mult - x).times do
      currchd =
        case x / mult
        when 0, 8
          chd1
        when 4, 12
          chd2
        when 16
          chd3
        when 20
          chd4
        else
          currchd
        end
      p currchd[x], amp: 0.8 - 0.1 * (x % mult) + rand(0.12) - 0.06
      x += 1
      sleep 1.0 / mult
    end
  end
end

define :glitch do
  in_thread do
    with_fx :bitcrusher, bits: 4, sample_rate: 15184 do
      with_fx :reverb, room: 0.99, damp: 0, mix: 0.5, amp: 0.3 do
        with_fx :vowel, vowel_sound: 2, mix: 0.1 do |vowel|
          use_synth :fm
          x = p :c4, amp: 0.1, sustain: 10
          use_synth :bnoise
          y = play :c7, amp: 3, sustain: 10
          200.times do
            num = rand * 0.9 + 0.1
            control x, note: 90 + num * 50.0, divisor: num ** 3, amp: num, pan: rand(-1..1)
            control y, res: num / 1.0, cutoff: num * 40 + 90, amp: num * 3
            control vowel, vowel_sound: rand_i(1..6), voice: rand_i(0..5)
            sleep (1 - num) / 8.0
          end
          kill x
          kill y
        end
      end
    end
  end
end

define :pulser do | notes, times, dur, amps=[1], *params |

  use_synth :dsaw
  amp_ring = ring(*amps)

  with_fx :reverb, room: 0.7, damp: 0.6, mix: 0.6 do

    times.times { | count |
      p notes, {attack: 0.01, release: dur * 1.1, sustain: 0, amp: amp_ring[count]}, *params
      sleep dur
    }

  end
end

with_fx :rlpf, cutoff: 70, cutoff_slide: 1, res: 0.5 do |lpf|
  in_thread do
    cut = 70
    12.times do
      control lpf, cutoff: cut
      cut += 5
      sleep 1
    end
  end
  pulser [:c4, :fu4, :g4, :as4], 15, 0.2, [1, 0.7, 0.9, 0.7, 0.5]
  pulser [:c4, :f4, :g4, :bb4], 15, 0.2, [1, 0.7, 0.9, 0.7, 0.5]
  pulser [:c4, :fu4, :g4, :as4], 15, 0.2, [1, 0.7, 0.9, 0.7, 0.5]
  pulser [:c4, :f4, :g4, :bb4], 15, 0.2, [1, 0.7, 0.9, 0.7, 0.5]
  2.times do |count|
    pulser [:ab3, :c4, :f4, :g4, :bb4], 15, 0.2, [1, 0.7, 0.9, 0.7, 0.5]
    pulser [:ab3, :c4, :eb4, :g4, :bb4], 15, 0.2, [1, 0.7, 0.9, 0.7, 0.5]
    pulser [:c4, :fu4, :g4, :as4], 15, 0.2, [1, 0.7, 0.9, 0.7, 0.5]
    pulser [:c4, :f4, :g4, :bb4], 15, 0.2, [1, 0.7, 0.9, 0.7, 0.5] if count == 0
  end
  pulser [:c4, :e4, :g4, :a4], 15, 0.2, [1, 0.7, 0.9, 0.7, 0.5]

end
