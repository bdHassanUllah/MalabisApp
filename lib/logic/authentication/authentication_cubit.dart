import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/DTO/auth_dto/customer_service_dto.dart';
import 'package:malabis_app/DTO/auth_dto/dio_client_helper.dart';
import 'package:malabis_app/DTO/model/auth_dto_model.dart';
import 'package:malabis_app/data/repository/authentication_repository.dart';
import 'package:malabis_app/logic/authentication/authentication_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  // Check if user is authenticated with Firebase and optionally WooCommerce
  Future<void> checkUserAuthentication() async {
    emit(AuthLoading());
    try {
      final User? user = await authRepository.getCurrentUser();
      if (user != null) {
        // 🔄 Optional: You may want to fetch WooCommerce ID from server if already exists
        emit(AuthAuthenticated(null, user)); // No Woo ID known yet
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError("Error checking user authentication: ${e.toString()}"));
    }
  }

  // Google Sign-in
  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final User? user = await authRepository.signInWithGoogle();
      if (user != null) {
        // ✅ Create WooCommerce customer and get their ID
        final int? wooCustomerId = await _createWooCommerceCustomer(user);
        if (wooCustomerId != null) {
          emit(AuthAuthenticated(wooCustomerId, user)); // ✅ Use WooCommerce ID
        } else {
          emit(AuthError("Failed to create WooCommerce customer"));
        }
      } else {
        emit(AuthError("Google sign-in failed"));
      }
    } catch (e) {
      emit(AuthError("Google sign-in error: ${e.toString()}"));
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // ✅ Return WooCommerce Customer ID
  int? getUserId() {
    if (state is AuthAuthenticated) {
      return (state as AuthAuthenticated).userId;
    }
    return null;
  }

  // ✅ Create WooCommerce Customer and return their ID
  // Future<int?> _createWooCommerceCustomer(User user) async {
  //   try {
  //     final dio = getWooCommerceDioClient(
  //       baseUrl: "https://malabis.pk", 
  //       consumerKey: 'ck_ed96ae2337106d3d2ebdb76c6b2649f276020e59', 
  //       consumerSecret: 'cs_7e884138b2555a93783d20ca78e7aa78bb4f66f4',
  //     );

  //     final customerDto = CreateCustomerRequestDto(
  //       email: user.email ?? '',
  //       firstName: user.displayName?.split(' ').first ?? 'First',
  //       lastName: user.displayName?.split(' ').last ?? 'Last',
  //       username: user.email?.split('@').first ?? 'user',
  //     );

  //     final customerService = CustomerService(dio: dio);
  //     final response = await customerService.createCustomer(customerDto);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final int customerId = response.data['id'];
  //       print('✅ WooCommerce Customer created: $customerId');
  //       return customerId;
  //     } else {
  //       print('⚠️ Unexpected response: ${response.data}');
  //       return null;
  //     }
  //   } on DioException catch (e) {
  //     if (e.response?.data is String && (e.response?.data as String).contains('expired')) {
  //       print('⚠️ Domain expired or invalid!');
  //     } else {
  //       print('❌ WooCommerce error: ${e.message}');
  //     }
  //     return null;
  //   } catch (e) {
  //     print('❌ Unexpected error: $e');
  //     return null;
  //   }
  // }

  Future<int?> _createWooCommerceCustomer(User user) async {
  try {
    final dio = getWooCommerceDioClient(
      baseUrl: "https://malabis.pk",
      consumerKey: 'ck_ed96ae2337106d3d2ebdb76c6b2649f276020e59',
      consumerSecret: 'cs_7e884138b2555a93783d20ca78e7aa78bb4f66f4',
    );

    final customerService = CustomerService(dio: dio);

    // 🟡 1. First check if the customer already exists
    final email = user.email ?? '';
    final response = await dio.get('/wp-json/wc/v3/customers', queryParameters: {
      'email': email,
    });

    if (response.statusCode == 200 && response.data is List && response.data.isNotEmpty) {
      final existingCustomer = response.data[0];
      final int customerId = existingCustomer['id'];
      print('🔁 Existing customer found: $customerId');
      return customerId;
    }

    // 🟢 2. If not found, create a new customer
    final customerDto = CreateCustomerRequestDto(
      email: email,
      firstName: user.displayName?.split(' ').first ?? 'First',
      lastName: user.displayName?.split(' ').last ?? 'Last',
      username: email.split('@').first,
    );

    final createResponse = await customerService.createCustomer(customerDto);

    if (createResponse.statusCode == 200 || createResponse.statusCode == 201) {
      final int customerId = createResponse.data['id'];
      print('✅ WooCommerce Customer created: $customerId');
      return customerId;
    } else {
      print('⚠️ Unexpected create response: ${createResponse.data}');
      return null;
    }
  } on DioException catch (e) {
    if (e.response?.data is String && (e.response?.data as String).contains('expired')) {
      print('⚠️ Domain expired or invalid!');
    } else {
      print('❌ WooCommerce error: ${e.message}');
    }
    return null;
  } catch (e) {
    print('❌ Unexpected error: $e');
    return null;
  }
}

}
