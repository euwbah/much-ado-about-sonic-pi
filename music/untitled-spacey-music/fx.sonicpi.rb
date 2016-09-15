def eq args, &process
  currProc = process
  for arg in args
    freq = hz_to_midi(arg[:freq].nil? ? 1200 : arg[:freq])
    res = arg[:res].nil? ? 0 : arg[:res]
    db = arg[:db].nil? ? 0 : arg[:db]
    currProc = encapsulate ({:freq=>freq, :res=>res, :db=>db, :process=>currProc})
    repFn = lambda do |hash|
      with_fx :band_eq, freq: hash[:freq], res: hash[:res], db: hash[:db], &(hash[:process])
    end
    currProc = compose repFn, currProc
  end
  currProc.call nil
end

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
    with_fx :panslicer, wave: 2, phase: 0.8, smooth: 0.2 do
      process.call glitch_slicer
    end
  end
end

def sidechain(compressorParams, *fns)
  with_fx :compressor, compressorParams do
    fns.each do |f|
      in_thread do
        if f.class == "Array"
          f
        else
          f.call
        end
      end
    end
  end
end

def drum_fx_chain &process
  with_fx :compressor, slope_below: 1, slope_above: 0.6, threshold: 0.7, relax_time: 0.3 do
    with_fx :tanh, krunch: 0.05, mix: 0.5 do
      process.call
    end
  end
end
