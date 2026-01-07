enum AudioPlayerSpeedEnum {
  x0_5('0.5x', 0.5),
  x0_75('0.75x', 0.75),
  x1('1x', 1),
  x1_25('1.25x', 1.25),
  x1_5('1.5x', 1.5),
  x1_75('1.75x', 1.75),
  x2('2x', 2);

  final String name;
  final double value;

  const AudioPlayerSpeedEnum(this.name, this.value);
}
