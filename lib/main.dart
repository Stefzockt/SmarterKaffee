import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'con2server.dart';

final ThemeData _dark = ThemeData.dark().copyWith(
  primaryColor: Colors.blueGrey,
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

void main() => runApp(MaterialApp(
      home: MyApp(),
      darkTheme: _dark,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Theme',
    ));

class _MyAppState extends State<MyApp> {
  late TimeOfDay time = TimeOfDay.now();
  late DateTime date = DateTime.now();
  late DateTime tempDate;
  late TimeOfDay tempTime;
  late String displayDate;
  late String displayTime;
  late bool dateCheck = false;
  late bool timeCheck = false;

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    ) as TimeOfDay;

    tempTime = newTime;
    timeCheck = true;
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      builder: (context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    ) as DateTime;

    tempDate = newDate;
    dateCheck = true;
  }

  void confirmCoffee(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("Bestätigen"),
          content: Text("Kaffee machen?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Nein")),
            TextButton(
                onPressed: () {
                  send("!makeCoffe");
                  Navigator.pop(context);
                },
                child: Text("Ja")),
          ]),
      barrierDismissible: false,
    );
  }

  void timerDialog(BuildContext context) {
    late DateTime now = DateTime.now();
    late DateTime selected =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    String timeString = DateFormat.Hm().format(selected);

    displayDate = (dateCheck == false)
        ? "Kein Datum gestgelegt"
        : "${date.day}.${date.month}.${date.year}";
    displayTime =
        (timeCheck == false) ? "Keine Uhrzeit festgelegt" : timeString;

    timeCheck = false;
    dateCheck = false;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              insetPadding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 700,
                child: Column(
                  children: [
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 50,
                        width: 150,
                        child: TextButton.icon(
                            onPressed: () {
                              pickDate(context);
                            },
                            icon: const Icon(Icons.calendar_today),
                            label: const Text("Datum auswählen")),
                      ),
                    )),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 50,
                          width: 150,
                          margin: const EdgeInsets.only(bottom: 100.0),
                          child: TextButton.icon(
                              onPressed: () {
                                pickTime(context);
                              },
                              icon: const Icon(Icons.watch_later),
                              label: const Text("Uhrzeit auswählen")),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 50,
                        width: 150,
                        margin: const EdgeInsets.only(bottom: 60.0),
                        child: TextButton.icon(
                            onPressed: () {
                              dateCheck = false;
                              timeCheck = false;
                              send("!RESET");
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text("Timer zurücksetzen")),
                      ),
                    )),
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      child: Text(
                        "Aktueller Timer:\n\n Datum: $displayDate\n\n Uhrzeit: $displayTime",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.bottomLeft,
                          child: SizedBox(
                            height: 50,
                            width: 150,
                            child: TextButton.icon(
                                onPressed: () {
                                  dateCheck = true;
                                  timeCheck = true;
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.cancel_outlined),
                                label: const Text("Abbrechen")),
                          ),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 50,
                            width: 150,
                            child: TextButton.icon(
                                onPressed: () {
                                  if (dateCheck == true && timeCheck == true) {
                                    date = tempDate;
                                    time = tempTime;
                                    makeCoffeTime(date, time);
                                    Navigator.pop(context);
                                  }
                                },
                                icon: const Icon(Icons.check),
                                label: const Text("Speichern")),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smarter Kaffee'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: <Widget>[
          Container(
              margin: const EdgeInsets.all(100),
              child: SizedBox(
                  height: 50,
                  width: 150,
                  child: TextButton.icon(
                    icon: const Icon(Icons.coffee),
                    label: const Text('Kaffee'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      confirmCoffee(context);
                    },
                  ))),
          SizedBox(
            height: 50,
            width: 150,
            child: TextButton.icon(
              icon: const Icon(Icons.coffee),
              label: const Text('Kaffee Timer'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                primary: Colors.black,
              ),
              onPressed: () {
                timerDialog(context);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
