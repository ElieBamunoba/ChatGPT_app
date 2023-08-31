import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final APIRepository apiRepository;
  ChatBloc({required this.apiRepository}) : super(ChatInitial()) {
    on<SendMessage>(_onSendMessage);
  }

  void _onSendMessage(ChatEvent event, Emitter<ChatState> emit) async {
    if (event is SendMessage) {
      emit(ChatLoading());
      try {
        final response = await apiRepository.sendMessage(event.message);
        emit(ChatSuccess(response: response));
      } catch (e) {
        final error = e.toString();
        emit(ChatError(error: 'Failed to send message'));
      }
    }
  }
}
