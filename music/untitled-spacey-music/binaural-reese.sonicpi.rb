$binauralModel = { :instance => [] }

# Plays the binaural bass and returns an instance of itself in the form of
# [synth_instances::Synth Nodes, filter_instance::FX node]
# NOTE: The sharper synth instance is first in the synth_instaces array
define :binaural do |note, **opts|
  use_synth :pulse
  use_synth_defaults pulse_width: 0.8, cutoff: 100
  reese = opts[:reese] || 1
  amp = opts[:amp] || 1
  freq = opts[:freq] || 400
  eq_params = [
    {:freq => 100, :res => 0.8, :db => 12},
    {:freq => 16000, :res => 0.2, :db => 12}
  ]

  synth_instances = []
  filter = nil
  with_fx :compressor, clamp_time: 0.005, relax_time: 0.2, slope_above: 0.1, threshold: 0.7 do
    with_fx :band_eq, freq: hz_to_midi(freq), db: 24, res: 0.5 do |fx_instance|
      with_fx :bitcrusher, sample_rate: 11025, bits: 8 do
        filter = fx_instance
        eq eq_params do
          synth_instances.push play note + reese * 0.1, **opts, pan: -1, amp: amp * 0.1
          synth_instances.push play note - reese * 0.1, **opts, pan: 1, amp: amp * 0.1
        end
      end
    end
  end

  $binauralModel = {:instance => [synth_instances, filter, note]}
  return [synth_instances, filter, note]
end

# For controlling both note and reese amount
def bin_note instance, note=nil, reese=1, slide_time=nil
  sharper, flatter = instance[0]
  note = instance[2] if not note
  if slide_time
    c instance[0], note_slide: slide_time
  end

  control sharper, note: note + reese * 0.1
  control flatter, note: note - reese * 0.1
end

def bin_freq instance, freq, time=1
  filter = instance[1]
  control filter, freq_slide: time
  control filter, freq: hz_to_midi(freq)
end

def bin_c instance, *args
  c instance[0], *args
end

def bin_ct instance, time, *args
  ct time, instance[0], *args
end

# Use these methods to control
# bt => Binaural target
define :bt_note do |note=nil, reese=1, duration=1, slide_time=0.5|
  in_thread do
    sleep duration - slide_time
    bin_note $binauralModel[:instance], note, reese, slide_time
    sleep slide_time
  end
end

# Duration refers to the time before rising occurs
define :wob do |high:, low: 80, rise: 0.5, duration: rise, fall: 0.5|
  in_thread do
    sleep duration - rise
    instance = $binauralModel[:instance]
    bin_freq instance, high, rise
    sleep rise
    bin_freq instance, low, fall
  end
end
