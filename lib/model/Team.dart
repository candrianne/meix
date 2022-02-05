class Team {
  String name;
  int nbMatchsPlayed;
  int wins;
  int losses;
  int draws;
  int points;

  Team(this.name, this.nbMatchsPlayed, this.wins, this.losses, this.draws,
      this.points);

  factory Team.fromJson(dynamic json) {
    return Team(
      json['team_name'] as String,
      json['played'] as int,
      json['wins'] as int,
      json['losses'] as int,
      json['draws'] as int,
      json['points'] as int,
    );
  }
}
