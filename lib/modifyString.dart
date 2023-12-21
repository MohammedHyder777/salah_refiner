String insertStringBetweenLetters(String input, String inserted) {
  // Split the input string into words
  List<String> words = input.split(' ');

  // Create a new list to store the modified words
  List<String> modifiedWords = [];

  // Iterate through each word
  for (String word in words) {
    // Split the word into individual letters
    List<String> letters = word.split('');

    // Create a new list to store the modified letters
    List<String> modifiedLetters = [];

    // Iterate through each letter
    for (int i = 0; i < letters.length; i++) {
      // Add the current letter to the modified letters list
      modifiedLetters.add(letters[i]);

      // If there is at least one more letter after the current letter
      if (i < letters.length - 1) {
        // Add the desired pattern ([ًٍَُِّّْ]*ل) between the letters
        modifiedLetters.add(inserted);
      }
    }

    // Add the desired pattern ([ًٍَُِّّْ]*) after the last letter of the word
    modifiedLetters.add("[ًٍَُِّّْ]*");

    // Join the modified letters to form the modified word
    String modifiedWord = modifiedLetters.join('');

    // Add the modified word to the list of modified words
    modifiedWords.add(modifiedWord);
  }

  // Join the modified words to form the modified string
  String modifiedString = modifiedWords.join(' ');

  // Return the modified string
  return modifiedString;
}