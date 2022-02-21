import 'package:web_socket_channel/web_socket_channel.dart';

int canCoffe = 0; //0 = TRUE

void send(String command) {
  if (canCoffe == 0) {
    canCoffe = 1;
    final channel =
        WebSocketChannel.connect(Uri.parse('ws://192.168.2.118:5050'));
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
  print(date);
  print(time);
  if (canCoffe == 0) {
    canCoffe = 1;
    final channel =
        WebSocketChannel.connect(Uri.parse('ws://192.168.2.118:5050'));
    channel.sink.add("!makeCoffeonTime");
    channel.stream.listen((data) {
      if (data == "!FINISHED") {
        channel.sink.close();
        canCoffe = 0;
      }
    });
  }
}
