import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/counter_model.dart';

Color generateRandomColor(int index) {
  Random random = Random(index); 
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

Future<void> loadData(List<Counter> counters) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? titles = prefs.getStringList('titles');
  List<String>? counts = prefs.getStringList('counts');

  if (titles != null && counts != null) {
    counters.clear();
    counters.addAll(List.generate(titles.length,
        (index) => Counter(titles[index], count: int.parse(counts[index]))));
  }
}

Future<void> saveData(List<Counter> counters) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> titles = counters.map((counter) => counter.title).toList();
  List<String> counts =
      counters.map((counter) => counter.count.toString()).toList();

  await prefs.setStringList('titles', titles);
  await prefs.setStringList('counts', counts);
}

void addCounter(List<Counter> counters, String title) {
  counters.add(Counter(title));
}

void deleteCounter(Counter counter, List<Counter> counters) async {
  counters.remove(counter);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? titles = prefs.getStringList('titles');
  List<String>? counts = prefs.getStringList('counts');

  if (titles != null && counts != null) {
    titles.remove(counter.title);
    counts.remove(counter.count.toString());

    await prefs.setStringList('titles', titles);
    await prefs.setStringList('counts', counts);
  }
}
