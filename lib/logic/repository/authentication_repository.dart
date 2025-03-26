import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:malabis_app/logic/providers/authentication_provider.dart';

class AuthRepository {
  final provider = AuthProvider();

  Future<QueryResult> regitserPhone(Map<String, dynamic> variables) async {
    final result = provider.registerPhone(variables: variables);
    return result;
  }

  Future<QueryResult> verifyOtp(Map<String, dynamic> variables) async {
    final result = provider.verifyOtp(variables);
    return result;
  }

  Future<QueryResult> updateProfile(
      {required Map<String, dynamic> variables}) async {
    final result = provider.updateProfile(variables: variables);
    return result;
  }
  Future<QueryResult> createProfile(
      {required Map<String, dynamic> variables}) async {
    final result = provider.createProfile(variables: variables);
    return result;
  }

  Future<QueryResult> getFaq() async {
    final result = provider.getFaq();
    return result;
  }
}
