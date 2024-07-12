import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/view_models/post_form_vm.dart';

class AddPhotoListView extends ConsumerWidget {
  const AddPhotoListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postFormVm = ref.read(postFormProvider.notifier);
    final images = ref.watch(postFormProvider).images;

    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Sizes.size5,
                  ),
                ),
                child: Image.file(
                  images[index],
                ),
              ),
              Positioned(
                top: Sizes.size2,
                right: Sizes.size6,
                child: GestureDetector(
                  onTap: () => postFormVm.onRemovePhoto(index),
                  child: Container(
                    alignment: Alignment.center,
                    width: Sizes.size24,
                    height: Sizes.size32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.x,
                      color: Colors.white,
                      size: Sizes.size12,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => Gaps.h10,
        itemCount: images.length,
      ),
    );
  }
}
