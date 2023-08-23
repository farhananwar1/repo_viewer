import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repo_viewer/ui/auth/login/login_view_model.dart';
import 'package:repo_viewer/ui/pagesListView/pages_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PagesList extends StatelessWidget {
  final String repoName;
  const PagesList({super.key,required this.repoName});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PagesListViewModel>.reactive(
      onViewModelReady: (model) async {
        model.getPagesList(repoName);
      },
      viewModelBuilder: () => PagesListViewModel(),
      builder: (ctx, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              model.isBusy
                  ? const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                  : model.pagesList.isNotEmpty
                      ? Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                itemCount: model.pagesList.length,
                                itemBuilder: (context, index) {
                                  log(model.pagesList[0].toString());
                                  final name =
                                      model.pagesList[index]['name'];
                                  return GestureDetector(
                                      onTap: () async {
                                        model.viewJson(
                                            model.pagesList[index]
                                                ['download_url'],
                                            context);
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.all(12),
                                          height: 35.h,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Text(name.toString().capitalize())));
                                }),
                          ),
                        )
                      : Center(
                          child: Text(
                            'No Page Found',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ibmPlexSans(
                              color: const Color(0xff030303),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
