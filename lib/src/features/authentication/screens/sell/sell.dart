import 'package:flourish/src/auth/auth_controller.dart';
import 'package:flourish/src/features/authentication/screens/home/widget/circular_container.dart';
import 'package:flourish/src/features/authentication/screens/home/widget/curved_edge_widget.dart';
import 'package:flourish/src/features/authentication/screens/product/product_quries/product_controller.dart';
import 'package:flourish/src/features/authentication/screens/sell/custom_category.dart';
import 'package:flourish/src/features/authentication/screens/sell/custom_input_field.dart';
import 'package:flourish/src/features/authentication/screens/sell/image_grid.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductUploadPage extends StatefulWidget {
  const ProductUploadPage({super.key});

  @override
  _ProductUploadPageState createState() => _ProductUploadPageState();
}

class _ProductUploadPageState extends State<ProductUploadPage> {
  final ProductController _productController = ProductController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imageFiles = [];
  final bool _isLoading = false;

  // Form controllers
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _discountController = TextEditingController();
  String _condition = 'New';

  // Theme colors
  final Color primaryColor = slate400;
  final Color secondaryColor = slate800;
  final Color backgroundColor = light;
  final Color cardColor = Colors.transparent;

  void _resetForm() {
    setState(() {
      // Clear text controllers
      _titleController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _discountController.clear();

      // Reset condition to default
      _condition = 'New';

      // Clear selected categories
      _selectedCategories.clear();

      // Clear image files
      _imageFiles.clear();
    });
  }

