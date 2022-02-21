import 'dart:convert' show jsonEncode, utf8;
import 'dart:io';

import 'package:web_socket_channel/web_socket_channel.dart';

final channel = WebSocketChannel.connect(Uri.parse('ws://192.168.2.113:5050'));
//final channel = WebSocketChannel.connect(Uri.parse('wss://ws-feed.pro.coinbase.com'),);

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
