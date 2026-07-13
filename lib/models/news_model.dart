class SourceModel {
  String? id, name;

  SourceModel({
    required this.id,
    required this.name
  });

  factory SourceModel.fromJson(Map<String, dynamic> json){
    return SourceModel(
        id: json["id"] ?? " ",
        name: json["name"]?? " ");
  }
}

class ArticleModel {
  String? author, content, description, publishedAt, title, url, urlToImage;
  SourceModel? sourceModel;

  ArticleModel({
    required this.author,
    required this.content,
    required this.description,
    required this.url,
    required this.publishedAt,
    required this.sourceModel,
    required this.title,
    required this.urlToImage
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json){
    return ArticleModel(
        author: json["author"] ?? "",
        content: json["content"] ?? " ",
        description: json["description"] ?? "",
        url: json["url"] ?? "",
        publishedAt: json["publishedAt"] ?? "",
        sourceModel: json["source"] != null ? SourceModel.fromJson(json["source"]) : null,
        title: json["title"] ?? "",
        urlToImage: json["urlToImage"] ?? "");
  }
}