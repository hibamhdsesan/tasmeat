import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/bloc_hadeth/hadeth_bloc.dart';
import 'package:tesmeat_app/bloc_hadeth/hadeth_event.dart';
import 'package:tesmeat_app/bloc_hadeth/hadeth_state.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/service/hadeth_service.dart';

import 'package:tesmeat_app/ui/hadeth.dart';

class AhadethListPage extends StatelessWidget {
  final int bookId;

  const AhadethListPage( {super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HadithBloc(HadithService())..add(FetchHadithsByBookId(bookId)),
      child: Scaffold(
        appBar: AppBar(backgroundColor: primary_color),
        body: BlocBuilder<HadithBloc, HadithState>(
          builder: (context, state) {
            if (state is HadithLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HadithLoaded) {
              final hadiths = state.hadiths;
              return Padding(
                padding: const EdgeInsets.only(top: 48),
                child: ListView.builder(
                  itemCount: hadiths.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14, left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HadethPage(
                                hadith: hadiths[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 59.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: fifth_color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              hadiths[index].title, // عنوان الحديث
                              style: TextStyle(color: fourth_color, fontSize: 18.sp),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is HadithError) {
              return Center(child: Text("خطأ: ${state.message}"));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
