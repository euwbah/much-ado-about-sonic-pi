define :wail do |*args|
  ret = []
  use_synth :fm
  ret.push play(*args, divisor: 1.001)
  use_synth :pnoise
  with_fx :rhpf, cutoff: 80, res: 0.1, amp: 0.13 do
    ret.push play(*args, attack: 0.04, attack_level: 1.5, decay: 0.03, sustain_level: 0.5, cutoff: 110)
  end
  return ret
end

define :glitchNoise do |duration|
  use_synth :cnoise
  x = nil
  with_fx :bpf, cutoff: 110, res: 0.9, pre_amp: 1.6 do |f|
    x = play :c4, sustain: 0, release: duration, amp: 0.2, cutoff: 100, cutoff_slide: 0.25
    in_thread do
      for i in 0..duration*4
        control f, centre: 30 + rand * 80
        control x, pan: rand * 1 - 0.5
        sleep 0.25
      end
    end
  end
  return [x]
end

define :chime do |note, amp, duration=1|
  ret = []
  use_synth :pretty_bell
  with_fx :hpf, mix: 0.5, cutoff: 90, amp: 2 do
    with_fx :gverb, room: 312 do
      for i in 1..16
        ret.push play mult(note, (i * 2) * (0.97 + rand * 0.06), 1), amp: amp / (i**3.5), release: duration / (i**1.06)
      end
      for i in 16..32
        ret.push play mult(note, (i * 2) * (0.85 + rand * 0.3), 1), amp: amp * 0.05 / (i**1.8), attack_level: 1 + i / 2.0, decay: 2, release: duration / (i**1.03)
      end
    end
  end
  return ret
end
