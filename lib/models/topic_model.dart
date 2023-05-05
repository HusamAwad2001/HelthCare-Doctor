class TopicModel {
  String? id;
  String title;
  String description;
  String logo;
  String image;

  TopicModel({
    this.id,
    required this.title,
    required this.description,
    required this.logo,
    required this.image,
  });


  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      logo: json["logo"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "logo": logo,
      "image": image,
    };
  }
}
