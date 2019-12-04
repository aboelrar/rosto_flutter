class home_list{
   String _id,_name,_descripition,_phone;

   home_list(this._id, this._name, this._descripition,this._phone);

   get descripition => _descripition;

   set descripition(value) {
     _descripition = value;
   }

   get name => _name;

   set name(value) {
     _name = value;
   }

   String get id => _id;

   set id(String value) {
     _id = value;
   }

   get phone => _phone;

   set phone(value) {
     _phone = value;
   }


}