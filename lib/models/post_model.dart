class ReactionModel {
  int? likes, dislikes;

  ReactionModel({
    required this.likes,
    required this.dislikes
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json){
    return ReactionModel(
        likes: json['likes'],
        dislikes: json['dislikes']);
  }
}

class PostModel {
  int? id, views, userId;
  String? title, body;
  List<dynamic>? tags;
  ReactionModel? reactions;

  PostModel({
    required this.id,
    required this.views,
    required this.userId,
    required this.title,
    required this.body,
    required this.reactions,
    required this.tags
  });

  factory PostModel.fromJson(Map<String, dynamic> json){
    return PostModel(
        id: json['id'],
        views: json['views'],
        userId: json['userId'],
        title: json['title'],
        body: json['body'],
        reactions: ReactionModel.fromJson(json['reactions']),
        tags: json['tags']);
  }
}