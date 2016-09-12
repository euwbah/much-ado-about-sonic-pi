def wail(*args)
  use_synth :bnoise
  play :c4, cutoff: 110, sustain: 0, release: 0.1, amp: args[1][:amp] / 2
  use_synth :fm
  return play *args
end
