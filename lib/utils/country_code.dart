class CountryCode {
  static String getCountryCodeFromString(String country) {
    String result = '';
    switch (country) {
      case 'US':
        result = '+1';
        break;
      case 'UK':
        result = '+44';
        break;
      case 'IN':
        result = '+91';
        break;
    }
    return result;
  }
  static String getStringFromCountryCode(String country) {
    String result = '';
    switch (country) {
      case '+1':
        result = 'US';
        break;
      case '+44':
        result = 'UK';
        break;
      case '+91':
        result = 'IN';
        break;
    }
    return result;
  }
}
