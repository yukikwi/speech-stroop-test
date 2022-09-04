String toReadableTime(int milliseconds) {
  int minutes = (milliseconds / 60000).floor();
  int seconds = ((milliseconds % 60000) / 1000).floor();

  String result = (minutes < 10 ? "0" : "") +
      minutes.toString() +
      ":" +
      (seconds < 10 ? "0" : "") +
      seconds.toString();
  return result;
}
