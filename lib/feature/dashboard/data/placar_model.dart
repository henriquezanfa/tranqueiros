class PlacarModel {
  PlacarModel({
    this.time1,
    this.time2,
    this.pontuacaoTime1,
    this.pontuacaoTime2,
  });

  TimeModel? time1;
  TimeModel? time2;
  int? pontuacaoTime1;
  int? pontuacaoTime2;
}

class TimeModel {
  TimeModel({
    required this.nome1,
    required this.nome2,
  });
  String nome1;
  String nome2;
}
