import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/bloc_books/books_bloc.dart';
import 'package:tesmeat_app/bloc_books/books_event.dart';
import 'package:tesmeat_app/bloc_books/books_state.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/service/book_service.dart';
import 'package:tesmeat_app/ui/ahadeth_list.dart';


class TypesPage extends StatelessWidget {
  const TypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookBloc(BookService())..add(FetchBooks()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state is BookLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookLoaded) {
              final books = state.books;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// العنصر الأول
                  Center(
                    child: GestureDetector(
                     onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AhadethListPage(bookId: books[0].id,),
    ),
  );
},

                      child: Container(
                        height: 160.h,
                        width: 300.w,
                        color: fifth_color,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 58.w,
                              top: 0,
                              child: Text(
                                "40", // هذا ثابت
                                style: TextStyle(
                                  fontSize: 110.sp,
                                  color: primary_color,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 170.w,
                              top: 65.h,
                              child: Text(
                                books[0].title, // عنوان جاي من الباك
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: third_color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  /// العنصر الثاني
                  GestureDetector(
                    onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AhadethListPage(bookId: books[1].id),
    ),
  );
},

                    child: Container(
                      height: 160.h,
                      width: 300.w,
                      color: fifth_color,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 58.w,
                            top: 0,
                            child: Text(
                              "75", // ثابت
                              style: TextStyle(
                                fontSize: 110.sp,
                                color: primary_color,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 170.w,
                            top: 65.h,
                            child: Text(
                              books[1].title, // عنوان جاي من الباك
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: third_color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  /// العنصر الثالث (قريباً)
                  Container(
                    height: 160.h,
                    width: 300.w,
                    color: fifth_color,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("images/clock 1.png"),
                        Text(
                          "قريبا",
                          style: TextStyle(fontSize: 20.sp, color: third_color),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is BookError) {
              return Center(child: Text("خطأ: ${state.message}"));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
