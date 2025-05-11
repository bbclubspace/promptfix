class AiModel {
  String prompt;
  String language = "";
  String result = "";
  bool isResultget;
  ContentType selectedContentType = ContentType.none;

  // Constructor
  AiModel({
    this.prompt = "",
    this.language = "Türkçe",
    this.selectedContentType = ContentType.code,
    this.isResultget=false,
  });

  void selectContentType(ContentType contentType) {
    selectedContentType = contentType;
  }
}

enum ContentType { none, visual, code, text }
