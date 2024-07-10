import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';
import 'package:mood_tracker/features/posts/view_models/post_form_vm.dart';
import 'package:mood_tracker/features/posts/views/widgets/emotion_card_button.dart';
import 'package:mood_tracker/features/profile/views/widgets/profile_button.dart';

class PostAddScreen extends ConsumerStatefulWidget {
  const PostAddScreen({super.key});

  @override
  ConsumerState<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends ConsumerState<PostAddScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int currentIndex = 0;

  static const List<Mood> emotionsList = [
    Mood.anger,
    Mood.joy,
    Mood.sadness,
    Mood.anxiety,
    Mood.disgust,
    Mood.shame,
    Mood.ennui,
    Mood.envy,
    Mood.fear,
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onTapEmotionButton(int index) {
    ref.read(postFormProvider.notifier).updateEmotion(emotionsList[index]);
    setState(() {
      currentIndex = index;
    });
  }

  void _onChangeTitle(value) {
    if (value != null) {
      ref.read(postFormProvider.notifier).updateTitle(value);
    }
  }

  void _onChangeDescription(value) {
    if (value != null) {
      ref.read(postFormProvider.notifier).updateDescription(value);
    }
  }

  Future<void> _onTapPostImage() async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 500,
      maxHeight: 500,
    );

    if (xfile != null) {
      // final file = File(xfile.path);
      // ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.size24,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Express Yourself',
                            style: TextStyle(
                              fontSize: Sizes.size22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gaps.v14,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'How Are You Feeling Today?',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v10,
                    SizedBox(
                      height: Sizes.size80 + Sizes.size10,
                      child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size24,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return EmotionCardButton(
                              onTap: () => _onTapEmotionButton(index),
                              emotion: emotionsList[index],
                              isCurrent: currentIndex == index,
                            );
                          },
                          separatorBuilder: (context, index) => Gaps.h10,
                          itemCount: emotionsList.length),
                    ),
                    Gaps.v10,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size24,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _titleController,
                            maxLength: 24,
                            onChanged: _onChangeTitle,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(
                                Sizes.size8,
                              ),
                              counterText: '',
                              hintText: 'What\'s on your mind?',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Gaps.v10,
                          TextFormField(
                            controller: _descriptionController,
                            maxLines: 4,
                            onChanged: _onChangeDescription,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(
                                Sizes.size8,
                              ),
                              hintText: 'Share your story...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: _onTapPostImage,
                              icon: FaIcon(
                                FontAwesomeIcons.paperclip,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                          Gaps.v10,
                          ProfileButton(
                            onTap: () async {
                              print(ref.read(postFormProvider).emotion);
                            },
                          )
                        ],
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
