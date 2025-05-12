
import 'package:malabis_app/data/providers/navigation_provider.dart';

class NavigationRepository {
  final NavigationProvider provider;

  NavigationRepository(this.provider);

  int getInitialIndex() => provider.defaultIndex();
}
