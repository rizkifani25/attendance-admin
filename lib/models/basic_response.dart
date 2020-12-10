class BasicResponse {
  int responseCode;
  String responseMessage;
  Object data;

  BasicResponse({this.responseCode, this.responseMessage, this.data});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['data'] = this.data;
    return data;
  }

  factory BasicResponse.fromJson(Map<String, dynamic> json) {
    return BasicResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      data: json['data'],
    );
  }

  @override
  String toString() => 'BasicResponse(responseCode: $responseCode, responseMessage: $responseMessage, data: $data)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BasicResponse && o.responseCode == responseCode && o.responseMessage == responseMessage && o.data == data;
  }

  @override
  int get hashCode => responseCode.hashCode ^ responseMessage.hashCode ^ data.hashCode;
}
