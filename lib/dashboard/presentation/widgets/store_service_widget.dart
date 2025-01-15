// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:order_delivery_manager/core/constants/strings.dart';
import 'package:order_delivery_manager/core/util/functions/functions.dart';
import 'package:order_delivery_manager/core/util/variables/global_variables.dart';
import 'package:order_delivery_manager/dashboard/models/store_module.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/custom_button.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/custom_text_form_field.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/image_picker_widget.dart';

class StoreServiceWidget extends StatefulWidget {
  final double height, width;

  const StoreServiceWidget(
      {super.key, required this.height, required this.width});

  @override
  State<StoreServiceWidget> createState() => _StoreServiceWidgetState();
}

class _StoreServiceWidgetState extends State<StoreServiceWidget> {
  Uint8List? selectedPicture;
  final GlobalKey<FormState> addStoreForm = GlobalKey<FormState>();
  final GlobalKey<FormState> deleteStoreForm = GlobalKey<FormState>();
  final GlobalKey<FormState> searchStoreForm = GlobalKey<FormState>();
  final TextEditingController addStoreTEC = TextEditingController();
  final TextEditingController searchStoreTEC = TextEditingController();
  final TextEditingController deleteStoreTEC = TextEditingController();
  bool loadingAddStore = false,
      loadingDeleteStore = false,
      loadingSearchStores = false;

  final List<StoreModel> searchedStores = [];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            height: widget.height,
            width: 0.4 * widget.width,
            child: _buildFirstSection()),
        SizedBox(
            height: widget.height,
            width: 0.4 * widget.width,
            child: _buildSearchSection()),
      ],
    );
  }

  Widget _buildFirstSection() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 50.0),
        child: Column(
          children: [
            SizedBox(
                height: 0.7 * widget.height,
                child: loadingAddStore
                    ? _defaultLoadingWidget()
                    : _buildAddStore()),
            SizedBox(
                height: 0.3 * widget.height,
                child: loadingDeleteStore
                    ? _defaultLoadingWidget()
                    : _buildDeleteStore()),
          ],
        ),
      ),
    );
  }

  Widget _buildAddStore() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "Add Store:",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 0.1 * widget.height,
          width: widget.width / 2 - 20,
          child: Form(
            key: addStoreForm,
            child: CustomTextFormField(
                textEditingController: addStoreTEC,
                hintText: "store name",
                validator: (value) => _defaultValidator(value),
                prefixIcon: const Icon(
                  Icons.abc,
                  color: Colors.amber,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ImagePickerWidget(
            height: 0.3 * widget.height,
            width: 0.45 * widget.width,
            onImageSelected: (picture) {
              selectedPicture = picture;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.3 * widget.width - 60),
          child: CustomButton(
              height: 0.08 * widget.height,
              width: 0.2 * widget.width,
              onPressed: () async {
                setState(() {
                  loadingAddStore = true;
                });
                if (addStoreForm.currentState!.validate() &&
                    selectedPicture != null) {
                  try {
                    await storeService.addStore(addStoreTEC.text.trim(),
                        logoData: selectedPicture!);
                    showCustomAboutDialog(context, "Done",
                        "The Store ${addStoreTEC.text} has been added successfully!",
                        type: SUCCESS_TYPE);
                    addStoreTEC.text = "";
                  } catch (e) {
                    if (context.mounted) {
                      showCustomAboutDialog(context, "Error", e.toString(),
                          type: ERROR_TYPE);
                    }
                  }
                } else {
                  showCustomAboutDialog(context, "Error",
                      "Please select picture and enter a store name in order to register a new store ");
                }
                setState(() {
                  loadingAddStore = false;
                });
              },
              color: Colors.amber,
              child: const Text(
                "Add",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              )),
        ),
      ],
    );
  }

  Widget _buildDeleteStore() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "Delete Store:",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 0.1 * widget.height,
          width: widget.width / 2 - 20,
          child: Form(
            key: deleteStoreForm,
            child: CustomTextFormField(
                textEditingController: deleteStoreTEC,
                hintText: "store id",
                validator: (value) => _defaultValidator(value),
                prefixIcon: const Icon(
                  Icons.unfold_more_outlined,
                  color: Colors.amber,
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.3 * widget.width - 60),
          child: CustomButton(
              height: 0.08 * widget.height,
              width: 0.2 * widget.width,
              onPressed: () async {
                setState(() {
                  loadingDeleteStore = true;
                });
                if (deleteStoreForm.currentState!.validate()) {
                  try {
                    await storeService.deleteStore(
                      deleteStoreTEC.text.trim(),
                    );
                    showCustomAboutDialog(context, "Done",
                        "The Store id=${deleteStoreTEC.text} has been deleted successfully!",
                        type: SUCCESS_TYPE);
                    deleteStoreTEC.text = "";
                  } catch (e) {
                    if (context.mounted) {
                      showCustomAboutDialog(context, "Error", e.toString(),
                          type: ERROR_TYPE);
                    }
                  }
                } else {
                  showCustomAboutDialog(context, "Error",
                      "Please enter a store id in order to delete a store ");
                }
                setState(() {
                  loadingDeleteStore = false;
                });
              },
              color: Colors.amber,
              child: const Text(
                "Delete",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              )),
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Search For Stores:",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: 0.1 * widget.height,
              width: widget.width / 2 - 20,
              child: Form(
                key: searchStoreForm,
                child: CustomTextFormField(
                    textEditingController: searchStoreTEC,
                    hintText: "store name",
                    validator: (value) => _defaultValidator(value),
                    prefixIcon: const Icon(
                      Icons.abc,
                      color: Colors.amber,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.3 * widget.width - 60),
              child: CustomButton(
                  height: 0.08 * widget.height,
                  width: 0.2 * widget.width,
                  onPressed: loadingSearchStores
                      ? null
                      : () async {
                          setState(() {
                            loadingSearchStores = true;
                          });
                          if (searchStoreForm.currentState!.validate()) {
                            try {
                              searchedStores.clear();
                              searchedStores
                                  .addAll(await storeService.searchStore(
                                searchStoreTEC.text.trim(),
                              ));
                            } catch (e) {
                              if (context.mounted) {
                                showCustomAboutDialog(
                                    context, "Error", e.toString(),
                                    type: ERROR_TYPE);
                              }
                            }
                          } else {
                            showCustomAboutDialog(context, "Error",
                                "Please enter a store name in order to seach for a store ");
                          }
                          setState(() {
                            loadingSearchStores = false;
                          });
                        },
                  color: Colors.amber,
                  child: const Text(
                    "Search",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20),
                  )),
            ),
            SizedBox(
              height: 0.8 * widget.height,
              child: loadingSearchStores
                  ? _defaultLoadingWidget()
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchedStores.length,
                      itemBuilder: (context, index) {
                        final store = searchedStores[index];
                        return ListTile(
                          title: Text(store.storeName),
                          subtitle: Text("Id : ${store.storeId}"),
                          trailing: const Icon(
                            Icons.store,
                            color: Colors.deepPurple,
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget _defaultLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.amber,
      ),
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "please fill this text field to continue";
    }
    return null;
  }
}
