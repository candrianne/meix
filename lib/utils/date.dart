String parseDate(String date) {
  var day = date.split("-")[2];
  var month =  date.split("-")[1];
  var year = date.split("-")[0];

  return '$day/$month/$year';
}