class TextHelper {

  static String capitalizeText(String name) {
    return name
        .trim()
        .split(" ")
        .map((word) => word.isNotEmpty
        ? "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}"
        : "")
        .join(" ");
  }

  static String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String truncateText(String text, {int maxLength = 50}) {
    if (text.length <= maxLength) {
      return text;
    }
    return "${text.substring(0, maxLength)}...";
  }
}
