import 'package:hive/hive.dart';

part 'base_stats.g.dart';

abstract class BaseStatsDef {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int value;
  @HiveField(2)
  final int maxValue;

  BaseStatsDef(this.name, this.value) : maxValue = (2 * value + 10) + 5;

  BaseStatsDef.withMaxValue(this.name, this.value, this.maxValue);
}

@HiveType(typeId: 2)
class BaseStats {
  @HiveField(0)
  final Hp hp;
  @HiveField(1)
  final Attack attack;
  @HiveField(2)
  final Defense defense;
  @HiveField(3)
  final SpecialAttack specialAttack;
  @HiveField(4)
  final SpecialDefense specialDefense;
  @HiveField(5)
  final Speed speed;
  @HiveField(6)
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

@HiveType(typeId: 3)
class Hp extends BaseStatsDef {
  Hp(int value)
      : super.withMaxValue('Hp', value, ((2 * value + 10) + 110).toInt());
}

@HiveType(typeId: 4)
class Attack extends BaseStatsDef {
  Attack(int value) : super('Attack', value);
}

@HiveType(typeId: 5)
class Defense extends BaseStatsDef {
  Defense(int value) : super('Defense', value);
}

@HiveType(typeId: 6)
class SpecialAttack extends BaseStatsDef {
  SpecialAttack(int value) : super('Special Attack', value);
}

@HiveType(typeId: 7)
class SpecialDefense extends BaseStatsDef {
  SpecialDefense(int value) : super('Special Defense', value);
}

@HiveType(typeId: 8)
class Speed extends BaseStatsDef {
  Speed(int value) : super('Speed', value);
}

@HiveType(typeId: 9)
class AveragePower extends BaseStatsDef {
  AveragePower(int value) : super('Avg. Power', value);
}
