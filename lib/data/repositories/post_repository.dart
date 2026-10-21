import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:untitled/data/models/post.dart';

part 'post_repository.g.dart';

/// Lỗi khi gọi API: server trả mã khác 2xx hoặc không kết nối được.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => statusCode == null
      ? "ApiException: $message"
      : "ApiException($statusCode): $message";
}

@Riverpod(keepAlive: true)
http.Client httpClient(Ref ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
}

@Riverpod(keepAlive: true)
PostRepository postRepository(Ref ref) {
  return PostRepository(ref.watch(httpClientProvider));
}

/// Gọi REST API bài viết: GET / POST / PUT / DELETE.
class PostRepository {
  static const _baseUrl = "https://jsonplaceholder.typicode.com";
  static const _jsonHeaders = {"Content-Type": "application/json; charset=UTF-8"};

  final http.Client _client;

  PostRepository(this._client);

  Uri _uri([int? id]) => Uri.parse(id == null ? "$_baseUrl/posts" : "$_baseUrl/posts/$id");

  /// Lấy toàn bộ bài viết.
  Future<List<Post>> getPosts() async {
    final json = await _send(() => _client.get(_uri())) as List<dynamic>;
    return json
        .map((item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Post> getPost(int id) async {
    final json = await _send(() => _client.get(_uri(id)));
    return Post.fromJson(json as Map<String, dynamic>);
  }

  /// POST: tạo bài mới. Trả về bài kèm id do server cấp.
  Future<Post> createPost(Post post) async {
    final json = await _send(
      () => _client.post(
        _uri(),
        headers: _jsonHeaders,
        body: jsonEncode(post.toJson()),
      ),
    );
    return Post.fromJson(json as Map<String, dynamic>);
  }

  /// PUT: thay toàn bộ bài viết đã có. Bài phải có id.
  Future<Post> updatePost(Post post) async {
    final id = post.id;
    if (id == null) {
      throw ArgumentError("Bài viết chưa có id nên không cập nhật được.");
    }

    final json = await _send(
      () => _client.put(
        _uri(id),
        headers: _jsonHeaders,
        body: jsonEncode(post.toJson()),
      ),
    );
    return Post.fromJson(json as Map<String, dynamic>);
  }

  /// DELETE: xoá bài theo id.
  Future<void> deletePost(int id) async {
    await _send(() => _client.delete(_uri(id)));
  }

  /// Gửi request, kiểm tra mã trả về và giải mã JSON.
  /// Mọi lỗi mạng hay mã khác 2xx đều đổi thành [ApiException].
  Future<dynamic> _send(Future<http.Response> Function() request) async {
    final http.Response response;
    try {
      response = await request().timeout(const Duration(seconds: 15));
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException("Không kết nối được máy chủ: $e");
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        "Máy chủ trả lỗi.",
        statusCode: response.statusCode,
      );
    }
    if (response.body.isEmpty) return null;

    // bodyBytes + utf8 để tiếng Việt không bị lỗi font.
    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}
