import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:untitled/data/models/person.dart';
import 'package:untitled/data/models/product.dart';
import 'package:untitled/data/models/student.dart';
import 'package:untitled/data/models/teacher.dart';
import 'package:untitled/main.dart';

void main() {
  testWidgets('HomePage hiển thị AppBar và thông tin sản phẩm', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Home page'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);

    expect(find.text('Name: Golden Retriever'), findsOneWidget);
    expect(find.text('Price: '), findsOneWidget);
    expect(find.text('1200\$'), findsOneWidget);
    expect(find.text(' 960\$'), findsOneWidget);
  });

  test('Product.copyTo chỉ thay đổi field được truyền vào', () {
    const p = Product(id: 1, name: 'iPhone 15', price: 1000);
    final copy = p.copyTo(name: 'iPhone 15 Pro', price: 1500);

    expect(copy.id, 1);
    expect(copy.name, 'iPhone 15 Pro');
    expect(copy.price, 1500);
  });

  test('Product chuyển đổi JSON hai chiều', () {
    const p = Product(
      id: 7,
      name: 'MacBook Air',
      price: 1100,
      image: 'assets/images/img.png',
      description: 'Laptop mỏng nhẹ',
    );

    final restored = Product.fromJson(p.toJson());

    expect(restored.id, p.id);
    expect(restored.name, p.name);
    expect(restored.price, p.price);
    expect(restored.image, p.image);
    expect(restored.description, p.description);
  });

  test('Person.create trả về Student khi personType là student', () {
    final person = Person.create(
      personType: PersonType.student,
      json: {'id': 'S01', 'name': 'Minh', 'math': 8.5, 'physic': 7},
    );

    expect(person, isA<Student>());
    expect(person.id, 'S01');

    final student = person as Student;
    expect(student.math, 8.5);
    expect(student.physic, 7.0);
    expect(student.chemistry, isNull);
  });

  test('Person.create trả về Teacher khi personType là teacher', () {
    final person = Person.create(
      personType: PersonType.teacher,
      json: {
        'id': 'T01',
        'name': 'Khang',
        'subjects': ['Toán', 'Lý'],
      },
    );

    expect(person, isA<Teacher>());

    final teacher = person as Teacher;
    expect(teacher.name, 'Khang');
    expect(teacher.subjects, ['Toán', 'Lý']);
  });

  test('Teacher.fromJson trả về list rỗng khi thiếu subjects', () {
    final teacher = Teacher.fromJson({'id': 'T02', 'name': 'Lan'});

    expect(teacher.subjects, isEmpty);
  });
}
