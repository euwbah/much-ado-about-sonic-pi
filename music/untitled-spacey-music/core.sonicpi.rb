#For n-limit ratioized intonation
def mult(baseFreq, numerator, denominator)
  return hz_to_midi(midi_to_hz(baseFreq) * 1.0 * numerator / denominator)
end

#method shortener for control
def c(*args)
  control *args
end

#interpolate amp in separate thread
#note, resolution in beats, hash of time => value
def iAmp(n, res, values)
  in_thread do
    beat = 0
    prev_amp_value = n.args[:amp]
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
def iNote(n, res, values)
  in_thread do
    beat = 0
    prev_note_value = n.args[:note]
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
