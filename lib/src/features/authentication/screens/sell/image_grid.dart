import 'dart:io';

import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageGridWidget extends StatelessWidget {
  final List<XFile> imageFiles;
  final Function(XFile) onImageAdded;
  final Function(int) onImageRemoved;
  final Function() showImagePicker;

  static const int maxImages = 4;
  static const int minImages = 1;

  const ImageGridWidget({
    super.key,
    required this.imageFiles,
    required this.onImageAdded,
    required this.onImageRemoved,
    required this.showImagePicker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      // padding: const EdgeInsets.only(
      //     left: defaultSize, right: defaultSize, top: defaultSize / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Product Images',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.apply(color: slate600)),
              Text(
                '${imageFiles.length}/$maxImages',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                    ),
              ),
            ],
          ),
          // const SizedBox(height: spaceBtwItems / 2),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: imageFiles.length < maxImages
                ? imageFiles.length + 1
                : imageFiles.length,
            itemBuilder: (context, index) {
              if (index == imageFiles.length && imageFiles.length < maxImages) {
                return _buildAddImageButton(context);
              }
              return _buildImageTile(context, index);
            },
          ),
          if (imageFiles.isEmpty) ...[
            const SizedBox(height: spaceBtwItems),
            Text(
              'Add at least one product image',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.apply(color: rose.withOpacity(0.8)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddImageButton(BuildContext context) {
    return InkWell(
      onTap: imageFiles.length < maxImages ? showImagePicker : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: slate400.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: slate800.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_rounded,
              color: slate600.withOpacity(0.6),
              size: 30,
            ),
            const SizedBox(height: spaceBtwItems / 4),
            Text('Add Image',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.apply(color: slate600.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }

  Widget _buildImageTile(BuildContext context, int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            File(imageFiles[index].path),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Material(
            color: light,
            elevation: 0,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () {
                if (imageFiles.length > minImages) {
                  onImageRemoved(index);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('At least one image is required'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.close_rounded,
                  size: 16,
                  color: rose.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
