class OrderModel {
  String? order;
  String? date;
  String? delivered;
  String? status;
  String? reorder;

  OrderModel({required this.order, required this.date, required this.delivered, required this.status, required this.reorder});
}

List<OrderModel> orderData = [
  OrderModel(order: "2598", date: "18/06/25", delivered: "Delivered", status: "New", reorder: ""),
  OrderModel(order: "2598", date: "18/06/25", delivered: "", status: "New", reorder: ""),
  OrderModel(order: "2598", date: "18/06/25", delivered: "", status: "New", reorder: ""),
  OrderModel(order: "2598", date: "18/06/25", delivered: "", status: "New", reorder: ""),
];
