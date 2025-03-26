import 'package:graphql_flutter/graphql_flutter.dart';

class InitProvider {

  get client => _client;
  static final HttpLink httpLink = HttpLink("https://i4l7uysebe.execute-api.us-east-1.amazonaws.com/dev/graphql");
  final GraphQLClient _client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(
      store: InMemoryStore(),
    ),
  );

}
