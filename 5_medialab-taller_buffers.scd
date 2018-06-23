b = Buffer.alloc(s, 48000);

(
SynthDef(
	\rec,
	{
		arg mic = 0, bufnum, bucle = 0;
		var sign;
		sign = SoundIn.ar(mic);
		sign = RecordBuf.ar(sign, bufnum, loop: bucle, doneAction: 2);
	}
).add
)

x = Synth(\rec, [\bufnum, b]);
b.play


(
SynthDef(
	\play,
	{
		|pos, bufnum, rate 1, trigger 1, startPos 0, loop 0, doneAction 2|
		var sign;
		sign = PlayBuf.ar(1, bufnum, rate, trigger, startPos, loop, doneAction);
		sign = Pan2.ar(sign, pos);
		Out.ar(0, sign);
	}

).add
)

(
y = Synth(
	\play,
	[
		\bufnum, b,
		\pos, 0.4,
		\rate, -2,
		\loop, 1,
	]
)
)
y.set(\rate, rrand(-1.0, 2.0))


(
~sintes = Array.fill(
	4,
	{
		|i|
		Synth(
			\play,
			[
				\bufnum, b,
				\pos, rrand(-1.0, 1.0),
				\rate, rrand(-1.0, 2.0),
				\loop, 1,
			]
		)
	}
)
)

(
4.do(
	{
		|i|
		~sintes[i].set(\loop, 0)
	}
)
)