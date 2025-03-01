import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/constants/emotions.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/auth/views/widgets/add_photo_icons_buttons.dart';
import 'package:mood_tracker/features/posts/view_models/post_add_vm.dart';
import 'package:mood_tracker/features/posts/view_models/post_form_vm.dart';
import 'package:mood_tracker/features/posts/views/widgets/add_photo_list_view.dart';
import 'package:mood_tracker/features/posts/views/widgets/emotion_card_button.dart';
import 'package:mood_tracker/features/posts/views/widgets/post_add_input.dart';
import 'package:mood_tracker/features/posts/views/widgets/post_save_button.dart';

class PostAddScreen extends ConsumerStatefulWidget {
  const PostAddScreen({super.key});

  static const String routeUrl = '/post/add';
  static const String routeName = 'postAdd';

  @override
  ConsumerState<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends ConsumerState<PostAddScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _onPressSave() async {
    final isLoading = ref.watch(postAddProvider).isLoading;

    if (!isLoading && _formKey.currentState!.validate()) {
      ref.read(postAddProvider.notifier).createPost(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final postFormVm = ref.read(postFormProvider.notifier);

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gaps.v20,
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.size24,
                      ),
                      child: Text(
                        'Express Yourself',
                        style: TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Gaps.v10,
                    SizedBox(
                      height: Sizes.size72 + Sizes.size4,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size24,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return EmotionCardButton(
                            onTap: () => {
                              postFormVm.update(emotion: emotionsList[index]),
                              postFormVm.currentIndex = index
                            },
                            emotion: emotionsList[index],
                            isCurrent: postFormVm.currentIndex == index,
                          );
                        },
                        separatorBuilder: (context, index) => Gaps.h10,
                        itemCount: emotionsList.length,
                      ),
                    ),
                    Gaps.v10,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size24,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            PostAddInput(
                              onChanged: (title) =>
                                  postFormVm.update(title: title),
                              controller: _titleController,
                              hintText: 'What\'s on your mind?',
                              maxLength: 24,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return 'A title for your mood today is required.';
                                }
                                return null;
                              },
                            ),
                            Gaps.v10,
                            PostAddInput(
                              onChanged: (description) =>
                                  postFormVm.update(description: description),
                              controller: _descriptionController,
                              hintText: 'Share your story...',
                              maxLines: 4,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return 'A description of your mood is required.';
                                }
                                return null;
                              },
                            ),
                            if (ref.watch(postFormProvider).images.length != 3)
                              const AddPhotoIconsButtons(),
                            // Gaps.v10,
                            if (ref
                                .watch(postFormProvider)
                                .images
                                .isNotEmpty) ...[
                              Gaps.v10,
                              const AddPhotoListView(),
                              Gaps.v10,
                            ],
                            PostSaveButton(onTap: _onPressSave),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
