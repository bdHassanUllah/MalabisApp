import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malabis_app/DTO/OrderHistoryDTO/FetchOrders/fetchorder_cubit.dart';
import 'package:malabis_app/DTO/OrderHistoryDTO/FetchOrders/fetchorder_provider.dart';
import 'package:malabis_app/DTO/OrderHistoryDTO/FetchOrders/fetchorder_repository.dart';
import 'package:malabis_app/apifiles/api.dart';
import 'package:malabis_app/data/providers/navigation_provider.dart';
import 'package:malabis_app/data/providers/orders_provider.dart';
import 'package:malabis_app/data/repository/authentication_repository.dart';
import 'package:malabis_app/data/repository/home_repository.dart';
import 'package:malabis_app/data/repository/navigation_provider.dart';
import 'package:malabis_app/data/repository/order_repository.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import 'package:malabis_app/logic/authentication/authentication_state.dart';
import 'package:malabis_app/logic/cart/cart_cubit.dart';
import 'package:malabis_app/logic/home/home_cubit.dart';
import 'package:malabis_app/logic/order/orders_cubit.dart';
import 'package:malabis_app/logic/whishlist/whishlistcubit.dart';
import 'package:malabis_app/routes/custom_routes.dart';
import 'package:malabis_app/views/account/accounts.dart';
import 'package:malabis_app/views/cart/cart.dart';
import 'package:malabis_app/views/home/home_page.dart';
import 'package:malabis_app/views/home/notification.dart';
import 'package:malabis_app/views/order/order_history.dart';
import 'package:malabis_app/views/splash_screen.dart';
import 'package:malabis_app/views/wishlist/wishlistscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await PushNotificationService().initialize();

  Dio dio = Dio(); // If needed for API calls

  runApp(ProviderScope(child: MyApp(dio: dio)));
}

class MyApp extends StatelessWidget {
  final Dio dio;
  const MyApp({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Base navigation provider
        RepositoryProvider(create: (_) => NavigationProvider()),

        // Navigation repository that uses the provider above
        RepositoryProvider(
          create: (context) =>
              NavigationRepository(context.read<NavigationProvider>()),
        ),

        // WordPress API instance
        RepositoryProvider(create: (_) => WordPressApi()),

        // Firebase Auth wrapper
        RepositoryProvider(
            create: (_) => AuthRepository(FirebaseAuth.instance)),

        // For placing orders
        RepositoryProvider(create: (_) => OrderPlaceProvider()),

        // Home repository to fetch products from WordPress
        RepositoryProvider(
          create: (context) =>
              HomeRepository(api: context.read<WordPressApi>()),
        ),

        // Order placing repo using the provider
        RepositoryProvider(
          create: (context) =>
              OrderPlaceRepository(context.read<OrderPlaceProvider>()),
        ),

        // ✅ NEW: Fetch Orders API Provider (or use Dio directly if this is not needed)
        RepositoryProvider(create: (_) => OrderFetchProvider()),

        // ✅ NEW: Fetch Order Repository
        RepositoryProvider(
          create: (context) =>
              OrderFetchRepository(context.read<OrderFetchProvider>()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthCubit>(
                create: (context) =>
                    AuthCubit(context.read<AuthRepository>()),
              ),

              BlocProvider(create: (_) => WishlistCubit()),

              BlocProvider<HomeCubit>(
                create: (context) =>
                    HomeCubit(context.read<HomeRepository>())..loadInitialProducts(),
              ),

              BlocProvider(create: (_) => CartCubit()),

              BlocProvider<OrdersPlaceCubit>(
                create: (context) =>
                    OrdersPlaceCubit(context.read<OrderPlaceRepository>(), context.read<AuthCubit>()),
              ),

              // ✅ OrderFetchCubit now gets the right repository
              BlocProvider<OrderFetchCubit>(
                create: (context) =>
                    OrderFetchCubit(context.read<OrderFetchRepository>()),
              ),
            ],
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Malabis App',
                  theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    primarySwatch: Colors.blue,
                  ),
                  onGenerateRoute: CustomRoutes.allRoutes,
                  home: const SplashScreen(), // Start from SplashScreen
                  routes: {
                    '/homePage': (context) => HomePage(),
                    '/cartscreen': (context) => CartScreen(),
                    '/wishlistscreen': (context) => WishlistScreen(),
                    '/orderscreen': (context) => OrderHistoryScreen(),
                    '/accounts': (context) => AccountsScreen(),
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
