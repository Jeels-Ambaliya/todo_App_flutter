class TodoConvertor {
  String Time;
  String Todo;

  TodoConvertor({
    required this.Time,
    required this.Todo,
  });

  factory TodoConvertor.fromMap({required Map data}) {
    return TodoConvertor(Time: data['Time'], Todo: data['Todo']);
  }
}
