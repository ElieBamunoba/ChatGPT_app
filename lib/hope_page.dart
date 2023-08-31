import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chat/chat_bloc.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatInitial) {
                  return const Center(
                    child: Text('Start a conversation!'),
                  );
                } else if (state is ChatLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ChatSuccess) {
                  return ListView.builder(
                    itemCount: state.response.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.response[index]),
                      );
                    },
                  );
                } else if (state is ChatError) {
                  return Center(
                    child: Text('Error: ${state.error}'),
                  );
                }
                return Container();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatInputField(),
          ),
        ],
      ),
    );
  }
}

class ChatInputField extends StatefulWidget {
  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(BuildContext context) {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      context.read<ChatBloc>().add(SendMessage(message: message));
      //  _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Message'),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () => _sendMessage(context),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
