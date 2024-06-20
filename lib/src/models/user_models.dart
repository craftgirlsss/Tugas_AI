class UserModels {
  int? id;
  String? createdAt;
  String? nama, nim, email, password, uuid, image;

  UserModels(
      {this.id,
      this.nama,
      this.nim,
      this.createdAt,
      this.email,
      this.password,
      this.uuid,
      this.image
      });

  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      id: json['id'],
      nama: json['nama'],
      nim: json['nim'],
      email: json['email'] ?? '-',
      password: json['password'],
      createdAt: json['created_at'] ?? 0,
      uuid: json['uuid'],
      image: json['image']
    );
  }
}