#For n-limit ratioized intonation
def mult(baseFreq, numerator, denominator)
  return hz_to_midi(midi_to_hz(baseFreq) * 1.0 * numerator / denominator)
end

#method shortener for control
def c(*args)
  control *args
end
