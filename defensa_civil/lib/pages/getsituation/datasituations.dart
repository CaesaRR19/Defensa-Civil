class Situation {
  final String id;
  final String volunteer;
  final String title;
  final String description;
  final String photo;
  final String latitude;
  final String longitude;
  final String status;
  final String date;

  Situation({
    required this.id,
    required this.volunteer,
    required this.title,
    required this.description,
    required this.photo,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.date,
  });

  factory Situation.fromJson(Map<String, dynamic> json) {
    return Situation(
      id: json['id'],
      volunteer: json['voluntario'],
      title: json['titulo'],
      description: json['descripcion'],
      photo: json['foto'],
      latitude: json['latitud'],
      longitude: json['longitud'],
      status: json['estado'],
      date: json['fecha'],
    );
  }
}