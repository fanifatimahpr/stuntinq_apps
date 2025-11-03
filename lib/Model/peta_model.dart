/// Model untuk Health Facility
class PetaModel {
  final int id;
  final String name;
  final String type;
  final String distance;
  final String address;
  final String phone;
  final String hours;
  final double rating;
  final bool isOpen;

  PetaModel({
    required this.id,
    required this.name,
    required this.type,
    required this.distance,
    required this.address,
    required this.phone,
    required this.hours,
    required this.rating,
    required this.isOpen,
  });
}
