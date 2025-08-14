import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesmeat_app/bloc_books/books_event.dart';
import 'package:tesmeat_app/bloc_books/books_state.dart';
import 'package:tesmeat_app/service/book_service.dart';


class BookBloc extends Bloc<BookEvent, BookState> {
  final BookService bookService;

  BookBloc(this.bookService) : super(BookInitial()) {
    on<FetchBooks>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await bookService.fetchBooks();
        emit(BookLoaded(books));
      } catch (e) {
        emit(BookError(e.toString()));
      }
    });
  }
}
