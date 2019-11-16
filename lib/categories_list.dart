class categories_list{
  String _image,_title,_desc,_num;

  categories_list(this._image, this._title, this._desc, this._num);

  get num => _num;

  set num(value) {
    _num = value;
  }

  get desc => _desc;

  set desc(value) {
    _desc = value;
  }

  get title => _title;

  set title(value) {
    _title = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }


}