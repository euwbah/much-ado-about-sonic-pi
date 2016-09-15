use_bpm 132

# GLITCH PAD
glitch_pad = Proc.new do
  glitch do |glitch_slicer|
    stereoize 0.007, 0.6 do
      with_fx :rlpf, cutoff: 50, res: 0.4, cutoff_slide: 1, amp: 4 do |lpf|
        i [lpf], :cutoff, 1.0, {14.5 * 4 => 120}
        control glitch_slicer, amp_min_slide: 12
        control glitch_slicer, amp_min: 0

        4.times do |rep|
          use_synth_defaults note_slide: 0.5, amp: 0.5, amp_slide: 0.5

          # Fmaj9
          c_anchor = mult(:f4, 3, 2)
          g_anchor = mult(:f4, 9, 4)

          pad mult(:f4, 1, 1), sustain: 14.5, release: 0, amp: 0.2
          pad mult(:f4, 5, 4), sustain: 14.5, release: 0, amp: 0.2
          pad c_anchor, sustain: 14.5, release: 0, amp: 0.2
          pad mult(:f4, 15, 8), sustain: 14.5, release: 0, amp: 0.2
          pad g_anchor, sustain: 14.5, release: 0, amp: 0.2

          sleep 14.5

          # Abmaj7
          ab_anchor = mult(c_anchor, 4, 5)
          eb_anchor = mult(c_anchor, 6, 5)

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
            control glitch_slicer, amp_min: 0.6
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
  sleep (14.5 * 4 - 1)
  sample :sn_dub, amp: 1
  sleep 0.5
  sample :bd, amp: 1
  sleep 0.5
end

sidechain drums, glitch_pad
