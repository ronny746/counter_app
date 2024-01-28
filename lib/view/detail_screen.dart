import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../counter_functions.dart';
import '../model/counter_model.dart';

class CounterDetailScreen extends StatefulWidget {
  final Counter counter;
  final Color randomColor;
  final List<Counter> counters;

  CounterDetailScreen({
    required this.counter,
    required this.randomColor,
    required this.counters,
  });

  @override
  _CounterDetailScreenState createState() => _CounterDetailScreenState();
}

class _CounterDetailScreenState extends State<CounterDetailScreen> {
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> titles = [widget.counter.title];
    List<String> counts = [widget.counter.count.toString()];

    await prefs.setStringList('titles', titles);
    await prefs.setStringList('counts', counts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.counter.title,style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30
        ),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            AwesomeDialog(
              dialogBackgroundColor: Colors.grey.shade900,
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.question,
              btnCancelText: "No",
             btnOkText: "Yes",
             titleTextStyle: TextStyle(
               color: Colors.white,
               fontSize: 20,
               fontWeight: FontWeight.bold
             ),
             descTextStyle: TextStyle(
               color: Colors.white,
               fontSize: 16
             ),
             title: "Delete",
              desc: "Are you sure, you want to delete this counter",
              btnCancelOnPress: () {},
              btnOkOnPress: () async{
                deleteCounter(widget.counter, widget.counters);
                Navigator.pop(context);
                setState(() {});
              },
              width: MediaQuery.of(context).size.width * 0.9,
            ).show();
          },
              icon: Icon(Icons.delete_outline_outlined,size: 35,
                  color: widget.randomColor,))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 150,),
          Text(
            '${widget.counter.count}',
            style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 80,
                    color: widget.randomColor,
                    child: IconButton(
                      icon: Icon(Icons.add,color: Colors.white,size: 40,),
                      onPressed: () {
                        setState(() {
                          widget.counter.count++;
                          _saveData();
                        });
                      },
                    ),
                  ),
                ),
                VerticalDivider(color: Colors.white,width: 2,),
                Expanded(
                  child: Container(
                    height: 80,
                    color: widget.randomColor,
                    child: IconButton(
                      icon: Icon(Icons.remove,color: Colors.white,size: 40,),
                      onPressed: () {
                        setState(() {
                          if (widget.counter.count > 0) {
                            widget.counter.count--;
                            _saveData();
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
