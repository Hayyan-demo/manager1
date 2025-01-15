import 'package:order_delivery_manager/dashboard/services/auth_service.dart';
import 'package:order_delivery_manager/dashboard/services/product_service.dart';
import 'package:order_delivery_manager/dashboard/services/store_service.dart';
import 'package:order_delivery_manager/dashboard/services/user_service.dart';

final AuthService authService = AuthService();
final StoreService storeService = StoreService();
final ProductService productService = ProductService();
final UserService userService = UserService();

late String token;
