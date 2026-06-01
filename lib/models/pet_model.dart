class PetModel {
  final String name;
  final String age;
  final String imagePath;
  final bool isLocalFile;
  
  // Tambahkan field opsional ini agar bisa menampung data dinamis dari form
  final String? breed;        // Untuk Ras / Jenis
  final String? weight;       // Untuk Berat Badan
  final String? gender;       // Untuk Jenis Kelamin
  final String? specialNotes; // Untuk Catatan Medis

  const PetModel({
    required this.name,
    required this.age,
    required this.imagePath,
    this.isLocalFile = false,
    this.breed,
    this.weight,
    this.gender,
    this.specialNotes,
  });
}