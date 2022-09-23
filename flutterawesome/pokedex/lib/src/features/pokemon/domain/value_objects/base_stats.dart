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
                  speed.value) /
              6,
        );
}

class Hp extends BaseStatsDef {
  Hp(value) : super.withMaxValue('Hp', value, ((2 * value + 10) + 110) as int);
}

class Attack extends BaseStatsDef {
  Attack(value) : super('Attack', value);
}

class Defense extends BaseStatsDef {
  Defense(value) : super('Defense', value);
}

class SpecialAttack extends BaseStatsDef {
  SpecialAttack(value) : super('Special Attack', value);
}

class SpecialDefense extends BaseStatsDef {
  SpecialDefense(value) : super('Special Defense', value);
}

class Speed extends BaseStatsDef {
  Speed(value) : super('Speed', value);
}

class AveragePower extends BaseStatsDef {
  AveragePower(value) : super('Avg. Power', value);
}
