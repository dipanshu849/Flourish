import 'package:flutter/material.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';

class CustomCategoriesField extends StatelessWidget {
  final String label;
  final List<String> availableCategories;
  final List<String> selectedCategories;
  final Function(String, bool) onCategorySelected;
  final EdgeInsetsGeometry? padding;

  const CustomCategoriesField({
    super.key,
    required this.label,
    required this.availableCategories,
    required this.selectedCategories,
    required this.onCategorySelected,
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
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.apply(color: slate600),
              ),
              Text(
                '${selectedCategories.length} selected',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: slate600.withOpacity(0.6),
                    ),
              ),
            ],
          ),
          const SizedBox(height: spaceBtwItems / 2),
          Container(
            decoration: BoxDecoration(
              color: slate400.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: slate800.withOpacity(0.1),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(defaultSize),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: availableCategories.map((category) {
                final isSelected = selectedCategories.contains(category);
                return FilterChip(
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? light : slate800,
                      fontSize: 12,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    onCategorySelected(category, selected);
                  },
                  backgroundColor: isSelected ? slate600 : light,
                  selectedColor: slate600,
                  checkmarkColor: light,
                  elevation: 0,
                  pressElevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.transparent
                          : slate800.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultSize / 2,
                    vertical: defaultSize / 4,
                  ),
                );
              }).toList(),
            ),
          ),
          if (selectedCategories.isEmpty) ...[
            const SizedBox(height: spaceBtwItems),
            Text(
              'Select at least one category',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: rose.withOpacity(0.8),
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
