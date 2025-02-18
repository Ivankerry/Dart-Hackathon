bool isPalindrome(dynamic input) {
  String str;

  if (input is int) {
    str = input.toString();
  } else if (input is String) {
    str = input;
  } else {
    throw FormatException("Input must be a string or an integer.");
  }

  // 1. Convert to lowercase and remove non-alphanumeric characters
  String cleanStr = str
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w\s]'), '') // Remove punctuation
      .replaceAll(' ', ''); // Remove spaces


  // 2. Check if the cleaned string is a palindrome
  int left = 0;
  int right = cleanStr.length - 1;

  while (left < right) {
    if (cleanStr[left] != cleanStr[right]) {
      return false; // Not a palindrome
    }
    left++;
    right--;
  }

  return true; // It's a palindrome
}



void main() {
  print(isPalindrome("racecar")); // true
  print(isPalindrome("A man, a plan, a canal: Panama")); // true
  print(isPalindrome("hello")); // false
  print(isPalindrome(12321)); // true
  print(isPalindrome(12345)); // false
  print(isPalindrome("Madam, in Eden, I'm Adam")); // true
  try {
    print(isPalindrome(true)); // Test with a boolean
  } catch (e) {
    print(e); // Output: FormatException: Input must be a string or an integer.
  }

}
