import 'package:malabis_app/DTO/OrderHistoryDTO/FetchOrders/fetchorder_provider.dart';
import 'package:malabis_app/data/model/order_model.dart';

class OrderFetchRepository {
  final OrderFetchProvider provider;

  OrderFetchRepository(this.provider);

  Future<int?> getWooCustomerIdByEmail(String email) {
    return provider.getWooCustomerIdByEmail(email);
  }

  Future<List<OrderModel>> getOrdersByCustomerId(int customerId) async {
    final response = await provider.getOrdersByCustomerId(customerId);
    return response.map<OrderModel>((json) => OrderModel.fromJson(json)).toList();
  }

  Future<OrderModel?> getOrderById(int orderId) async {
    final json = await provider.getOrderById(orderId);
    if (json != null) {
      return OrderModel.fromJson(json);
    }
    return null;
  }
}
