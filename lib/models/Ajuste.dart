import 'ItemAjuste.dart';

class Ajuste{
  double valorTotal = 0.0;
  String nome = '';
  String descricao = '';
  List<ItemAjuste> ajustes = <ItemAjuste>[];

  @override
  String toString() {
    return 'Ajuste{valorTotal: $valorTotal, nome: $nome, descricao: $descricao, ajustes: $ajustes}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valorTotal'] = this.valorTotal;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['ajustes'] = this.ajustes.map((v) => v.toJson()).toList();
    return data;
  }
}