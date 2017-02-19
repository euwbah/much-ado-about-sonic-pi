define :n do |x|
  octave = x[-1].to_i
  note = x[0..-2].downcase.to_sym
  freqs = [:a, :au, :as, :bb, :bd, :b, :bu, :cd, :c,
           :cu, :cs, :db, :dd, :d, :du, :ds, :eb, :ed, :e,
           :eu, :fd, :f, :fu, :fs, :gb, :gd, :g, :gu, :gs,
           :ab, :ad
           ]

  idx = freqs.index(note);
  basefreq = 440.0 * 2.0**(idx / 31.0)
  octave -= 4.0
  if idx >= 7
    octave -= 1.0
  end

  basefreq *= 2.0**octave

  return hz_to_midi(basefreq);
end

#@ play p

define :p do |note, *args|
  note = [note] if not note.kind_of?(Array)
  return play note.map{|nt| n(nt)}, *args
end

#@ play lead 0 :fm

define :lead do |note, *args|
  use_synth :fm
  use_merged_synth_defaults divisor: 0.5005, depth: 2
  x = p note, {amp: 0.2}, *args
  return x
end

define :glassptn do |notes, *args|
  use_synth :fm
  use_merged_synth_defaults release: 2, divisor: 0.5, depth: 0.3
  p notes[0], *args
  sleep 1
  p notes[1..-1], *args
  sleep 2
end

use_bpm 96

set_volume! 1.2

define :b1 do
  2.times { glassptn [:g3, :d4, :eb4, :bb4] }
  2.times { glassptn [:g3, :c4, :eb4, :bb4] }
  2.times { glassptn [:g3, :bb3, :d4, :bb4] }
  2.times { glassptn [:fs3, :c4, :d4, :a4] }
end

define :b9 do
  glassptn [:f3, :d4, :eb4, :bb4]
  glassptn [:f3, :d4, :eb4, :a4]
  p :eb3
  sleep 1.12
  p [:c4, :d4, :a4]
  sleep 1.08
  p :dd4, amp: 0.8
  sleep 1.09
  p [:eb3, :db4], amp: 0.8
  sleep 1.11
  p [:cs4, :g4], amp: 0.8
  sleep 1.13
  p :cu4, amp: 0.8
  sleep 1.16
  use_bpm 86
  2.times { glassptn [:d3, :c4, :eb4, :g4] }
  glassptn [:d3, :cd4, :eb4, :fs4]
  sleep 0.06
  glassptn [:d3, :cd4, :d4, :fs4], sustain: 3
  sleep 6
end

define :b17 do
  use_bpm 96
  in_thread do
    2.times { glassptn [:g3, :d4, :eb4, :bb4] }
    2.times { glassptn [:g3, :c4, :eb4, :bb4] }
    glassptn [:ab3, :cu4, :d4, :gu4]
    glassptn [:d3, :cd4, :d4, :fs4]
    p :g3
    sleep 1
    p [:bb3, :d4], amp: 0.7
    p :gb4
    sleep 1
    p :a4
  end
  lead :d5, attack: 1, sustain: 4, release: 2
  sleep 2*3
  sleep 2
  x = lead :c5, attack: 0.8, sustain: 7, release: 1, note_slide: 0.02
  sleep 1
  control x, note: n(:eb5)
  sleep 2
  control x, note: n(:d5)
  sleep 1
  control x, note: n(:a4)
  sleep 5

  x = lead :c5, attack: 0.6, sustain: 6, release: 1, note_slide: 0.1
  sleep 2
  control x, note: n(:bb4)
  sleep 2
end

define :b24 do
  in_thread do
    use_synth :beep
    p :g4
    sleep 1
    p :d4
    sleep 1
    p :f4
    sleep 1
    glassptn [:eb3, :bb3, :f4]
    glassptn [:eb3, :b3, :fs4]
    2.times { glassptn [:cs3, :cs4, :e4, :bb4] }
  end
  sleep 3
  lead :g4, attack: 1, release: 2, amp: 0.1
  sleep 4

  x = lead :ad4, attack: 1, sustain: 2.5, release: 1, amp: 0.15, note_slide: 0.05
  sleep 1
  control x, note: n(:bb4)
  sleep 1
  control x, note: n(:e5)
  sleep 3
  x = lead :gu4, attack: 1, sustain: 1, release: 1, amp: 2

end

define :b63 do
  in_thread do
    2.times do
      glassptn [:ad3, :cu4, :fu4]
      glassptn [:ad3, :cu4, :gu4]
    end
  end
  lead :cu5, attack: 2, sustain: 3, release: 3, amp: 0.4
  sleep 4*3
end

define :b67 do
  in_thread do
    2.times do
      glassptn [:ad3, :bu3, :fu4]
      glassptn [:ad3, :bu3, :g4]
    end
  end
  lead :bu4, attack: 2, sustain: 3, release: 3, amp: 0.4
  sleep 4*3
end

define :b71 do
  in_thread do
    2.times do
      glassptn [:ab3, :bu3, :eu4]
      glassptn [:ab3, :bu3, :gb4]
    end
  end
  lead :bu4, attack: 2, sustain: 3, release: 3, amp: 0.4
  sleep 4*3
end

with_fx :compressor, amp: 1.5 do
  with_fx :reverb, room: 0.96, mix: 0.6 do
    with_fx :echo, phase: 0.8, decay: 5, mix: 0.2 do
      b1
      b9
      b17
      b24
      b63
      b67
      b71
    end
  end
end
