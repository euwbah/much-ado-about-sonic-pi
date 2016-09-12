# Untitled
*weird spacey music*
### 2/9/2016 (Work In Progress)

______________

*So...* I've stumbled upon the world of microtonal music.

> BE WARNED: Extreme Geekery Ahead

For the past 100 or so years, we've all been using this type of tuning called 12-TET (12-tone equal temperament) / 12 EDO (equal divisions of the octave), where each octave is divided into 12 notes.

This is vastly different from how people like Chopin, Mozart, Beethoven, and other classical composers *actually* heard music during, and before, the romantic era (18th century).

It all goes back to how the human brain perceives consonances and dissonances: Music - simplified to its essense - is all about that continuous, hair-raising battle between consonances and dissonances, whatever they may be defined as.

The rules are simple: If the ratio of the frequencies of the chord is simple, it is consonance. If it is a complex ratio, then it is heard as dissonance. This solid, tangible, simplicity/complexity of the ratios can be intuitively heard because simple ratios have a very fast 'beating rate'. The beating rate is the rate of which two or more waveforms will all be at the same amplitude at the same time; or, in more technically correct terms, when the displacements of the fluctuating particles about their average resting position, will become equivalent for two or more sound waves, for an infinitesimally short period of time.

Let's take the perfect fifth for example (for those who are already into microtonal / xenharmonic stuff, I'm refererring to the pure Pythagorean fifth here). It has a frequency ratio of 3 / 2. Which means, if the lower note is an A in the 4th octave (440Hz), then the higher one will be 1.5 * 440Hz, which is 660Hz (E5). The beating rate is the rate of which the two waves will 'intersect', which can be simply calculated as the greatest common divisor betweeen the two frequencies. In this case, that rate is 220Hz. Sometimes, if you crank up the distortion gain high enough, you may even hear this ghost frequency, but usually, this 220Hz A3 won't be audible, because it is part of the otonal and utonal harmonic partials (which makes up the characteristics of the sound itself).

However, most humans won't be able to hear distinctive pitches anymore when the frequency of a note is less than 16-20Hz. Instead, the "notes" will be perceived as just vibrations, since that's what 'sound' really is. Now, **this** is when the dissonance can really be heard. The sound when two flutes are unforgivingly out of tune, or the sound of a minor second (or even a microtonal diminished second, which is different than a 'diminished second' in standard music theory) -- they all have this 'phasing' sound in common. That is the sound of the two pitches very close in frequency, but actually, very far apart in the circle of consonances and disonnances (aka, the ubiquitous, overly said, underwhelmingly used Pythagorean circle of fifths). This is when the GCD is really a pathetically low frequency that you can even hear it affecting the sound from the meta scope and not the sound per se.

*Sooooooo....* back to the topic on microtonality, there are two kinds:
1. The one which questions the need for 12 and only 12 notes in an octave
2. The one which only cares about the ratios between two notes, and disregards everything else, including standard tuning, the need for octaves at all, or perhaps even the need of a standard scale.

The former is called 'xenharmonic' music. This is where people try to divide the octave by dividing it up from 5-TET, to 313-TET and everything in between.

But, the type of microtonality that this, so far, untitled piece, is the latter kind. I wouldn't say this is the most exotic type of microtonality, but it is definitely not possible to play on any standard fixed-pitched instrument, even after re-mapping keys on a MIDI controller to fit it.

This is due to the fact that if there are already so many different ratios (to be accurate, an infinite amount of them) to choose from, and yet everytime a new chord / key is used, the specific notes will all have to change their tuning with regards to that new root note, wouldn't it be indeed hard to actually play anything at all?

Well, before the 18th century, this was the type of tuning used. Well, they still had the octaves, and all the major and minor thirds, but the main issue was that the tunings were only valid in one key. That means everytime you wanted to play in a different key, you had to have your harpsichord, pianoforte, organ, lute or whatever other instrument there was, retuned.

Of course, they didn't do that. So this restricted key modulation a lot (Which kind of explains why during the earlier periods of classical music (baroque, classical), there really wasn't any key modulation any further than two steps on the circle of fifths (id est, a major second up or down)).

But now we have equal temperament. This meant that unless you have perfect pitch or a vocalist, all keys will sound and feel the same to you, respectively. So now we can modulate to any damn key we want, and start and end in any key. Well... this explains Jazz flourishing in the 19th century a *lot*.

But there's a down side to tuning everything in 12 TET. Because now the logarithmic differences of frequencies between notes are now all the same, the characteristics of 'consonance' disappears. This is due to the way 12 TET is constructed:
- Instead of having simple ratios to define what is 'consonance', 12-TET used octaves, the supposedly most consonant interval there is, and divided it into 12 parts
- This means that now all the notes are irrational in relation to each other, because the 12th root of anything is without a doubt irrational, except for exponents of 12 themselves (aka octaves)

This makes the very nice and pure sounding major third, which used to be a nice 5/4 ratio, now a 2^(4/12) : 1 (1.259921...), which is only ever so slightly sharp, although this difference of about 6 cents makes a whole world of difference. The 'phasing' in a C major triad of 12-TET is definitely noticeable, especially when one pays attention to the higher registers of the upper partials of the overtone series.

**Anyways....**, so here we are: In between two vastly different worlds, where in one you have pure consonances and appropriately-tensioned dissonances in a handful of keys, and everything else is really shit, and in the other, you could modulate to any key, but all keys sound equally as shitty (but not as shitty as the non-ET) as the next.

This is where `Sonic Pi` comes in. Since this isn't a piano or some physical instrument that needs retuning, all one needs to do is just set the root note, and you're off. Every chord can have a different root note, which technically gives you full control over how consonant the chord is, just by adjusting the ratios manually.

So this is what this piece is all about, just another weird experiement of microtonality, to see if a new dimension of consonance and dissonance can be found, and perhaps to find the equivalent of a 'two-five-one' with tunings alone.
