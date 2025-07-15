import 'package:cloud_firestore/cloud_firestore.dart';

class Participant {
  final String userId;
  final String name;
  final String imageUrl;

  Participant({
    required this.userId,
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'name': name, 'imageUrl': imageUrl};
  }

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      userId: json['userId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}

class ChatModel {
  final String chatId;
  final List<Participant> participants;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String lastMessageSenderId;
  final List<String> participantIds;

  ChatModel({
    required this.chatId,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageSenderId,
    required this.participantIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'participants': participants.map((p) => p.toJson()).toList(),
      'participantIds': participantIds,
      'lastMessage': {
        'message': lastMessage,
        'time': lastMessageTime.toIso8601String(),
        'id': lastMessageSenderId,
      },
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final lastMessageData = json['lastMessage'] as Map<String, dynamic>;
    return ChatModel(
      chatId: json['chatId'],
      participants:
          (json['participants'] as List<dynamic>)
              .map((item) => Participant.fromJson(item))
              .toList(),
      lastMessage: lastMessageData['message'] ?? '',
      lastMessageTime: DateTime.parse(lastMessageData['time']),
      lastMessageSenderId: lastMessageData['id'] ?? '',
      participantIds: List<String>.from(json['participantIds']),
    );
  }

  Participant getOtherParticipant(String currentUserId) {
    return participants.firstWhere((p) => p.userId != currentUserId);
  }
}

class Message {
  final String id;
  final String senderId;
  final String text;
  final List<dynamic> imageUrls;
  final DateTime timestamp;
  final bool isUploading;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    this.imageUrls = const [],
    required this.timestamp,
    this.isUploading = false,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      text: data['text'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      isUploading: data['isUploading'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'text': text,
      'imageUrls': imageUrls,
      'timestamp': Timestamp.fromDate(timestamp),
      'isUploading': isUploading,
    };
  }
}
