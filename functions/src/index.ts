import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const onPostCreated = functions.firestore
  .document("posts/{postId}")
  .onUpdate(async (snapshot, context) => {
    try {
      const post = snapshot.after.data();
      const db = admin.firestore();
      const postId = context.params.postId;

      await db
        .collection("users")
        .doc(post.creatorUid)
        .collection("posts")
        .doc(postId)
        .set({
          name: post.creator,
          postId: postId,
          title: post.title,
          description: post.description,
          emotion: post.emotion,
          createdAt: post.createdAt,
          images: post.images,
        });
    } catch (error) {
      console.log(error);
    }
  });
