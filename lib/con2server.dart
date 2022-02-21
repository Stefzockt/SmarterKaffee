import 'package:web_socket_channel/web_socket_channel.dart';

final channel = WebSocketChannel.connect(Uri.parse('ws://192.168.2.113:5050'));

void send(String command) {
  channel.sink.add("Test");
  channel.stream.listen(
    (data) {
      print(data);
    },
    onError: (error) => print(error),
  );
}

void closeConnection(channel) {
  channel.sink.close();
}
