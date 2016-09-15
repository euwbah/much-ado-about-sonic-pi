# Naming conventions:
# X N Y => X: type of accent, N: Number of semiquavers, Y => Displacement
# Displacements:
# None: on the downbeat
# e: on the semiquaver after the downbeat
# and: two semiquavers after the downbeat
# a: one semiquaver before the next downbeat
# sync: either the e or the a

#NOTE: :sequence contains an array of Procs
drum_model = { :openHatInstance => nil, :sequence => [] }

# Returns true if process is executed, false if not. NOTE: Just a helper function.
def flag(toBeOrNotToBe, &process)
  if toBeOrNotToBe
    process.call
    return toBeOrNotToBe
  end
end

define :playDrums do
  for process in drum_model[:sequence]
    puts process
    drum_model = process.call(drum_model)
  end
end

define :seq_kick do | amp |
  drum_model[:sequence] << lambda do | model |
    kick amp
    return model
  end
end

define :seq_snare do | amp |
  drum_model[:sequence] << lambda do | model |
    snare amp
    return model
  end
end

define :seq_hat do | amp, opened |
  drum_model[:sequence] << lambda do | model |
    openHatInstance = hat amp, opened, model[:openHatInstance]
    model[:openHatInstance] = openHatInstance
    return model
  end
end

define :seq_sleep do | time |
  drum_model[:sequence] << lambda do | model |
    sleep time
    return model
  end
end


def kick4(ambiguity=0)
  seq_kick 0.8 + rand*0.2
  seq_hat 0.6 + rand * 0.2, false
  seq_sleep 0.25

  ghosted = flag (rand < 0.3 * ambiguity) {seq_snare 0 + rand * 0.3}
  seq_hat 0.2 + rand * 0.3, false
  seq_sleep 0.25

  doublebeat = flag (rand < 0.9 - ambiguity / 2.0) {seq_kick rand * 0.3 + (ghosted ? 0.4 : 0.6)}
  opened = false
  seq_hat 0.5 + rand * 0.2, (opened = (doublebeat and rand < 0.5))
  seq_sleep 0.25

  seq_kick (doublebeat ? 0.5 : 0.3) + rand * 0.2 if not ((ghosted and doublebeat) or opened) and rand < 0.8 * ambiguity
  if not opened
    seq_hat 0.2 + rand * 0.3, false
  end
  seq_sleep 0.25
end

def kick4and ambiguity=0
  seq_kick 0.8 + rand*0.2
  seq_hat 0.6 + rand * 0.2, false
  seq_sleep 0.25

  cued = flag (rand < 0.6 * ambiguity) {seq_snare 0 + rand * 0.2}
  seq_hat 0.2 + rand * 0.3, false
  seq_sleep 0.25

  downbeat = flag (rand < 0.8 * ambiguity) {seq_kick rand * 0.3 + (cued ? 0.4 : 0.6)}
  seq_hat 0.5 + rand * 0.2, false
  seq_sleep 0.25

  seq_snare (cued ? 0.4 : 0.1) + rand * 0.2 if downbeat and rand < 0.5 * ambiguity
  seq_hat 0.2 + rand * 0.3, false
  seq_sleep 0.25
end

def snare4 ambiguity=0
  seq_snare 0.8 + rand * 0.2
  seq_hat 0.5 + rand * 0.2, false
  seq_sleep 0.25
  postkicked = flag (rand < 0.3) {seq_kick (0.2 + rand * 0.2) * ambiguity}
  seq_hat 0.3 + rand * 0.2, false
  seq_sleep 0.25
  reflected = flag (rand < 0.4 * ambiguity and not postkicked) {seq_kick 0.3 + rand * 0.25}
  seq_hat 0.4 + rand * 0.3, false
  seq_sleep 0.25
  seq_snare 0.3 + rand * 0.3 if rand < (reflected ? 0.7 : 0.3) - ambiguity / 4
  seq_hat 0.2 + rand * 0.4, false
  seq_sleep 0.25
end

def kick3 ambiguity=0
  seq_kick 0.8 + rand*2
  opened = rand < 0.7
  seq_hat (opened ? 0.6 : 0.2) + rand * 0.3, rand < 0.7
  seq_sleep 0.25

  ghosted = flag (rand < 0.6) {seq_snare 0.1 + rand * 0.2}
  seq_hat 0.3 + rand * 0.2, false
  seq_sleep 0.25

  seq_kick (ghosted ? 0.1 : 0.2) + rand * 0.1 if rand < (ghosted ? 0.3 : 0.5)
  seq_hat 0.5 + rand * 0.2, false
  seq_sleep 0.25
end

def kick3sync ambiguity=0
  seq_kick 0.8 + rand*2
  seq_hat 0.3 + rand * 0.2, false
  seq_sleep 0.25

  ghosted = flag (rand < 0.3) {seq_snare 0.1 + rand * 0.3}
  seq_hat 0.5 + rand * 0.2, false
  seq_sleep 0.25

  seq_snare (ghosted ? 0.1 : 0.3) + rand * 0.2 if rand < (ghosted ? 0.3 : 0.5)
  seq_hat 0.2 + rand * 0.3, false
  seq_sleep 0.25
end

def snare3 ambiguity=0
  seq_snare 0.8 + rand * 0.2
  seq_hat 0.5 + rand * 0.2, false
  seq_sleep 0.25
  reflected = flag (rand < 0.4) {seq_kick 0.3 + rand * 0.25}
  seq_hat 0.2 + rand * 0.3, false
  seq_sleep 0.25
  seq_snare 0.3 + rand * 0.3 if rand < (reflected ? 0.7 : 0.3)
  seq_hat 0.4 + rand * 0.3, false
  seq_sleep 0.25
end

def snare3sync ambiguity=0
  seq_snare 0.8 + rand * 0.2
  seq_hat 0.1 + rand * 0.4, false
  seq_sleep 0.25
  reflected = flag (rand < 0.6) {seq_kick 0.3 + rand * 0.25}
  seq_hat 0.6 + rand * 0.2, false
  seq_sleep 0.25
  seq_snare 0.3 + rand * 0.3 if rand < (reflected ? 0.2 : 0.3)
  seq_hat 0.2 + rand * 0.3, false
  seq_sleep 0.25
end

def kick2 ambiguity=0
  seq_kick 0.7 + rand * 0.3
  seq_hat 0.6 + rand * 0.2, false
  seq_sleep 0.25
  seq_hat 0.1 + rand * 0.4, false
  seq_sleep 0.25
end

def any3 ambiguity=0
  if rand < 0.5 then return kick3, ambiguity else return snare3, ambiguity end
end

def any3sync ambiguity=0
  if rand < 0.5 then return kick3sync, ambiguity else return snare3sync, ambiguity end
end
