class CustomUtils {
 static bool validatePrefixIsHttpOrHttps(String fileUrl) {
    if (!fileUrl.startsWith('http') && !fileUrl.startsWith('https'))
      return false;

    return true;
  }

  static bool validateFormatIsPngOrJpgOrJpeg(String fileFormat) {
    if (!fileFormat.endsWith('png') &&
        !fileFormat.endsWith('jpg') &&
        !fileFormat.endsWith('jpeg')) return false;

    return true;
  }
}
