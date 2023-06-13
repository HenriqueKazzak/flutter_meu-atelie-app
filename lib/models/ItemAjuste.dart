class ItemAjuste{
  String nome = '';
  double custo = 0.0;
  bool selecionado =false;

  ItemAjuste(this.nome, this.custo);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['custo'] = this.custo;
    data['selecionado'] = this.selecionado;
    return data;
  }

  @override
  String toString() {
    return 'ItemAjuste{nome: $nome, custo: $custo, selecionado: $selecionado}';
  }

}