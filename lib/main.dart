import 'package:e_commerce_project/pages/home_page.dart';
import 'package:e_commerce_project/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'pages/make_payment.dart';
import 'pages/get_your_order.dart';
import 'pages/choose_products_page.dart';
import 'package:provider/provider.dart';
import 'providers/favourite_provider.dart';
import 'providers/orders_provider.dart';
import 'providers/total_products.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/product_model.dart';
import 'models/cart_item_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for Flutter
  await Hive.initFlutter();
  Hive.registerAdapter(DimensionsAdapter());
  Hive.registerAdapter(ReviewAdapter());
  Hive.registerAdapter(MetaAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CartItemAdapter());

  Box? box = await Hive.openBox('myBox');
  await Hive.openBox('favouritesBox');
  await Hive.openBox('cartBox');
  await Hive.openBox('ordersBox');

  final favProvider = FavouriteProvider();
  favProvider.getStoredFavourites();
  if (!box.containsKey('isLoggedIn')) {
    await box.put('isLoggedIn', false);
  }

  final cartProvider = CartProvider();
  cartProvider.getStoredItems();

  final ordersProvider = OrdersProvider();
  ordersProvider.getStoredOrders();

  runApp(
    MyApp(
      box: box,
      favProvider: favProvider,
      cartProvider: cartProvider,
      ordersProvider: ordersProvider,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.box,
    required this.favProvider,
    required this.cartProvider,
    required this.ordersProvider,
  });
  final Box? box;
  final FavouriteProvider? favProvider;
  final CartProvider? cartProvider;
  final OrdersProvider? ordersProvider;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: favProvider),
        ChangeNotifierProvider.value(value: cartProvider),
        ChangeNotifierProvider.value(value: ordersProvider),
        ChangeNotifierProvider(create: (context) => TotalProductsProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(title: 'Flutter Demo Home Page', box: box),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title, required this.box});
  final String title;
  static late PageController controller;
  static const email = "123@example.com";
  static const password = "123456";
  final Box? box;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    MainPage.controller = PageController();
  }

  @override
  void dispose() {
    MainPage.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: widget.box!.get('isLoggedIn') == true
          ? HomePage(title: "HomePage")
          : PageView(
              scrollDirection: Axis.horizontal,
              controller: MainPage.controller,
              children: [
                ChooseProductsPage(title: "Choose Products"),
                MakePaymentPage(title: "Make Payment"),
                GetYourOrderPage(title: "Get Your Order"),
              ],
            ),
    );
  }
}
