import 'package:flutter/material.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/product_service_widget.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/store_service_widget.dart';

class EditPage extends StatelessWidget {
  final double height, width;

  const EditPage({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [SizedBox(height: height, child: _buildTabBars())],
    );
  }

  Widget _buildTabBars() {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
                dividerHeight: 0,
                dividerColor: Colors.black.withAlpha(100),
                indicator: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 78, 78).withAlpha(100),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(
                    icon: Icon(
                      Icons.store_sharp,
                      color: Colors.white,
                    ),
                    child: Text(
                      "Store",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.shopping_basket_rounded,
                      color: Colors.white,
                    ),
                    child: Text(
                      "Product",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ]),
          ),
          Expanded(
            child: TabBarView(children: [
              StoreServiceWidget(
                height: height,
                width: width,
              ),
              ProductServiceWidget(height: height, width: width)
            ]),
          )
        ]));
  }
}
