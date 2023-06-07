class TimeFormat {
  static String formattedTime(int timeInSecond) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }

  static String getElapsedTime(DateTime time) {
    String result = '';
    DateTime currentTime = DateTime.now();
    final duration = currentTime.difference(time);
    if (duration.inDays == 0 && duration.inHours == 0) {
      result = '${duration.inMinutes} mins ago';
    } else if (duration.inDays == 0 && duration.inHours != 0) {
      result = '${duration.inHours} hours ago';
    } else if (duration.inDays != 0 ) {
      result = '${duration.inDays} days ago';
    }
    return result;
  }
}
