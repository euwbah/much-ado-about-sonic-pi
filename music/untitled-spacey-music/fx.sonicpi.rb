#Custom FX chain for ethereal sound
#foo is a lambda fn with 0 args
def ethereal(foo)
  with_fx :rlpf, cutoff: 95, res: 0.01 do
    with_fx :echo, phase: 1.5, decay: 11, mix: 0.3 do
      with_fx :gverb, mix: 0.45, damp: 0.5, room: 25, release: 6, spread: 0.8 do
        foo.call
      end
    end
  end
end
