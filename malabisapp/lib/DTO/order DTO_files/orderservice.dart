// import 'package:dio/dio.dart';
// import 'package:malabis_app/DTO/order%20DTO_files/order_request_dto.dart';

// class OrderService {
//   final Dio dio;

//   OrderService(this.dio);

//   Future<Response> createOrder(CreateOrderRequestDto order) async {
//     try {
//       final response = await dio.post(
//         '/wp-json/wc/v3/orders',
//         data: order.toJson(),
//         // no need to re-set headers if already set in Dio client
//       );

//       return response;
//     } catch (e) {
//       print("Order creation failed: $e");
//       rethrow;
//     }
//   }
// }
