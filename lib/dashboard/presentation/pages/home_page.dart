// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:order_delivery_manager/core/constants/strings.dart';
import 'package:order_delivery_manager/core/util/functions/functions.dart';
import 'package:order_delivery_manager/core/util/variables/global_variables.dart';
import 'package:order_delivery_manager/dashboard/presentation/pages/dashboard_page.dart';
import 'package:order_delivery_manager/dashboard/presentation/pages/edit_page.dart';
import 'package:order_delivery_manager/dashboard/presentation/pages/login_page.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/custom_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showMenu = true;
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.black.withAlpha(200),
        height: height,
        width: width,
        child: Stack(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: showMenu ? 0.2 * width : 0,
                padding: EdgeInsets.all(0.01 * width),
                child: !showMenu ? const Text("") : _buildMenuButtons(),
              ),
              Expanded(
                  child: _buildSelectedPage(
                      height, showMenu ? 0.8 * width : width)),
            ]),
            Positioned(left: 10, bottom: 10, child: _buildShowMenuBtn()),
          ],
        ),
      ),
    );
  }

  Widget _buildShowMenuBtn() {
    return InkWell(
      onTap: () {
        setState(() {
          showMenu = !showMenu;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 78, 78, 78),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Text(
          showMenu ? "Hide Menu" : "Show Menu",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildMenuButtons() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomListTile(
            backgroundColor: Colors.purpleAccent.withAlpha(80),
            text: "Dashboard",
            textColor: Colors.purpleAccent,
            icon: Icons.data_saver_off,
            iconColor: Colors.purpleAccent,
            radius: 10,
            isSelected: currentPage == 1,
            onPressed: () => setState(() {
              currentPage = 1;
            }),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomListTile(
            backgroundColor: Colors.blueAccent.withAlpha(80),
            text: "Edit",
            textColor: Colors.blueAccent,
            icon: Icons.edit_document,
            iconColor: Colors.blueAccent,
            isSelected: currentPage == 2,
            radius: 10,
            onPressed: () => setState(() {
              currentPage = 2;
            }),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomListTile(
              backgroundColor: Colors.green.withAlpha(80),
              text: "Logout",
              textColor: Colors.green,
              icon: Icons.logout,
              iconColor: Colors.greenAccent.withAlpha(200),
              radius: 10,
              isSelected: currentPage == 0,
              onPressed: () async {
                showCustomAboutDialog(
                    context, "Logging out", "please wait while logging out",
                    barrierDissmisable: false,
                    actions: [
                      const CircularProgressIndicator(
                        color: Colors.amber,
                      )
                    ]);
                try {
                  await authService.logout();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                } catch (e) {
                  Navigator.of(context).pop();
                  showCustomAboutDialog(context, "Error", e.toString(),
                      type: ERROR_TYPE);
                }
              }),
        ],
      ),
    );
  }

  Widget _buildSelectedPage(double height, double width) {
    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      color: currentPage == 1 ? Colors.purple : Colors.blue,
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: [
            DashboardPage(height: height, width: width),
            EditPage(height: height, width: width)
          ].elementAt(currentPage - 1),
        ),
      ),
    );
  }
}
