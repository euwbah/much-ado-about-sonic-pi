# Input: 31ET-ED2 Note Name
# Outputs: Midi value for 31ET-ED2 note

# NOTE: Remember to add this directive to enable autocomplete
# for the 31EDO play function in atom!

#@ play p 0     <--    This one!

define :n do |x|
  octave = x[-1].to_i
  note = x[0..-2].downcase.to_sym
  base_note = note[0]
  accidental = note[1..-1] # may be nil

  # C  D  E  F  G  A  B
  # 0  5  10 13 18 23 28
  base_notes = {
    'c' => 0,
    'd' => 5,
    'e' => 10,
    'f' => 13,
    'g' => 18,
    'a' => 23,
    'b' => 28
  }

  # bb:   -5
  # db:   -4
  # bd:   -3
  # b:    -2
  # bu/d: -1
  # sd/u: +1
  # s:    +2
  # su:   +3
  # ss:   +4
  # x:    +5
  accidentals = {
    'bb' => -5,
    'db' => -4,
    'bd' => -3,
    'b' => -2,
    'bu' => -1,
    'd' => -1,
    'u' => 1,
    'sd' => 1,
    's' => 2,
    'su' => 3,
    'ss' => 4,
    'x' => 5,
    nil => 0,
    '' => 0
  }


  # idx = 0 means C
  idx = base_notes[base_note] + accidentals[accidental];
  basefreq = 440.0 * 2.0**(idx / 31.0)
  octave -= 4.0
  if idx >= 7
    octave -= 1.0
  end

  basefreq *= 2.0**octave

  print accidentals[accidental]

  return hz_to_midi(basefreq)
end

define :p do |note, *args|
  note = [note] if not note.kind_of?(Array)
  return play note.map{|nt| n(nt)}, *args
end

define :lerper do | name, value, reset=false |
  defonce name, override: reset do
    { 'val' => 1.0 * value, 'target' => 1.0 * value, 'from' => 1.0 * value }
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

define :lerp do | lfo, from, target, duration |
  lfo['from'] = 1.0 * from
  lfo['target'] = 1.0 * target
  if lfo['target'] != lfo['val'] or lfo['val'] != lfo['from']
    upwards = lfo['target'] > lfo['from']
    if (lfo['val'] < lfo['target'] and upwards) or
       ((not upwards) and lfo['val'] > lfo['target'])
      lfo['val'] += 1.0 * (lfo['target']-lfo['from']) / duration
    else
      lfo['val'] = lfo['target']
      lfo['from'] = lfo['target']
    end
  end
end

define :permute do | dataset, count=-1 |
  out = []
  vals = dataset[0..dataset.length]
  if count == -1
    while vals.length != 0
      x = vals.choose
      out.push x
      vals.delete x
    end
  else
    while vals.length != 0 and out.length < count
      x = vals.choose
      out.push x
      vals.delete x
    end
    while out.length < count
      out.push dataset.choose
    end
  end
  return out

end
