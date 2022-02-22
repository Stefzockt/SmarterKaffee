import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:intl/intl.dart';

int canCoffe = 0; //0 = TRUE
String IP_ADDRESS = 'ws://192.168.43.178:5050';

void send(String command) {
  if (canCoffe == 0) {
    canCoffe = 1;
    final channel = WebSocketChannel.connect(Uri.parse(IP_ADDRESS));
    channel.sink.add(command);
    channel.stream.listen((data) {
      if (data == "!FINISHED") {
        channel.sink.close();
        canCoffe = 0;
      }
    });
  }
}

void makeCoffeTime(date, time) {
  String fdate = DateFormat('yy/MM/dd').format(date);
  final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
  String ftime = DateFormat('kk:mm').format(dt);
  String command = "!makeCoffeonTime\r\n$fdate\r\n$ftime";
  if (canCoffe == 0) {
    canCoffe = 1;
    final channel = WebSocketChannel.connect(Uri.parse(IP_ADDRESS));
    channel.sink.add(command);
    channel.stream.listen((data) {
      if (data == "!FINISHED") {
        channel.sink.close();
        canCoffe = 0;
      }
    });
  }
}
