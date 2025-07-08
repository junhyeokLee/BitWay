String getInitialSound(String input) {
  const List<String> initialConsonants = [
    'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ',
    'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ',
    'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'
  ];

  return input.split('').map((char) {
    final code = char.codeUnitAt(0);

    if (code >= 0xAC00 && code <= 0xD7A3) {
      // 한글 음절인 경우
      final index = ((code - 0xAC00) / 588).floor();
      return initialConsonants[index];
    } else {
      // 한글이 아닌 경우 그대로 반환
      return char;
    }
  }).join();
}