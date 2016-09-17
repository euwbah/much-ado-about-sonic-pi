# Plays the binaural bass and returns an instance of itself in the form of
# [synth_instances::Synth Nodes, filter_instance::FX node]
# NOTE: The sharper synth instance is first in the synth_instaces array
define :binaural do |note, **opts|
  use_synth :pulse
  use_synth_defaults pulse_width: 0.8, cutoff: 100
  reese = opts[:reese] || 1
  amp = opts[:amp] || 1
  freq = opts[:centre] || 400
  eq_params = [
    {:freq => 200, :res => 0, :db => 21},
    {:freq => 14000, :res => 0.2, :db => 18}
  ]

  synth_instances = []
  filter = nil
  with_fx :compressor, clamp_time: 0.03, relax_time: 0.2 do
    with_fx :band_eq, freq: hz_to_midi(freq), db: 12, res: 0.2 do |fx_instance|
      filter = fx_instance
      eq eq_params do
        synth_instances.push play note + reese * 0.1, **opts, pan: -1, amp: amp * 0.2
        synth_instances.push play note - reese * 0.1, **opts, pan: 1, amp: amp * 0.2
      end
    end
  end

  return [synth_instances, filter, note]
end

# For controlling both note and reese amount
def ctl_bin_note synth_instances, note, reese=1, slide_time=nil
  sharper, flatter = synth_instances
  if slide
    c synth_instances, note_slide: slide_time
  end

  control sharper, note: note + reese * 0.1
  control flatter, note: note - reese * 0.1
end
