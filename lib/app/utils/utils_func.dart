double parseDouble(dynamic value) {
  final str = value.toString().replaceAll(' ', '');
  return double.parse(str);
}

String toShortDate(String date) {
  final splitted = date.split('-');

  return '${splitted[2]}/${splitted[1]}';
}