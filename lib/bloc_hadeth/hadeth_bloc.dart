import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesmeat_app/bloc_hadeth/hadeth_event.dart';
import 'package:tesmeat_app/bloc_hadeth/hadeth_state.dart';
import 'package:tesmeat_app/service/hadeth_service.dart';

class HadithBloc extends Bloc<HadithEvent, HadithState> {
  final HadithService hadithService;

  HadithBloc(this.hadithService) : super(HadithInitial()) {
    on<FetchHadithsByBookId>((event, emit) async {
      emit(HadithLoading());
      try {
        final hadiths = await hadithService.fetchHadithsByBookId(event.bookId);
        emit(HadithLoaded(hadiths));
      } catch (e) {
        emit(HadithError(e.toString()));
      }
    });
  }
}
