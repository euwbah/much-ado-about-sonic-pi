def compose f, g
  return lambda do |arg|
    f.call(g.call arg)
  end
end

def encapsulate f, *args
  Proc.new do
    f
  end
end

#For n-limit ratioized intonation
def mult(baseFreq, numerator, denominator)
  return hz_to_midi(midi_to_hz(baseFreq) * 1.0 * numerator / denominator)
end

#@control c
#method shortener for controlling multiple synth's params
def c *args
  for node in args[0]
    control node, args[1]
  end
end

#interpolate amp in separate thread
#note, resolution in beats, hash of time => value
def iAmp n, res, values
  in_thread do
    beat = 0
    prev_amp_value = n[0].args[:amp]
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
def iNote n, res, values
  in_thread do
    beat = 0
    prev_note_value = n[0].args[:note]
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

# interpolate
def i n, argSymbol, res, values
  in_thread do
    beat = 0
    prev_value = n[0].args[argSymbol]
    values.each do |timestamp, value|
      ticksleft = (timestamp - beat) / res
      currtick = 1
      print beat, timestamp, value
      while currtick <= ticksleft
        print ticksleft, currtick
        if value != :same
          c n, {argSymbol => (1.0 * (ticksleft - currtick) / ticksleft * (prev_value - value)) + value}
        end
        currtick += 1
        beat += res
        sleep res
      end
      if value != :same
        prev_value = value
      end
    end
  end
end

# def vibrato(nodesArray, startRate, endRate, startDepth, endDepth, duration)
#   in_thread do
#     elasped = 0.0
#     while elasped < duration
#       currRate = (endRate - startRate) * (elasped / duration) + startRate
#       currDepth = (endDepth - startDepth) + (elasped / duration) + startDepth
#       elasped += 1. / currRate
#       c nodesArray, note: elasped * elasped
#       sleep elasped
#     end
#   end
# end
