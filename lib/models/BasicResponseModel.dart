class BasicResponseModel {
  final int responseCode;
  final String responseMessage;

  BasicResponseModel({
    this.responseCode,
    this.responseMessage,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    return data;
  }

  factory BasicResponseModel.fromJson(Map<String, dynamic> json) {
    return BasicResponseModel(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
    );
  }
}
