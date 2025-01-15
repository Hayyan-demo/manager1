// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:order_delivery_manager/core/constants/strings.dart';
import 'package:order_delivery_manager/core/util/functions/functions.dart';
import 'package:order_delivery_manager/core/util/variables/global_variables.dart';
import 'package:order_delivery_manager/dashboard/models/product_model.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/custom_button.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/custom_text_form_field.dart';

class ProductServiceWidget extends StatefulWidget {
  final double height, width;

  const ProductServiceWidget(
      {super.key, required this.height, required this.width});

  @override
  State<ProductServiceWidget> createState() => _ProductServiceWidgetState();
}

class _ProductServiceWidgetState extends State<ProductServiceWidget> {
  final GlobalKey<FormState> addProductForm = GlobalKey<FormState>();
  final GlobalKey<FormState> deleteProductForm = GlobalKey<FormState>();
  final GlobalKey<FormState> searchProductForm = GlobalKey<FormState>();

  final TextEditingController createProductARNameTEC = TextEditingController();
  final TextEditingController createProductENNameTEC = TextEditingController();
  final TextEditingController createProductARDesTEC = TextEditingController();
  final TextEditingController createProductENDesTEC = TextEditingController();
  final TextEditingController createProductStoreIdTEC = TextEditingController();
  final TextEditingController createProductQuantityTEC =
      TextEditingController();
  final TextEditingController createProductPriceTEC = TextEditingController();

  final TextEditingController searchProductTEC = TextEditingController();
  final TextEditingController deleteProductTEC = TextEditingController();

  bool loadingAddProduct = false,
      loadingDeleteProduct = false,
      loadingSearchProducts = false;

  final PageController picturesPagesController = PageController();
  List<Uint8List> selectedPictures = [];
  int _picturesIndex = 1;
  final List<ProductModel> searchedProducts = [];
  final ScrollController _scrollController = ScrollController();
  int currentPage = 0;
  bool stopSearch = false;
  double _currentScrollOffset = 0;
  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    createProductARNameTEC.dispose();
    createProductENNameTEC.dispose();
    createProductARDesTEC.dispose();
    createProductENDesTEC.dispose();
    createProductStoreIdTEC.dispose();
    createProductQuantityTEC.dispose();
    createProductPriceTEC.dispose();
    searchProductTEC.dispose();
    deleteProductTEC.dispose();

