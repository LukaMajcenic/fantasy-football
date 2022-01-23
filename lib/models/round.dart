class Round
{
  String roundId;
  String shortName;
  String longName;
  bool played;

  Round({
    required this.roundId, 
    required this.shortName, 
    required this.longName,
    required this.played
  });

  Map<String, Object> toJson()
  {
    return {
      "shortName": shortName,
      "longName": longName,
      "played": played
    };
  }

  static Round fromJson(String roundId, dynamic json)
  {
    return Round(
      roundId: roundId, 
      shortName: json['shortName'], 
      longName: json['longName'], 
      played: json['played']
    );
  }
}