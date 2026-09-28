// Lab 4 - Exercise 3: Layout Basics (Column, Row, Padding, ListView.builder)
//
// Mục tiêu: dựng màn hình Home nhiều khu vực như app thật.
// Khoảng cách dùng thống nhất bội số của 4: 8, 12, 16 px.

import 'package:flutter/material.dart';

/// Một bộ phim trong danh sách.
class Movie {
  final String title;
  final String genre;
  final double rating;

  const Movie({
    required this.title,
    required this.genre,
    required this.rating,
  });
}

class LayoutBasicsDemo extends StatelessWidget {
  const LayoutBasicsDemo({super.key});

  static const _genres = ["Tất cả", "Sci-Fi", "Action", "Animation", "Drama"];

  static const _movies = [
    Movie(title: "Inception", genre: "Sci-Fi", rating: 8.8),
    Movie(title: "The Dark Knight", genre: "Action", rating: 9.0),
    Movie(title: "Interstellar", genre: "Sci-Fi", rating: 8.6),
    Movie(title: "Parasite", genre: "Thriller", rating: 8.5),
    Movie(title: "Spirited Away", genre: "Animation", rating: 8.6),
    Movie(title: "The Godfather", genre: "Crime", rating: 9.2),
    Movie(title: "Whiplash", genre: "Drama", rating: 8.5),
    Movie(title: "Your Name", genre: "Animation", rating: 8.4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ex3 - Layout Basics")),
      // Column chia màn hình thành các khu vực xếp dọc.
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Khu vực 1: tiêu đề ---
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              "Phim đang chiếu",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          // --- Khu vực 2: hàng thể loại, cuộn ngang ---
          // ListView ngang phải có chiều cao xác định, nếu không sẽ báo
          // 'Horizontal viewport was given unbounded height'.
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _genres.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(label: Text(_genres[index])),
              ),
            ),
          ),
          const SizedBox(height: 12),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Tất cả phim",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),

          // --- Khu vực 3: danh sách phim ---
          // Expanded cho ListView phần chiều cao còn lại. Thiếu Expanded
          // thì Column cho con chiều cao vô hạn -> ListView báo lỗi
          // 'Vertical viewport was given unbounded height' (xem Ex5).
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    // Row xếp ngang: số thứ tự | tên+thể loại | điểm.
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          child: Text("${index + 1}"),
                        ),
                        const SizedBox(width: 12),
                        // Expanded để phần chữ chiếm hết chỗ trống,
                        // tên phim dài cũng không tràn ra ngoài Row.
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                movie.genre,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text("${movie.rating}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
