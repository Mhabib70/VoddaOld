class OrderDocumentFile {
  int? id;
  int? orderId;
  int? orderDocumentId;
  String? file;

  OrderDocumentFile(
      {this.id,
        this.orderId,
        this.orderDocumentId,
        this.file,
      });

  OrderDocumentFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDocumentId = json['order_document_id'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_document_id'] = this.orderDocumentId;
    data['file'] = this.file;
    return data;
  }
}
