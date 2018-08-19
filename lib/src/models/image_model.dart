
class ImageModel {

  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  ImageModel(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);

  ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    albumId = parsedJson['albumId'];
    id = parsedJson['id'];
    title = parsedJson['title'];
    url = parsedJson['url'];
    thumbnailUrl = parsedJson['thumbnailUrl'];
  }

  @override
  String toString() {
    return "{\n\talbumId: $albumId\n\tid: $id\n\ttitle: $title\n\turl: $url\n\tthumbnailUrl: $thumbnailUrl\n}";
  }

}