class Participant {
  int? id;
  String name;
  String email;
  String phone;
  String city;

  Participant({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
  });

  // convert to map untuk disimpan ke DB
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'city': city,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  // buat object dari map DB
  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      city: map['city'] as String,
    );
  }
}
