import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:untitled/data/models/person.dart';
import 'package:untitled/data/models/product.dart';
import 'package:untitled/data/models/student.dart';
import 'package:untitled/data/models/teacher.dart';
import 'package:untitled/ui/screens/home_page.dart';
import 'package:untitled/ui/widgets/product_widget.dart';

void main() {
  testWidgets('HomePage hiển thị AppBar và thông tin sản phẩm', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.text('Home page'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);

    // Hai sản phẩm, mỗi cái một nút thêm giỏ hàng.
    expect(find.byType(ProductWidget), findsNWidgets(2));
    expect(find.text('Thêm vào giỏ hàng'), findsNWidgets(2));

    expect(find.text('Golden Retriever'), findsOneWidget);
    expect(find.text('960\$'), findsOneWidget);

    expect(find.text('Siberian Husky'), findsOneWidget);
    expect(find.text('1500\$'), findsOneWidget);

    // '1200$' xuất hiện 2 lần: giá gốc của Golden và giá sau giảm của Husky.
    expect(find.text('1200\$'), findsNWidgets(2));
  });

  testWidgets('Ảnh giữ đúng kích thước 300x200', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    final box = tester.widget<SizedBox>(
      find
          .descendant(
            of: find.byType(ProductWidget).first,
            matching: find.byType(SizedBox),
          )
          .first,
    );

    expect(box.width, 300);
    expect(box.height, 200);
  });

  testWidgets('Bấm nút hiện SnackBar xác nhận', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    await tester.tap(find.text('Thêm vào giỏ hàng').first);
    await tester.pump();

    expect(
      find.text('Đã thêm Golden Retriever vào giỏ hàng'),
      findsOneWidget,
    );
  });

  testWidgets('Layout không tràn khi cửa sổ hẹp', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(420, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();

    // Thông tin vẫn còn, không bị RenderFlex overflow.
    expect(tester.takeException(), isNull);
    expect(find.text('Golden Retriever'), findsOneWidget);
    expect(find.text('Thêm vào giỏ hàng'), findsWidgets);
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
