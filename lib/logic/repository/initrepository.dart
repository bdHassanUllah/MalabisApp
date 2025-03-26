import 'package:malabis_app/logic/providers/init_provider.dart';

class InitRepository {
  final provider = InitProvider();

  // initProvider() {
  //   provider = InitProvider();
  // }

  get getClient => provider.client;
}
