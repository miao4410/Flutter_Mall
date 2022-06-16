class Article {
  final String title;
  final String author;
  final String imageUrl;

  const Article({
    this.title = "",
    this.author = "",
    this.imageUrl = "",
  });
}

final List<Article> articles = [
  Article(title: "标题1", author: "作者1", imageUrl: ""),
  Article(title: "标题2 ", author: "作者2", imageUrl: ""),
  Article(title: "标题3", author: "作者3", imageUrl: ""),
];


class Category {
  final int id;
  final String name;
  final String image;

  const Category({
    this.id = 0,
    this.name = "",
    this.image = "",
  });

}

