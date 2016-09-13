#Custom FX chain for ethereal sound
#foo is a lambda fn with 0 args
def ethereal(&foo)
  with_fx :rlpf, cutoff: 95, res: 0.01 do
    with_fx :echo, phase: 1.5, decay: 11, mix: 0.2 do
      with_fx :gverb, mix: 0.45, damp: 0.5, room: 25, release: 6, spread: 0.8 do
        stereoize 0.002, 0.7 do
          foo.call
        end
      end
    end
  end
end

def stereoize(phase, width, &process)
  in_thread do
    with_fx :pan, pan: phase >= 0 ? width : -width do
      process.call
    end
  end
  sleep phase
  with_fx :pan, pan: phase <= 0 ? width : -width do
    process.call
  end
end

def glitch(&process)
  with_fx :slicer, phase: 0.25, amp_min: 1 do |glitch_slicer|
    with_fx :panslicer, wave: 1, phase: 0.25, smooth: 0.2 do
      process.call glitch_slicer
    end
  end
end
