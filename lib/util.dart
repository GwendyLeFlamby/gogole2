import 'dart:math';
import 'package:flutter/material.dart';

String gogolize(String stringToGogolize) {
  String result = "";

  stringToGogolize.split(" ").forEach((element) {
    result = result + _gogolizeWord(element) + " ";
  });

  return result;
}

String _gogolizeWord(String wordToGogolize) {
  if (wordToGogolize.length <= 1) return wordToGogolize;

  int randomIndex = Random().nextInt(wordToGogolize.length - 1);

  bool isFirstLetterBig = false;
  if (wordToGogolize.characters.characterAt(0).toUpperCase() ==
      wordToGogolize.characters.characterAt(0)) {
    isFirstLetterBig = true;
  }
  wordToGogolize = wordToGogolize.toLowerCase();

  Characters charWordToGogolize = Characters(wordToGogolize);
  Characters firstChar = charWordToGogolize.characterAt(randomIndex);
  Characters secondChar = charWordToGogolize.characterAt(randomIndex + 1);
  String firstPart = "";
  String lastPart = "";

  if (randomIndex != 0) {
    firstPart = wordToGogolize.substring(0, randomIndex);
  }
  if (randomIndex != wordToGogolize.length - 2) {
    lastPart = wordToGogolize.substring(randomIndex + 2, wordToGogolize.length);
  }

  String result = firstPart + secondChar.string + firstChar.string + lastPart;

  if (isFirstLetterBig) {
    return result[0].toUpperCase() + result.substring(1);
  } else {
    return result;
  }
}