  // Categories
  final List<String> _availableCategories = [
    'Electronics',
    'Books',
    'Accessories',
    'Clothing',
    'Sports',
    'Gaming',
  ];
  final List<String> _selectedCategories = [];
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final Size size = HelperFunction.getScreenSize(context);
    final isDark = HelperFunction.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CurvedEdgeWidget(
                child: Container(
                  color: slate400,
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                    height: size.height * 0.135,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -150,
                          right: -250,
                          child: CircularContainer(
                              backgroundColor: light.withOpacity(0.1)),
                        ),
                        Positioned(
                          top: 100,
                          right: -300,
                          child: CircularContainer(
                              backgroundColor: light.withOpacity(0.1)),
                        ),
                        // app bar
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: AppBar(
                            title: Text(
                              "List Product",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .apply(color: slate800, fontSizeFactor: 0.8),
                              // style: TextStyle(
                              //     fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                        ),
                      ],
                      // user profile card
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: defaultSize, right: defaultSize, bottom: defaultSize),
                child: Column(
                  children: [
                    // IMAGE GRID
                    ImageGridWidget(
                      imageFiles: _imageFiles,
                      onImageAdded: (XFile file) {
                        setState(() {
                          _imageFiles.add(file);
                        });
                      },
                      onImageRemoved: (int index) {
                        setState(() {
                          _imageFiles.removeAt(index);
                        });
                      },
                      showImagePicker: _showImageSourceDialog,
                    ),
                    const SizedBox(height: spaceBtwItems),

                    // PRODUCT DETAILS
                    CustomInputField(
                      label: 'Product Details',
                      child: TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: 'Enter product title',
                          hintStyle: const TextStyle(color: slate800),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: slate800.withOpacity(0.1),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: slate800.withOpacity(0.9),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: slate800.withOpacity(0.9),
                            ),
                          ),
                          floatingLabelStyle:
                              TextStyle(color: rose.withOpacity(0.8)),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                    ),

                    const SizedBox(height: spaceBtwItems),

                    // PRICING AND DISCOUTN
                    CustomInputField(
                      label: 'Pricing',
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _priceController,
                              decoration: InputDecoration(
                                labelText: 'Price',
                                prefixText: '\u20B9',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: slate800.withOpacity(0.1),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: slate800.withOpacity(0.9),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: slate800.withOpacity(0.9),
                                  ),
                                ),
                                floatingLabelStyle:
                                    TextStyle(color: rose.withOpacity(0.8)),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  value?.isEmpty ?? true ? 'Required' : null,
                            ),
                          ),
                          const SizedBox(width: spaceBtwItems),
                          Expanded(
                            child: TextFormField(
                              controller: _discountController,
                              decoration: InputDecoration(
                                labelText: 'Discount',
                                suffixText: '%',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: slate800.withOpacity(0.1),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: slate800.withOpacity(0.9),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: slate800.withOpacity(0.9),
                                  ),
                                ),
                                floatingLabelStyle:
                                    TextStyle(color: rose.withOpacity(0.8)),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(2),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: spaceBtwItems),

                    // CONDITON
                    CustomInputField(
                        label: 'Condition',
                        child: DropdownButtonFormField<String>(
                          value: _condition,
                          decoration: InputDecoration(
                            // labelText: 'Condition',
                            floatingLabelStyle:
                                TextStyle(color: rose.withOpacity(0.8)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: slate800.withOpacity(0.1),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: slate800.withOpacity(0.9),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: slate800.withOpacity(0.9),
                              ),
                            ),
                            filled: true,
                            fillColor: backgroundColor,
                          ),
                          style: const TextStyle(color: slate800),
                          icon: Icon(Icons.arrow_drop_down,
                              color: slate800.withOpacity(0.8)),
                          dropdownColor: backgroundColor,
                          items: ['New', 'Like New', 'Good', 'Fair', 'Poor']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _condition = newValue;
                              });
                            }
                          },
                          validator: (value) =>
                              value == null ? 'Required' : null,
                        )),

                    const SizedBox(height: spaceBtwItems),

                    // CATEGORIES
                    CustomCategoriesField(
                      label: 'Categories',
                      availableCategories: _availableCategories,
                      selectedCategories: _selectedCategories,
                      onCategorySelected: (category, selected) {
                        setState(() {
                          if (selected) {
                            _selectedCategories.add(category);
                          } else {
                            _selectedCategories.remove(category);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: spaceBtwItems),

                    // DESCRIPTION
                    CustomInputField(
                      label: 'Description',
                      child: TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Specifications & Details',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: slate800.withOpacity(0.1),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: slate800.withOpacity(0.9),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: slate800.withOpacity(0.9),
                            ),
                          ),
                          floatingLabelStyle:
                              TextStyle(color: rose.withOpacity(0.8)),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        maxLines: 5,
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  if (controller.currentUserId == null) {
                                    Get.snackbar('Error',
                                        'Please log in to list a product.');
                                    return;
                                  }
                                  try {
                                    await _productController.uploadProduct(
                                      userId: controller.currentUserId ?? '',
                                      title: _titleController.text,
                                      price:
                                          double.parse(_priceController.text),
                                      discount:
                                          _discountController.text.isNotEmpty
                                              ? double.parse(
                                                  _discountController.text)
                                              : null,
                                      description: _descriptionController.text,
                                      imageFiles: _imageFiles,
                                      condition: _condition,
                                      tags: _selectedCategories,
                                    );

                                    // Reset the form after successful upload
                                    _resetForm();

                                    // Show success message
                                    Get.snackbar('Success',
                                        'Product listed successfully!');
                                  } catch (e) {
                                    Get.snackbar('Error', e.toString());
                                  }
                                }
                              },
                        // onPressed: _isLoading
                        //     ? null
                        //     : () async {
                        //         if (_formKey.currentState!.validate()) {
                        //           if (controller.currentUserId == null) {
                        //             Get.snackbar('Error',
                        //                 'Please log in to list a product.');
                        //             return;
                        //           }
                        //           try {
                        //             await _productController.uploadProduct(
                        //               userId: controller.currentUserId ??
                        //                   '', // Replace with actual user ID
                        //               title: _titleController.text,
                        //               price:
                        //                   double.parse(_priceController.text),
                        //               discount:
                        //                   _discountController.text.isNotEmpty
                        //                       ? double.parse(
                        //                           _discountController.text)
                        //                       : null,
                        //               description: _descriptionController.text,
                        //               imageFiles: _imageFiles,
                        //               condition: _condition,
                        //               tags: _selectedCategories,
                        //             );
                        //           } catch (e) {
                        //             Get.snackbar('Error', e.toString());
                        //           }
                        //         }
                        //       },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: slate600,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: slate800.withOpacity(0),
                                ))),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: light)
                            : Text(
                                'List Product',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color: isDark ? slate800 : light,
                                    ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Other methods remain the same...
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text('Add Photo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: primaryColor),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImages(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: primaryColor),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImages(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImages(ImageSource source) async {
    try {
      if (source == ImageSource.gallery) {
        final List<XFile> pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles.isNotEmpty) {
          setState(() {
            _imageFiles.addAll(pickedFiles);
          });
        }
      } else {
        final XFile? pickedFile = await _picker.pickImage(source: source);
        if (pickedFile != null) {
          setState(() {
            _imageFiles.add(pickedFile);
          });
        }
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _discountController.dispose();
    super.dispose();
  }
}
