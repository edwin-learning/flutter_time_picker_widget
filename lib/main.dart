import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterTimePicker());
}

class FlutterTimePicker extends StatelessWidget {
  const FlutterTimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Time Picker',
      theme: ThemeData(
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          hourMinuteShape: const CircleBorder(),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Colors.white10),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedTime;

  Future<void> _show() async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      ),
    );
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Flutter Time Picker',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Center(
          child: Text(
            _selectedTime != null ? _selectedTime! : 'No Time Selected!',
            style: const TextStyle(
                fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: _show,
          child: const Text(
            'Show Time Picker',
            style: TextStyle(fontSize: 25),
          ),
        ),
      );
}
