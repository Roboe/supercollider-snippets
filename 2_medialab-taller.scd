// 2018-06-22
// Impartido por Santiago Rapallo


// Variable de nombre largo (con signo de la virgulilla al principio ~)
// Instancia de un bus de control
~lfoBus = Bus.control


// Definición de sintetizador con la entrada de micrófono (SoundIn)
// Salida estéreo ([0, 1])
(
SynthDef(
	\soundIn,
	{
		arg amp = 0.2;
		var sign;
		sign = SoundIn.ar(0);
		Out.ar(
			[0, 1],
			sign*amp,
		);
	}
).add
)

// Nueva instancia
~virgulilla = Synth(\soundIn)

// Cambio de argumentos
// set() pone valor estático
// map() mapea el valor constantemente
~virgulilla.set(\amp, 0.05)
~virgulilla.map(\amp, ~lfoBus)


// Definición de sintetizador de onda cuadrada (LFPulse)
(
SynthDef(\lfo, {
	arg freq = 2, bus;
	var sign;
	sign = LFPulse.kr(freq);
	Out.kr(bus, sign)
}).add
)

// Instancia cambiando argumentos
~lfoPulse = Synth(\lfo, [\freq, 8, \bus, ~lfoBus])

// Sobrescritura de argumento
~lfoPulse.set(\freq, 16)
