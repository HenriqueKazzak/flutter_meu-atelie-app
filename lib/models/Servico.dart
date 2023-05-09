class Servico {
  late DateTime dataEntrega;
  late String status;

  Servico({required this.dataEntrega, required this.status});


  Servico.fromJson(Map<String, dynamic> json) {
    dataEntrega = json['dataEntrega']!;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataEntrega'] = this.dataEntrega;
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    return 'Servico{dataEntrega: $dataEntrega, status: $status}';
  }

}