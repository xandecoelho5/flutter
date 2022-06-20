class Task {
  final String content;
  final DateTime timestamp;
  bool done;

  Task({
    required this.content,
    required this.timestamp,
    required this.done,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'timestamp': timestamp,
      'done': done,
    };
  }

  factory Task.fromMap(Map<dynamic, dynamic> map) {
    return Task(
      content: map['content'] as String,
      timestamp: map['timestamp'] as DateTime,
      done: map['done'] as bool,
    );
  }
}
