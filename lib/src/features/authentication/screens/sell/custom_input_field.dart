import 'package:flutter/material.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final Widget child;
  final bool isRequired;
  final String? helperText;
  final EdgeInsetsGeometry? padding;

  const CustomInputField({
    super.key,
    required this.label,
    required this.child,
    this.isRequired = false,
    this.helperText,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      // padding: padding ??
      //     const EdgeInsets.only(
      //       left: defaultSize,
      //       right: defaultSize,
      //       top: defaultSize / 2,
      //     ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.apply(color: slate600),
                  ),
                  if (isRequired) ...[
                    const SizedBox(width: 4),
                    Text(
                      '*',
                      style: Theme.of(context).textTheme.titleMedium?.apply(
                            color: rose,
                          ),
                    ),
                  ],
                ],
              ),
              if (helperText != null)
                Text(
                  helperText!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: slate600.withOpacity(0.6),
                      ),
                ),
            ],
          ),
          const SizedBox(height: spaceBtwItems / 2),
          Container(
            decoration: BoxDecoration(
                // color: slate400.withOpacity(0.1),
                // borderRadius: BorderRadius.circular(10),
                // border: Border.all(
                //   color: slate800.withOpacity(0.1),
                //   width: 1,
                // ),

                ),
            // child: Padding(
            // padding: const EdgeInsets.symmetric(
            //   horizontal: defaultSize,
            //   vertical: defaultSize / 2,
            // ),
            child: child,
            // ),
          ),
        ],
      ),
    );
  }
}
