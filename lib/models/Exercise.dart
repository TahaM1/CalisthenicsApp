class Exercise {
  final String name, type;
  final double date; // unix time
  final List<num> reps, time, distance, weight;

  Exercise(
      {this.name,
      this.type,
      this.time,
      this.date,
      this.weight,
      this.reps,
      this.distance});
}
