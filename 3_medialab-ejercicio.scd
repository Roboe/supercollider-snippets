// 2018-06-22
// Impartido por Santiago Rapallo


// Definición de sintetizador con la entrada del micrófono
// Paneo de estéreo con el UGen Pan2
(
SynthDef(
	\soundInPan,
	{
		arg amp = 0.2, pos;
		var sign;
		sign = SoundIn.ar(0);
		sign = Pan2.ar(sign, pos);
		Out.ar(0, sign * amp);
	},
).add
)


// EJERCICIO: hacer una definición de sinte que sea un LFNoise0 de control con salida al bus que sirve de entrada al UGen de paneo del sinte

(
SynthDef(
	\lfNoise0,
	{
		arg freq = 1, bus;
		var sign;
		sign = LFNoise0.kr(freq);
		Out.kr(bus, sign);
	},
).add
)


~soundInPan = Synth(\soundInPan);
~lfoBusPan = Bus.control;
~lfNoise = Synth(\lfNoise0, [\bus, ~lfoBusPan]);

~soundInPan.map(\pos, ~lfoBusPan);
