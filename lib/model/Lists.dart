class Lists {
  static List<String> genres = [];
  static List<String> actors = [];
  static List<ActorList> actorsWithAids = [];
  static List<String> directors = [];
  static List<DirectorList> directorWithDids = [];
}

class ActorList {
  final name;
  final id;
  ActorList(this.name, this.id);
}

class DirectorList {
  final name;
  final id;
  DirectorList(this.name, this.id);
}
