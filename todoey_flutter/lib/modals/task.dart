class Task {
  Task({this.task, this.isDone = false});
  String task;
  bool isDone;
  void toggleState() {
    isDone = !isDone;
  }
}
