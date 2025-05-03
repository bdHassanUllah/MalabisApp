import 'package:malabis_app/DTO/auth_dto/customer_service_dto.dart';
import 'package:malabis_app/DTO/model/auth_dto_model.dart';
import 'package:dio/dio.dart';

class CustomerRepository {
  final CustomerService service;

  CustomerRepository({required this.service});

  Future<Response> createCustomer(CreateCustomerRequestDto dto) async {
    try {
      return await service.createCustomer(dto);
    } catch (e) {
      rethrow; // or handle the error appropriately
    }
  }
}
