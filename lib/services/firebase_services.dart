import 'package:assist_web/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getChatDocument(String chatId) async {
    return await _firestore.collection('chats').doc(chatId).get();
  }

  Stream<List<Message>> getChatMessages(String chatId) {
    try {
      return _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList(),
          );
    } catch (e) {
      throw 'Failed to fetch chat messages: $e';
    }
  }

  Future<void> sendMessage(
    String chatId,
    Message message,
    ChatModel chatInfo,
    String receiverId,
  ) async {
    try {
      DocumentReference chatRef = _firestore.collection('chats').doc(chatId);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot chatSnapshot = await transaction.get(chatRef);

        if (!chatSnapshot.exists) {
          transaction.set(chatRef, chatInfo.toJson());
        }

        DocumentReference messageRef = chatRef.collection('messages').doc();
        transaction.set(messageRef, {
          'senderId': message.senderId,
          'text': message.text,
          'imageUrls': message.imageUrls,
          'timestamp': message.timestamp,
        });

        Map<String, dynamic> updates = {
          'lastMessage': {
            'message':
                message.text.isNotEmpty ? message.text : 'Sent an attachment',
            'time': message.timestamp.toIso8601String(),
            'id': message.senderId,
          },
        };

        transaction.update(chatRef, updates);
      });
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Future<void> updateParticipantImageUrl({
    required String userId,
    required String newImageUrl,
  }) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('chats')
              .where('participantIds', arrayContains: userId)
              .get();

      for (var doc in querySnapshot.docs) {
        final chatData = doc.data();
        final participants = List<Map<String, dynamic>>.from(
          chatData['participants'] ?? [],
        );

        // Update the participant's image URL if their userId matches
        final updatedParticipants =
            participants.map((participant) {
              if (participant['userId'] == userId) {
                return {...participant, 'imageUrl': newImageUrl};
              }
              return participant;
            }).toList();

        // Update Firestore document
        await _firestore.collection('chats').doc(doc.id).update({
          'participants': updatedParticipants,
        });
      }
    } catch (e) {
      throw Exception('Failed to update participant image URL: $e');
    }
  }
}
