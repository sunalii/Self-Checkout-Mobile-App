class Item {
  String name;
  String barcode;
  double price;
  double weight;
  int quantity;
  String photo;

  Item({this.name,this.barcode, this.price, this.quantity, this.photo, this.weight});

  // Item.fromMap(Map map)
  //     : this.name = map['name'],
  //       this.barcode = map['barcode'],
  //       this.price = map['price'],
  //       this.quantity = map['quantity'],
  //       this.photo = map['photo'],
  //       this.weight = map['weight'];
  //
  // Map toMap() {
  //   return {
  //     'name': this.name,
  //     'barcode': this.barcode,
  //     'price': this.price,
  //     'quantity': this.quantity,
  //     'photo': this.photo,
  //     'weight': this.weight,
  //   };
  // }
}
