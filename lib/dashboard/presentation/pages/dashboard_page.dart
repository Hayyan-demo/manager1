// ignore_for_file: use_build_context_synchronously

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:order_delivery_manager/core/constants/strings.dart';
import 'package:order_delivery_manager/core/util/functions/functions.dart';
import 'package:order_delivery_manager/core/util/variables/global_variables.dart';
import 'package:order_delivery_manager/dashboard/models/user_model.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/line_scale.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/total_profit_widget.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/users_table.dart';

class DashboardPage extends StatefulWidget {
  final double height, width;

  const DashboardPage({super.key, required this.height, required this.width});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double? totalUserCount,
      totalUserScale,
      totalProductsCount,
      totalProductsScale,
      totalStoresCount,
      totalStoresScale,
      usersCount,
      driversCount,
      totalIncomeCount,
      totalIncomeScale;

  List<UserModel> loadedUsers = [];
  @override
  void initState() {
    super.initState();
    _getTotalCounts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        color: Colors.purple,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildFirstSection(),
              _buildSecondSection(),
              _buildThirdSection(),
            ],
          ),
        ));
  }

  Widget _buildFirstSection() {
    return SizedBox(
      height: 0.4 * widget.height,
      child: Row(
        children: [
          _buildCounts(),
          _buildCounts2(),
        ],
      ),
    );
  }

  Widget _buildCounts() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          spacing: 10,
          children: [
            LineScale(
                width: totalUserCount == null ? 1 : 0.5 * widget.width - 50,
                color: const Color.fromARGB(255, 33, 243, 243),
                name: 'Total Users',
                value: totalUserCount ?? 1,
                maxValue: totalUserScale ?? 1),
            LineScale(
                width: totalProductsCount == null ? 1 : 0.5 * widget.width - 50,
                color: Colors.pinkAccent,
                name: 'Total Products',
                value: totalProductsCount ?? 1,
                maxValue: totalProductsScale ?? 1),
            LineScale(
                width: totalStoresCount == null ? 1 : 0.5 * widget.width - 50,
                color: Colors.amber,
                name: 'Total Stores',
                value: totalStoresCount ?? 1,
                maxValue: totalStoresScale ?? 1),
          ],
        ),
      ),
    );
  }

  Widget _buildCounts2() {
    return SizedBox(
      width: widget.height,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                height: 0.3 * widget.height,
                width: 0.3 * widget.height,
                child: PieChart(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(seconds: 3),
                    PieChartData(sections: [
                      PieChartSectionData(
                          value: totalProductsCount ?? 1,
                          titleStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          title: "Products",
                          showTitle: false,
                          radius: 20,
                          color: Colors.pinkAccent),
                      PieChartSectionData(
                          value: totalStoresCount ?? 1,
                          titleStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          title: "Stores",
                          showTitle: false,
                          radius: 20,
                          color: const Color.fromARGB(255, 255, 184, 31))
                    ])),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoLine("Products count: ${totalProductsCount ?? 0}",
                      Colors.pinkAccent),
                  _buildInfoLine("Stores count: ${totalStoresCount ?? 0}",
                      const Color.fromARGB(255, 255, 184, 31))
                ],
              )
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                height: 0.3 * widget.height,
                width: 0.3 * widget.height,
                child: PieChart(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(seconds: 3),
                    PieChartData(sections: [
                      PieChartSectionData(
                          value: usersCount ?? 1,
                          titleStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          title: "Users",
                          showTitle: false,
                          radius: 20,
                          color: const Color.fromARGB(255, 33, 243, 243)),
                      PieChartSectionData(
                          value: driversCount ?? 5,
                          titleStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          title: "Drivers",
                          showTitle: false,
                          radius: 20,
                          color: const Color.fromARGB(255, 141, 255, 34))
                    ])),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoLine("Users count: ${usersCount ?? 0}",
                      const Color.fromARGB(255, 33, 243, 243)),
                  _buildInfoLine("Drivers count: ${driversCount ?? 0}",
                      const Color.fromARGB(255, 141, 255, 34))
                ],
              )
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                height: 0.3 * widget.height,
                width: 0.3 * widget.height,
                child: PieChart(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(seconds: 3),
                    PieChartData(sections: [
                      PieChartSectionData(
                          value: totalUserCount ?? 1,
                          titleStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          title: "Users",
                          showTitle: false,
                          radius: 20,
                          color: const Color.fromARGB(255, 33, 243, 243)),
                      PieChartSectionData(
                          value: totalProductsCount ?? 1,
                          titleStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          title: "Products",
                          showTitle: false,
                          radius: 20,
                          color: Colors.pinkAccent),
                      PieChartSectionData(
                          value: totalStoresCount ?? 1,
                          titleStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          title: "Stores",
                          showTitle: false,
                          radius: 20,
                          color: const Color.fromARGB(255, 255, 184, 31))
                    ])),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoLine("Users count: ${totalUserCount ?? 0}",
                      const Color.fromARGB(255, 33, 243, 243)),
                  _buildInfoLine("Products count: ${totalProductsCount ?? 0}",
                      Colors.pinkAccent),
                  _buildInfoLine("Stores count: ${totalStoresCount ?? 0}",
                      const Color.fromARGB(255, 255, 184, 31))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoLine(String text, Color color) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          color: color,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSecondSection() {
    return Row(
      children: [_buildTotalProfit()],
    );
  }

  Widget _buildTotalProfit() {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 0.4 * widget.height,
      width: 0.4 * widget.width,
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Total Profit:",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          TotalProfitWidget(
            profit: totalIncomeCount ?? 0.5,
            maxProfit: totalIncomeScale ?? 1,
            height: 0.3 * widget.height,
            width: 0.4 * widget.width,
          )
        ],
      ),
    );
  }

  Widget _buildThirdSection() {
    return Row(
      children: [
        Expanded(
            child: UsersTable(
                users: loadedUsers.isEmpty ? const [] : loadedUsers)),
      ],
    );
  }

  Future<void> _getTotalCounts() async {
    try {
      loadedUsers.addAll(await userService.getUsers());
      setState(() {});

      totalStoresCount = (await storeService.getStoreCount()).toDouble();
      totalStoresScale = _biggestMultiplierOfTen(totalStoresCount!.toInt());
      setState(() {});

      totalProductsCount = (await productService.getProductCount()).toDouble();
      totalProductsScale = _biggestMultiplierOfTen(totalProductsCount!.toInt());
      setState(() {});

      usersCount = (await userService.getUserCount()).toDouble();
      driversCount = (await userService.getDriverCount()).toDouble();
      totalUserCount = (usersCount! + driversCount!).toDouble();
      totalUserScale = _biggestMultiplierOfTen(totalUserCount!.toInt());
      setState(() {});

      totalIncomeCount = await storeService.getTotalProfit();
      totalIncomeScale = _biggestMultiplierOfTen(totalIncomeCount!.toInt());
      setState(() {});
    } catch (e) {
      showCustomAboutDialog(context, "Error", e.toString(), type: ERROR_TYPE);
    }
  }

  double _biggestMultiplierOfTen(int number) {
    int multiplier = 1;
    while (number > 0) {
      multiplier *= 10;
      number ~/= 10;
    }
    return multiplier.toDouble();
  }
}
