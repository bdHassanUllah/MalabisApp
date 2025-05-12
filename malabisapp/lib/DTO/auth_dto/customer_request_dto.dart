// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:malabis_app/DTO/auth_dto/customer_repository.dart';
// import 'package:malabis_app/DTO/model/auth_dto_model.dart';
// import 'customer_state.dart';

// class CustomerCubit extends Cubit<CustomerState> {
//   final CustomerRepository repository;

//   CustomerCubit({required this.repository}) : super(CustomerInitial());

//   Future<void> createCustomer(CreateCustomerRequestDto dto) async {
//   emit(CustomerCreating());
//   try {
//     final response = await repository.createCustomer(dto);
//     emit(CustomerCreated(response.data));
//   } catch (e) {
//     final errorMsg = e.toString().contains('Customer already exists')
//         ? 'Customer already exists'
//         : 'Failed to create customer';
//     print(errorMsg);
//     emit(CustomerError(errorMsg));
//   }
// }

// }

