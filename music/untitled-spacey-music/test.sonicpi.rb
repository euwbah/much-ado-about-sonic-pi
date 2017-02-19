use_bpm 144

c_anchor = mult(:f4, 3, 2)
g_anchor = mult(:f4, 9, 4)

ab_anchor = mult(c_anchor, 4, 5)
eb_anchor = mult(c_anchor, 6, 5)

glitch_pad = Proc.new do
  glitch do |glitch_slicer|
    stereoize 0.007, 0.6 do
      with_fx :rlpf, cutoff: 120, res: 0.4, cutoff_slide: 1, amp: 3 do |lpf|
        sleep 1.5
        #i [lpf], :cutoff, 1.0, {14.5 * 4 => 120}
        #control glitch_slicer, amp_min_slide: 12
        control glitch_slicer, amp_min: 0.4


        4.times do |rep|
          use_synth_defaults note_slide: 0.5, amp: 0.5, amp_slide: 0.5

          # Fmaj9
          pad mult(:f4, 1, 1), sustain: 14.5, release: 0, amp: 0.2
          pad mult(:f4, 5, 4), sustain: 14.5, release: 0, amp: 0.2
          pad c_anchor, sustain: 14.5, release: 0, amp: 0.2
          pad mult(:f4, 15, 8), sustain: 14.5, release: 0, amp: 0.2
          pad g_anchor, sustain: 14.5, release: 0, amp: 0.2

          sleep 14.5

          # Abmaj7
          pad ab_anchor, sustain: 14.5, release: 0, amp: 0.2
          pad c_anchor, sustain: 14.5, release: 0, amp: 0.2
          pad eb_anchor, sustain: 14.5, release: 0, amp: 0.2
          pad g_anchor, sustain: 14.5, release: 0, amp: 0.2

          sleep 14.5

          # Emaj7
          pad mult(ab_anchor, 4, 5), sustain: 14.5, release: 0, amp: 0.2
          pad ab_anchor, sustain: 14.5, release: 0, amp: 0.2
          pad mult(ab_anchor, 6, 5), sustain: 14.5, release: 0, amp: 0.2
          pad eb_anchor, sustain: 14.5, release: 0, amp: 0.2

          if rep == 0
            control glitch_slicer, amp_min: 0.4
          end

          sleep 14.5

          # Fmin7
          if rep == 0
            pad mult(ab_anchor, 5, 6), sustain: 13.5, release: 0, amp: 0.2
            pad ab_anchor, sustain: 13.5, release: 0, amp: 0.2
            pad mult(ab_anchor, 5, 4), sustain: 13.5, release: 0, amp: 0.2
            pad eb_anchor, sustain: 13.5, release: 0, amp: 0.2
          else
            pad mult(ab_anchor, 5, 6), sustain: 14.5, release: 0, amp: 0.2
            pad ab_anchor, sustain: 14.5, release: 0, amp: 0.2
            pad mult(ab_anchor, 5, 4), sustain: 14.5, release: 0, amp: 0.2
            pad eb_anchor, sustain: 14.5, release: 0, amp: 0.2
          end
          sleep 14.5
        end
      end
    end
  end
end

drums = Proc.new do
  drum_fx_chain do
    at 0 do
      use_synth :cnoise
      n = play :c4, cutoff: 30, cutoff_slide: 0.5, res: 0.86, sustain: 0, release: 0, attack: 0.5
      control n, cutoff: 103
      sleep 0.5
      snare 0.9
      sleep 0.5
      kick 0.9
      sleep 0.5
    end
    sleep 1.5
    8.times do | reps |
      with_random_seed ring(1337, 42, 1337, 43).tick do
        kick4       0
        snare4      0
        kick3       0
        snare3sync  0
        if reps % 2 == 0
          kick2       0
          kick4       0
          snare33     0
          any33       0
          any33       0
        else
          kick3       0
          kick33      0
          snare3      0
          any33       0
          any33       0
        end
      end
    end
    playDrums
  end
end

# XXX: BAAAASSSSSSS!!!!
drop_this = Proc.new do
  sleep 1.5

  # Bar 1 (7/8)
  instance = binaural :f1, sustain: 4, release: 0, attack: 0, freq: 16000, pulse_width: 0.5
  # puts instance
  bin_freq instance, 80, 1
  bt_note :f2, 6, 1.5, 0.3 # note | reese | total duration before reaching target | duration of slide
  sleep 1.5
  wob high: 1000, rise: 0.2, fall: 0.3
  sleep 2

  # Bar 2 (15/16)
  sleep 1.5

  instance = binaural :f2, sustain: 2.25, release: 0, attack: 0, freq: 80, pulse_width: 0.5
  wob high: 5000, rise: 0.1, fall: 0.3

  bt_note c_anchor - 36, 4, 0.75, 0.3
  sleep 0.75
  wob high: 6000, rise: 0.1, fall: 0.3

  bt_note c_anchor - 48, 5, 0.75, 0.3
  sleep 0.75
  wob high: 11000, rise: 0.1, fall: 0.3

  sleep 0.75

  # Bar 3 (7/8)
  instance = binaural :f0, sustain: 1, release: 0, attack: 0, freq: 50, pulse_width: 0.75
  wob high: 5000, low: 30, rise: 0.2, fall: 0.7

  sleep 3.5

  # Bar 4 (15/16)
  sleep 1.5
  instance = binaural :bb1, sustain: 2.25, release: 0, attack: 0, freq: 20, pulse_width: 0.1, amp: 2
  wob high: 16000, low: 15, rise: 0.1, fall: 0.5

  bt_note c_anchor - 36, 1, 0.75, 0.2
  sleep 0.75
  wob high: 16000, low: 15, rise: 0.1, fall: 0.5

  bt_note :f1, 1, 0.75, 0.4
  sleep 0.75
  wob high: 16000, low: 15, rise: 0.1, fall: 0.5

  sleep 0.75

  # Bar 5 (7/8)
  instance = binaural ab_anchor - 36, sustain: 14.5, release: 0, attack: 0, freq: 10000, pulse_width: 0.5, reese: 0
  bin_freq instance, 50, 3.5
  sleep 1
  bt_note nil, 2, 2.5, 2.5
  sleep 2.5

  # Bar 6 (15/16)
  sleep 1.5

  bt_note ab_anchor - 24, 5, 2.25, 2.25

  sleep 1

  wob high: 2000, low: 70, rise: 0.3, fall: 0.3
  sleep (2.25 / 5.0) + 0.2
  wob high: 2000, low: 80, rise: 0.2, fall: 0.25
  sleep (2.25 / 5.0) + 0.1
  wob high: 2000, low: 90, rise: 0.15, fall: 0.2
  sleep (2.25 / 5.0)

  # Bar 7 (7/8)
  wob high: 2000, low: 100, rise: 0.1, fall: 0.15
  sleep (2.25 / 5.0) - 0.1
  wob high: 2000, low: 100, rise: 0.1, fall: 0.1
  sleep (2.25 / 5.0) - 0.2
  wob high: 2000, low: 100, rise: 0.1, fall: 0.1
  sleep 0.25
  wob high: 2000, low: 100, rise: 0.1, fall: 0.1
  sleep 0.25
  wob high: 2000, low: 100, rise: 0.1, fall: 0.1
  sleep 0.25

end

pad_drum_sidechain_args = { :slope_below => 1.7, :slope_above => 0.6, :threshold => 0.4, :pre_amp => 1.3, :clamp_time => 0.03, :relax_time => 0.2 }
sidechain pad_drum_sidechain_args, drums, drop_this, glitch_pad
