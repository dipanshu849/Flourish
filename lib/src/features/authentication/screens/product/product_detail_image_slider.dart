import 'package:flourish/src/common_style/rounded_image.dart';
import 'package:flourish/src/common_widget/icon/circular_icon.dart';
import 'package:flourish/src/features/authentication/screens/home/widget/curved_edge_widget.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/image_strings.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class ProductDetailImageSlider extends StatelessWidget {
  const ProductDetailImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    return CurvedEdgeWidget(
      child: Container(
        color: isDark ? slate600 : light,
        child: Stack(
          children: [
            // MAIN LARGE IMAGE
            const SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(child: Image(image: AssetImage(loginImage))),
                )),

            // IMAGE SLIDER
            Positioned(
              left: defaultSize,
              bottom: 30,
              right: 0,
              child: SizedBox(
                height: 60,
                child: ListView.separated(
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: spaceBtwItems),
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => RoundedImage(
                    imageUrl: loginImage,
                    width: 60,
                    backgroundColor: isDark
                        ? dark.withOpacity(0.2)
                        : slate400.withOpacity(0.2),
                    padding: const EdgeInsets.all(xs),
                    border: Border.all(
                        color: isDark
                            ? dark.withOpacity(0.6)
                            : slate400.withOpacity(0.6)),
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
                // title: Text(
                //   "HOME",
                //   style: Theme.of(context)
                //       .textTheme
                //       .headlineSmall!
                //       .apply(color: slate800, fontSizeFactor: 0.8),
                //   // style: TextStyle(
                //   //     fontWeight: FontWeight.w600, fontSize: 18),
                // ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: const [
                  CircularIcon(
                    icon: Icons.favorite,
                    size: 30,
                    iconColor: rose,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
