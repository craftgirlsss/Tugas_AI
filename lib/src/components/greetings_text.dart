String greeting() {
  var hour = DateTime.now().hour;
  if (hour >= 4 && hour < 11) {
    return 'Enjing';
  }
  if (hour > 11 && hour < 14) {
    return 'Siang';
  }
  if(hour > 14 && hour < 19){
    return 'Sore';
  }
  return 'Dalu';
}