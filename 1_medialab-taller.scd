// 2018-06-22
// Impartido por Santiago Rapallo


// Ruido marrón por las dos salidas de audio (!2)
// Controla la amplitud con el eje vertical del ratón (señal * MouseY)
{ BrownNoise.ar * MouseY.kr(0, 0.5) !2 }.play;


// # Teremín ratonero
// Blip por las dos salidas de audio ([left, right])
// Control de la frecuencia con el eje horizontal del ratón
({
	Blip.ar(
		[
			MouseX.kr(62.midicps, 86.midicps),
			MouseX.kr(45.midicps, 73.midicps),
		],
		200,
		MouseY.kr(0, 0.6),
		0,
	);
}.play);


// Definición del teremín como sintetizador
// Instancia en una variable "x" y liberación
(
SynthDef.new(
	\ratonil,
	{
		var sign;
		sign = Blip.ar(
			[
				MouseX.kr(62.midicps, 86.midicps),
				MouseX.kr(45.midicps, 73.midicps),
			],
			200,
			MouseY.kr(0,0.6),
			0,
		);
	Out.ar(0, sign);
	}
).add
)

x = Synth(\ratonil);
x.free
