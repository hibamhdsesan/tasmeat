import 'package:equatable/equatable.dart';

abstract class HadithEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchHadithsByBookId extends HadithEvent {
  final int bookId;

  FetchHadithsByBookId(this.bookId);

  @override
  List<Object?> get props => [bookId];
}
