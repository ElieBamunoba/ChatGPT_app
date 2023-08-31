import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chat/chat_bloc.dart';
import 'hope_page.dart';
import 'repository/chat_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final APIRepository apiRepository = APIRepository(
    apiKey: 'YOUR_API_KEY',
    endpoint: 'https://api.openai.com/v1/chat/completions',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT App',
      home: BlocProvider(
        create: (context) => ChatBloc(apiRepository: apiRepository),
        child: ChatScreen(),
      ),
    );
  }
}
