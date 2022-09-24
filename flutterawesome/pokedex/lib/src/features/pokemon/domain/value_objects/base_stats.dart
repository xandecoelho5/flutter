abstract class BaseStatsDef {
  final String name;
  final int value;
  final int maxValue;

  BaseStatsDef(this.name, this.value) : maxValue = (2 * value + 10) + 5;

  BaseStatsDef.withMaxValue(this.name, this.value, this.maxValue);
}

class BaseStats {
  final Hp hp;
  final Attack attack;
  final Defense defense;
  final SpecialAttack specialAttack;
  final SpecialDefense specialDefense;
  final Speed speed;
  final AveragePower averagePower;

  BaseStats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  }) : averagePower = AveragePower(
          (hp.value +
                  attack.value +
                  defense.value +
                  specialAttack.value +
                  specialDefense.value +
                  speed.value) ~/
              6,
        );
}

class Hp extends BaseStatsDef {
  Hp(int value)
      : super.withMaxValue('Hp', value, ((2 * value + 10) + 110).toInt());
}

class Attack extends BaseStatsDef {
  Attack(int value) : super('Attack', value);
}

class Defense extends BaseStatsDef {
  Defense(int value) : super('Defense', value);
}

class SpecialAttack extends BaseStatsDef {
  SpecialAttack(int value) : super('Special Attack', value);
}

class SpecialDefense extends BaseStatsDef {
  SpecialDefense(int value) : super('Special Defense', value);
}

class Speed extends BaseStatsDef {
  Speed(int value) : super('Speed', value);
}

class AveragePower extends BaseStatsDef {
  AveragePower(int value) : super('Avg. Power', value);
}
