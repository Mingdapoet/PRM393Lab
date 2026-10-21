/// Một bài viết (dữ liệu từ JSONPlaceholder).
class Post {
  /// null khi bài chưa được tạo trên server.
  final int? id;
  final int userId;
  final String title;
  final String body;

  const Post({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  Post copyWith({int? id, int? userId, String? title, String? body}) => Post(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    body: body ?? this.body,
  );

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"] as int?,
    userId: json["userId"] as int? ?? 0,
    title: json["title"] as String? ?? "",
    body: json["body"] as String? ?? "",
  );

  /// Bài chưa có id (đang tạo mới) thì không gửi trường id lên server.
  Map<String, dynamic> toJson() => {
    if (id != null) "id": id,
    "userId": userId,
    "title": title,
    "body": body,
  };
}
