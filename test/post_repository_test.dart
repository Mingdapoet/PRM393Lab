import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:untitled/data/models/post.dart';
import 'package:untitled/data/repositories/post_repository.dart';

/// Tạo repository chạy trên client giả, ghi lại request cuối cùng.
({PostRepository repo, List<http.Request> sent}) makeRepo(
  http.Response Function(http.Request request) handler,
) {
  final sent = <http.Request>[];
  final client = MockClient((request) async {
    sent.add(request);
    return handler(request);
  });
  return (repo: PostRepository(client), sent: sent);
}

http.Response jsonResponse(Object body, [int status = 200]) => http.Response(
  jsonEncode(body),
  status,
  headers: {"content-type": "application/json; charset=utf-8"},
);

void main() {
  group('Post', () {
    test('toJson bỏ trường id khi bài chưa có id', () {
      const post = Post(userId: 1, title: 'A', body: 'B');

      expect(post.toJson().containsKey('id'), isFalse);
      expect(post.copyWith(id: 5).toJson()['id'], 5);
    });

    test('fromJson chịu được thiếu trường', () {
      final post = Post.fromJson({'id': 3});

      expect(post.id, 3);
      expect(post.title, '');
    });
  });

  group('PostRepository', () {
    test('getPosts đọc danh sách bài viết', () async {
      final r = makeRepo((_) => jsonResponse([
        {'id': 1, 'userId': 1, 'title': 'Một', 'body': 'x'},
        {'id': 2, 'userId': 1, 'title': 'Hai', 'body': 'y'},
      ]));

      final posts = await r.repo.getPosts();

      expect(posts.length, 2);
      expect(posts.last.title, 'Hai');
      expect(r.sent.single.method, 'GET');
      expect(r.sent.single.url.path, '/posts');
    });

    test('createPost gửi POST và nhận lại id do server cấp', () async {
      final r = makeRepo(
        (req) => jsonResponse({...jsonDecode(req.body), 'id': 101}, 201),
      );

      final created = await r.repo.createPost(
        const Post(userId: 1, title: 'Tiêu đề', body: 'Nội dung'),
      );

      expect(created.id, 101);
      expect(created.title, 'Tiêu đề');
      expect(r.sent.single.method, 'POST');
      expect(r.sent.single.url.path, '/posts');
      expect(jsonDecode(r.sent.single.body).containsKey('id'), isFalse);
    });

    test('updatePost gửi PUT tới /posts/{id}', () async {
      final r = makeRepo((req) => jsonResponse(jsonDecode(req.body)));

      final updated = await r.repo.updatePost(
        const Post(id: 7, userId: 1, title: 'Mới', body: 'Sửa'),
      );

      expect(updated.title, 'Mới');
      expect(r.sent.single.method, 'PUT');
      expect(r.sent.single.url.path, '/posts/7');
    });

    test('updatePost ném lỗi khi bài chưa có id, không gọi mạng', () async {
      final r = makeRepo((_) => jsonResponse({}));

      expect(
        () => r.repo.updatePost(const Post(userId: 1, title: 'A', body: 'B')),
        throwsArgumentError,
      );
      expect(r.sent, isEmpty);
    });

    test('deletePost gửi DELETE tới /posts/{id}', () async {
      final r = makeRepo((_) => jsonResponse({}));

      await r.repo.deletePost(4);

      expect(r.sent.single.method, 'DELETE');
      expect(r.sent.single.url.path, '/posts/4');
    });

    test('Server trả 404 thì ném ApiException kèm mã lỗi', () async {
      final r = makeRepo((_) => jsonResponse({}, 404));

      await expectLater(
        r.repo.deletePost(999),
        throwsA(
          isA<ApiException>().having((e) => e.statusCode, 'statusCode', 404),
        ),
      );
    });

    test('Mất mạng thì ném ApiException', () async {
      final repo = PostRepository(
        MockClient((_) async => throw http.ClientException('offline')),
      );

      await expectLater(repo.getPosts(), throwsA(isA<ApiException>()));
    });
  });
}
