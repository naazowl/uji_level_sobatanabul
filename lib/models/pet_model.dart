class PetModel {
  final String name;
  final String age;
  final String imagePath;
  final bool isLocalFile;
  final String breed;
  final String weight;
  final String gender;
  final String specialNotes;
  final String jenisHewan; // ✅ field baru

  const PetModel({
    required this.name,
    required this.age,
    required this.imagePath,
    this.isLocalFile = false,
    this.breed = '-',
    this.weight = '-',
    this.gender = 'Jantan',
    this.specialNotes = '-',
    this.jenisHewan = 'Anjing', // ✅ default Anjing
  });
}