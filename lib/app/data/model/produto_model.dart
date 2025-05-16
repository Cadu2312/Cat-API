class CatModel {
  Map<String, dynamic>? weight;
  String? imperial_weight;
  String? metric_weight;
  String? id;
  String? name;
  String? temperament;
  String? origin;
  String? description;
  String? life_span;
  Map<String, dynamic>? image;
  String? image_reference_id;
  String? url;
  String? url_imagem;

  CatModel(
      {this.weight,
      this.imperial_weight,
      this.metric_weight,
      this.id,
      this.name,
      this.temperament,
      this.origin,
      this.description,
      this.life_span,
      this.image,
      this.image_reference_id,
      this.url,
      this.url_imagem});

  factory CatModel.fromMap(Map<String, dynamic> map) {
    return CatModel(
      weight: map['weight'],
      imperial_weight: map['weight']['imperial'],
      metric_weight: map['weight']['metric'],
      id: map['id'],
      name: map['name'],
      temperament: map['temperament'],
      origin: map['origin'],
      description: map['description'],
      life_span: map['life_span'],
      image: map['image'],
      image_reference_id: map["reference_image_id"],
      url: map['url'],
    );
  }
}
