
class NewsModel{
  String author;
  String title;
   NewsModel(
       {required this.author, required this.title}
      );
  factory NewsModel.fromJson(Map<String,dynamic> json){
    return NewsModel(
        author:json['author'],
        title:json['title']
    );

  }
  Map<String,dynamic> toJson(){
    Map<String,dynamic> json={
      "author":author,
      "title":title
    };
    return json;
  }
}