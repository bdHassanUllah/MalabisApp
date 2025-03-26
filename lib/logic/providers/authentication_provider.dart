import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:malabis_app/logic/providers/init_provider.dart';
import 'package:malabis_app/util/gql_mutations.dart';
import 'package:malabis_app/util/gql_queries.dart';


class AuthProvider {
  final initProvider = InitProvider();

  Future<QueryResult> registerPhone(
      {required Map<String, dynamic> variables}) async {
    MutationOptions options = MutationOptions(
        document: gql(GQLMutation.generateOTPQuery), variables: variables);
    final result = await initProvider.client.mutate(options);
    return result;
  }

  Future<QueryResult> verifyOtp(Map<String, dynamic> variables) async {
    MutationOptions options = MutationOptions(
        document: gql(GQLMutation.verifyOtpQuery), variables: variables);
    final result = await initProvider.client.mutate(options);
    return result;
  }

  Future<QueryResult> updateProfile(
      {required Map<String, dynamic> variables}) async {
    MutationOptions options = MutationOptions(
        document: gql(GQLMutation.updateProfileQuery), variables: variables);
    final result = await initProvider.client.mutate(options);
    return result;
  }
  
  Future<QueryResult> createProfile(
      {required Map<String, dynamic> variables}) async {
    MutationOptions options = MutationOptions(
        document: gql(GQLMutation.createProfileQuery), variables: variables);
    final result = await initProvider.client.mutate(options);
    return result;
  }

  Future<QueryResult> getFaq() async {
    QueryOptions options =
    QueryOptions(document: gql(GQLQuries.getFaq));

    final result = await initProvider.client.query(options);

    return result;
  }
  
}
