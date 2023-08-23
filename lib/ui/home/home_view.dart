import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repo_viewer/ui/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onViewModelReady: (model) async {
      model.getTokenFromSPAndPassItToTheFunction();
      },
      viewModelBuilder: () => HomeViewModel(),
      builder: (ctx, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              model.isBusy
                  ? const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                  : model.repoList.isNotEmpty
                      ? Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                itemCount:model. repoList.length,
                                itemBuilder: (context, index) {
                                  log(model.repoList[0].toString());
                                  final fullName =
                                      model.repoList[index]['full_name'];
                                  return GestureDetector(
                                      onTap: () async {
                                        model.viewJson(model.repoList[index]['full_name'],context);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(12),
                                        height: 35.h,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),border: Border.all(color: Colors.black)),
                                        child: Text(fullName)));
                                }),
                          ),
                        )
                      : Center(
                          child: Text(
                            'No Repo Found',
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
