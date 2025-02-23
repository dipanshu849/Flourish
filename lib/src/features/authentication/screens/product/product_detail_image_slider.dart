import 'package:flourish/src/common_style/rounded_image.dart';
import 'package:flourish/src/common_widget/icon/circular_icon.dart';
import 'package:flourish/src/features/authentication/screens/home/widget/curved_edge_widget.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class ProductDetailImageSlider extends StatefulWidget {
  final List<String> images; // List of image URLs

  const ProductDetailImageSlider({
    super.key,
    required this.images,
  });

  @override
  _ProductDetailImageSliderState createState() =>
      _ProductDetailImageSliderState();
}

class _ProductDetailImageSliderState extends State<ProductDetailImageSlider> {
  int _selectedImageIndex = 0; // Track the selected image index

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);

    return CurvedEdgeWidget(
      child: Container(
        color: isDark ? slate600 : light,
        child: Stack(
          children: [
            // MAIN LARGE IMAGE
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Image(
                    image: NetworkImage(widget
                        .images[_selectedImageIndex]), // Display selected image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // IMAGE SLIDER
            Positioned(
              left: defaultSize,
              bottom: 40,
              right: 0,
              child: SizedBox(
                height: 60,
                child: ListView.separated(
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: spaceBtwItems),
                  itemCount: widget.images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedImageIndex = index; // Update selected image
                      });
                    },
                    child: RoundedImage(
                      imageUrl: widget.images[index],
                      isNetworkImage: true,
                      width: 60,
                      backgroundColor: isDark
                          ? dark.withOpacity(0.2)
                          : slate400.withOpacity(0.2),
                      padding: const EdgeInsets.all(xs),
                      border: Border.all(
                        color: _selectedImageIndex == index
                            ? rose // Highlight selected image
                            : isDark
                                ? dark.withOpacity(0.6)
                                : slate400.withOpacity(0.6),
                        width: _selectedImageIndex == index
                            ? 2
                            : 1, // Thicker border for selected image
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // APP BAR ICON
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: const [
                  CircularIcon(
                    icon: Icons.favorite,
                    size: 30,
                    iconColor: rose,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
