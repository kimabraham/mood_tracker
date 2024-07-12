import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/posts/view_models/post_form_vm.dart';

class NavigationIndexState extends StateNotifier<int> {
  NavigationIndexState(this.ref) : super(0);

  final Ref ref;

  void setIndex(int index) {
    if (index == 1) {
      ref.read(postFormProvider.notifier).reset();
    }
    state = index;
  }
}

final navigationProvider = StateNotifierProvider<NavigationIndexState, int>(
  (ref) => NavigationIndexState(ref),
);
