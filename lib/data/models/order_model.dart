import 'package:cloud_firestore/cloud_firestore.dart';

import 'order_item_model.dart';

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

class OrderModel {
  final String id;
  final String userId;
  List<OrderItemModel> items;
  double totalAmount;
  DateTime orderDate;
  OrderStatus status;
  String paymentMethod;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
    required this.paymentMethod,
  });

  /// Empty Helper Function
  static OrderModel empty() => OrderModel(
    id: '',
    userId: '',
    items: [],
    totalAmount: 0.0,
    orderDate: DateTime.now(),
    status: OrderStatus.pending,
    paymentMethod: '',
  );

  /// Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'orderDate': Timestamp.fromDate(orderDate),
      'status': status.name,
      'paymentMethod': paymentMethod,
    };
  }

  /// Create OrderModel from Firestore Document
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      id: snapshot.id,
      userId: data['userId'] ?? '',
      items:
          (data['items'] as List<dynamic>)
              .map((item) => OrderItemModel.fromJson(item))
              .toList(),
      totalAmount: (data['totalAmount'] as num).toDouble(),
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      status: OrderStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => OrderStatus.pending,
      ),
      paymentMethod: data['paymentMethod'] ?? '',
    );
  }

  /// Copy with method
  OrderModel copyWith({
    String? id,
    String? userId,
    List<OrderItemModel>? items,
    double? totalAmount,
    DateTime? orderDate,
    OrderStatus? status,
    String? paymentMethod,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? List.from(this.items),
      totalAmount: totalAmount ?? this.totalAmount,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
