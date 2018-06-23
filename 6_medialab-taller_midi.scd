MIDIClient.init;
MIDIIn.connectAll;

MIDIFunc.trace(true); // log

(
SynthDef(
	\sine, {
		|freq 442, amp 1|
		var sign, env;
		sign = SinOsc.ar(freq) * amp;
		env = EnvGen.kr(Env.perc, doneAction: 2);
		Out.ar(0, sign * env);
	}
).add
)

x = Synth(\sine);


(
MIDIdef.noteOn(
	\ataqueNota,
	{
		|vel, num, ch|
		[vel, num, ch].postln;
		Synth(\sine, [
			\freq, (num + 12).midicps
			\amp, vel.linlin(,
				0, 127,
				0.0, 1.0,
			)
		])
	},
	//srcID: 1310720,
)
)