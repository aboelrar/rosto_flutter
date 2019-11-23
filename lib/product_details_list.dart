class product_details_list{
  String _image,_name,_id,_descripition,_size,_price;

  product_details_list(this._image, this._name, this._id, this._descripition,
      this._size, this._price);

  get price => _price;

  set price(value) {
    _price = value;
  }

  get size => _size;

  set size(value) {
    _size = value;
  }

  get descripition => _descripition;

  set descripition(value) {
    _descripition = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }


}