    super.dispose();
  }

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
                height: selectedPictures.isEmpty
                    ? widget.height
                    : 1.4 * widget.height,
                child: loadingAddProduct
                    ? _defaultLoadingWidget()
                    : _buildAddProduct()),
            SizedBox(
                height: 0.3 * widget.height,
                child: loadingDeleteProduct
                    ? _defaultLoadingWidget()
                    : _buildDeleteProduct()),
          ],
        ),
      ),
    );
  }

  Widget _buildAddProduct() {
    return Form(
      key: addProductForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "Add Product:",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          SizedBox(
            height: 0.1 * widget.height,
            width: widget.width / 2 - 20,
            child: CustomTextFormField(
                textEditingController: createProductARNameTEC,
                hintText: "Product arabic name",
                validator: (value) => _defaultValidator(value),
                prefixIcon: const Icon(
                  Icons.abc,
                  color: Colors.amber,
                )),
          ),
          SizedBox(
            height: 0.1 * widget.height,
            width: widget.width / 2 - 20,
            child: CustomTextFormField(
                textEditingController: createProductENNameTEC,
                hintText: "Product english name",
                validator: (value) => _defaultValidator(value),
                prefixIcon: const Icon(
                  Icons.abc,
                  color: Colors.amber,
                )),
          ),
          SizedBox(
            height: 0.1 * widget.height,
            width: widget.width / 2 - 20,
            child: CustomTextFormField(
                textEditingController: createProductARDesTEC,
                hintText: "Product arabic description",
                validator: (value) => _defaultValidator(value),
                prefixIcon: const Icon(
                  Icons.abc,
                  color: Colors.amber,
                )),
          ),
          SizedBox(
            height: 0.1 * widget.height,
            width: widget.width / 2 - 20,
            child: CustomTextFormField(
                textEditingController: createProductENDesTEC,
                hintText: "Product english description",
                validator: (value) => _defaultValidator(value),
                prefixIcon: const Icon(
                  Icons.abc,
                  color: Colors.amber,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 0.1 * widget.height,
                width: widget.width / 6 - 20,
                child: CustomTextFormField(
                    textEditingController: createProductQuantityTEC,
                    hintText: " quantity",
                    validator: (value) => _defaultValidator(value),
                    prefixIcon: const Icon(
                      Icons.abc,
                      color: Colors.amber,
                    )),
              ),
              SizedBox(
                height: 0.1 * widget.height,
                width: widget.width / 6 - 20,
                child: CustomTextFormField(
                    textEditingController: createProductPriceTEC,
                    hintText: " price",
                    validator: (value) => _defaultValidator(value),
                    prefixIcon: const Icon(
                      Icons.abc,
                      color: Colors.amber,
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 0.1 * widget.height,
                width: widget.width / 6 - 20,
                child: CustomTextFormField(
                    textEditingController: createProductStoreIdTEC,
                    hintText: "Store id",
                    validator: (value) => _defaultValidator(value),
                    prefixIcon: const Icon(
                      Icons.abc,
                      color: Colors.amber,
                    )),
              ),
              CustomButton(
                  height: 0.08 * widget.height,
                  width: widget.width / 6 - 20,
                  onPressed: () async {
                    await _pickImage();
                  },
                  color: Colors.white,
                  child: const Text("Add Image"))
            ],
          ),
          _buildPhotos(widget.height),
          Padding(
            padding: EdgeInsets.only(left: 0.3 * widget.width - 60),
            child: CustomButton(
                height: 0.08 * widget.height,
                width: 0.2 * widget.width,
                onPressed: () async {
                  setState(() {
                    loadingAddProduct = true;
                  });
                  if (addProductForm.currentState!.validate() &&
                      selectedPictures.isNotEmpty) {
                    try {
                      await productService.createProduct(
                          _toJson(), selectedPictures);
                      showCustomAboutDialog(context, "Done",
                          "The Product ${createProductENNameTEC.text} has been added successfully!",
                          type: SUCCESS_TYPE);
                      createProductENNameTEC.text = '';
                      createProductARNameTEC.text = '';
                      createProductENDesTEC.text = '';
                      createProductARDesTEC.text = '';
                      createProductQuantityTEC.text = '';
                      createProductPriceTEC.text = '';
                      createProductStoreIdTEC.text = '';
                      selectedPictures.clear();
                      setState(() {});
                    } catch (e) {
                      if (context.mounted) {
                        showCustomAboutDialog(context, "Error", e.toString(),
                            type: ERROR_TYPE);
                      }
                    }
                  } else {
                    showCustomAboutDialog(context, "Error",
                        "Please select picture and enter a product attributes in order to register a new Product ");
                  }
                  setState(() {
                    loadingAddProduct = false;
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
      ),
    );
  }

  Widget _buildDeleteProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "Delete Product:",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 0.1 * widget.height,
          width: widget.width / 2 - 20,
          child: Form(
            key: deleteProductForm,
            child: CustomTextFormField(
                textEditingController: deleteProductTEC,
                hintText: "Product id",
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
                  loadingDeleteProduct = true;
                });
                if (deleteProductForm.currentState!.validate()) {
                  try {
                    await productService.deleteProduct(
                      deleteProductTEC.text.trim(),
                    );
                    showCustomAboutDialog(context, "Done",
                        "The Product id=${deleteProductTEC.text} has been deleted successfully!",
                        type: SUCCESS_TYPE);
                    deleteProductTEC.text = "";
                  } catch (e) {
                    if (context.mounted) {
                      showCustomAboutDialog(context, "Error", e.toString(),
                          type: ERROR_TYPE);
                    }
                  }
                } else {
                  showCustomAboutDialog(context, "Error",
                      "Please enter a Product id in order to delete a Product ");
                }
                setState(() {
                  loadingDeleteProduct = false;
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
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Search For Products:",
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
                key: searchProductForm,
                child: CustomTextFormField(
                    textEditingController: searchProductTEC,
                    hintText: "Product name",
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
                  onPressed: loadingSearchProducts
                      ? null
                      : () async {
                          _searchProducts(true);
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
              child: loadingSearchProducts
                  ? _defaultLoadingWidget()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: searchedProducts.length,
                      itemBuilder: (context, index) {
                        final product = searchedProducts[index];
                        return ListTile(
                          title: Text(product.englishName,
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(
                            "Id : ${product.productId}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: Text("${product.price} \$",
                              style: const TextStyle(color: Colors.white)),
                          trailing: const Icon(
                            Icons.shopping_basket,
                            color: Colors.white,
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

  Widget _buildPhotos(double height) {
    if (selectedPictures.isEmpty) {
      return const SizedBox();
    } else {
      return AspectRatio(
        aspectRatio: 4 / 3,
        child: Stack(
          children: [
            SizedBox(
              height: 0.4 * height,
              child: PageView.builder(
                controller: picturesPagesController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) => setState(() {
                  _picturesIndex = value + 1;
                }),
                itemCount: selectedPictures.length,
                itemBuilder: (context, index) => Container(
                  height: widget.height,
                  width: widget.width,
                  decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(
                            selectedPictures.elementAt(index),
                          ))),
                ),
              ),
            ),
            Positioned(
                left: 10,
                top: 10,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "$_picturesIndex / ${selectedPictures.length}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  )),
                )),
            Positioned(
                right: 10,
                top: 10,
                child: MaterialButton(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedPictures.removeAt(_picturesIndex - 1);
                      _picturesIndex = 1;
                      picturesPagesController.jumpToPage(0);
                    });
                  },
                )),
          ],
        ),
      );
    }
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

  Future<void> _pickImage() async {
    final imageBytes = await ImagePickerWeb.getImageAsBytes();

    if (imageBytes != null) {
      selectedPictures.add(imageBytes);
      setState(() {});
    }
  }

  Map<String, dynamic> _toJson() {
    return {
      'en_name': createProductENNameTEC.text.trim(),
      'ar_name': createProductARNameTEC.text.trim(),
      'en_description': createProductENDesTEC.text.trim(),
      'ar_description': createProductARDesTEC.text.trim(),
      'quantity': createProductQuantityTEC.text.trim(),
      'price': createProductPriceTEC.text.trim(),
      'store_id': createProductStoreIdTEC.text.trim(),
    };
  }

  void _scrollListener() {
    final double maxExtent = _scrollController.position.maxScrollExtent;
    final double currentOffset = _scrollController.offset;
    if (currentOffset > 0.9 * maxExtent &&
        !loadingSearchProducts &&
        !stopSearch) {
      _currentScrollOffset = currentOffset;
      _searchProducts(false);
      _scrollController.jumpTo(_currentScrollOffset);
    }
  }

  Future<void> _searchProducts(bool deletePreviouse) async {
    setState(() {
      loadingSearchProducts = true;
    });
    if (searchProductForm.currentState!.validate()) {
      try {
        if (deletePreviouse) {
          searchedProducts.clear();
        }
        searchedProducts.addAll(await productService
            .searchProducts(searchProductTEC.text.trim(), page: ++currentPage));
      } catch (e) {
        if (e.toString() ==
            "Exception: Error: Exception: Failed to search products: No products found") {
          stopSearch = true;
        } else {
          if (context.mounted) {
            showCustomAboutDialog(context, "Error", e.toString(),
                type: ERROR_TYPE);
          }
        }
      }
    } else {
      showCustomAboutDialog(context, "Error",
          "Please enter a Product name in order to seach for a Product ");
    }
    setState(() {
      loadingSearchProducts = false;
    });
  }
}
