class Hadith {
  const Hadith({
    required this.number,
    required this.title,
    required this.body,
  });

  final int number;
  final String title;
  final String body;

  String get englishTitle => 'Hadith $number';
}
