class Game {
  String serieName;
  String homeTeam;
  String awayTeam;
  int? homeScore;
  int? awayScore;
  String date;
  String time;
  String venue;
  String homeTeamImage;
  String awayTeamImage;

  Game(this.serieName, this.homeTeam, this.awayTeam, this.homeScore, this.awayScore, this.date, this.time,
      this.venue, this.homeTeamImage, this.awayTeamImage);

  factory Game.fromJson(dynamic json) {
    return Game(
      json['serie_short_name'] as String,
      json['home_team_name'] as String,
      json['away_team_name'] as String,
      json['home_score'] ?? 0,
      json['away_score'] ?? 0,
      json['date'] as String,
      json['time'] as String,
      json['venue_name'] as String,
      "https://gestion.lffs.eu/lms_league_ws/public/img/" + json['home_club_logo_img_url'],
      "https://gestion.lffs.eu/lms_league_ws/public/img/" + json['away_club_logo_img_url'],
    );
  }
}
