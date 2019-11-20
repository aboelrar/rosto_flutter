class product_list {
  String _image,_id,_title,_price;

  product_list(this._image, this._id, this._title, this._price);

  get price => _price;

  set price(value) {
    _price = value;
  }

  get title => _title;

  set title(value) {
    _title = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

}