import 'dart:math';

import 'package:counter_app/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../counter_functions.dart';
import '../model/counter_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Counter> _counters = [];
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadDataAndUpdateState();
  }

  void loadDataAndUpdateState() async {
    await loadData(_counters);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: _counters.isEmpty
          ? const Center(child: Text("Add your custom counters"))
          : ListView.builder(
              itemCount: _counters.length,
              itemBuilder: (context, index) {
                Color randomColor = generateRandomColor(index);
                return _buildCounter(_counters[index], randomColor);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AwesomeDialog(
            dialogBackgroundColor: Colors.grey.shade900,
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.noHeader,
            btnCancelText: "Cancel",
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const Text(
                    "Add Counter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: _titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              addCounter(_counters, _titleController.text);
              saveData(_counters);
              _titleController.clear();
              setState(() {});
            },
            width: MediaQuery.of(context).size.width * 0.9,
          ).show();
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCounter(Counter counter, randomColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          counter.title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: randomColor),
          ),
          width: MediaQuery.of(context).size.width * 0.7,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CounterDetailScreen(
                        counter: counter,
                        randomColor: randomColor,
                        counters: _counters)),
              ).then((_) {
                setState(() {});
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: randomColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        counter.count++;
                        saveData(_counters);
                      });
                    },
                  ),
                ),
                Text(
                  counter.count.toString(),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: randomColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: IconButton(
                    icon: const Icon(
                      Icons.remove,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (counter.count > 0) {
                          counter.count--;
                          saveData(_counters);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15)
      ],
    );
  }
}
