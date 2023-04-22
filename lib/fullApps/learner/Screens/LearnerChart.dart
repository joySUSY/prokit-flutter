import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/learner/Screens/LearnerDescription.dart';
import 'package:prokit_flutter/fullApps/learner/model/LearnerModels.dart';
import 'package:prokit_flutter/fullApps/learner/utils/LearnerColors.dart';
import 'package:prokit_flutter/fullApps/learner/utils/LearnerConstant.dart';
import 'package:prokit_flutter/fullApps/learner/utils/LearnerDataGenerator.dart';
import 'package:prokit_flutter/fullApps/learner/utils/LearnerStrings.dart';
import 'package:prokit_flutter/fullApps/nftMarketPlace/utils/NMPCommon.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';

import 'LearnerModrenMedicine.dart';

class LearnerChart extends StatefulWidget {
  @override
  _LearnerChartState createState() => _LearnerChartState();
}

class _LearnerChartState extends State<LearnerChart> {
  late List<LearnerCoursesModel> mList1;

  @override
  void initState() {
    super.initState();
    mList1 = learnerGetCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(135),
              child: Container(
                child: SafeArea(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: context.width(),
                        ),
                        text(
                          learner_lbl_My_Courses,
                          fontSize: textSizeXXLarge,
                          fontFamily: fontBold,
                          textColor: learner_textColorPrimary,
                        ).paddingOnly(left: 16),
                        SizedBox(height: 16),
                        Container(
                          width: context.width() / 1.3,
                          child: TabBar(
                            labelPadding: EdgeInsets.only(left: 0, right: 0),
                            indicatorWeight: 4.0,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: learner_colorPrimary,
                            labelColor: learner_colorPrimary,
                            isScrollable: true,
                            unselectedLabelColor: learner_textColorSecondary,
                            tabs: [
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  learner_lbl_All,
                                  style: TextStyle(fontSize: 18.0, fontFamily: fontBold),
                                ),
                              ).paddingOnly(left: 8, right: 8),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  learner_lbl_Ongoing,
                                  style: TextStyle(fontSize: 18.0, fontFamily: fontBold),
                                ),
                              ).paddingOnly(right: 8),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  learner_lbl_Completed,
                                  style: TextStyle(fontSize: 18.0, fontFamily: fontBold),
                                ),
                              ).paddingOnly(right: 8)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(left: 8, right: 16),
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: AnimatedWrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    spacing: 16,
                    runSpacing: 16,
                    itemCount: mList1.length,
                    itemBuilder: (_, i) {
                      return LearnerCourses(mList1[i], i, LearnerModrenMedicine.tag);
                    },
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: AnimatedWrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    spacing: 16,
                    runSpacing: 16,
                    itemCount: mList1.length,
                    itemBuilder: (_, i) {
                      return LearnerCourses(mList1[i], i, LearnerModrenMedicine.tag);
                    },
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: AnimatedWrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    spacing: 16,
                    runSpacing: 16,
                    itemCount: mList1.length,
                    itemBuilder: (_, i) {
                      return LearnerCourses(mList1[i], i, LearnerModrenMedicine.tag);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LearnerCourses extends StatelessWidget {
  late LearnerCoursesModel model;
  late String tags;

  LearnerCourses(LearnerCoursesModel model, int pos, String tags) {
    this.model = model;
    this.tags = tags;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: context.cardColor,
      width: context.width() / 2 - 24,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CachedNetworkImage(
                placeholder: (_, s) => placeholderWidget(),
                imageUrl: model.img,
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              ).cornerRadiusWithClipRRect(25).paddingOnly(left: 16, top: 16),
              IconButton(
                icon: Icon(Icons.more_vert, color: learner_greyColor),
                onPressed: () {},
              ),
            ],
          ),
          Column(
            children: <Widget>[
              text(model.name, textColor: learner_textColorPrimary, fontSize: textSizeMedium, fontFamily: fontMedium, maxLine: 2).paddingOnly(left: 16, right: 16, top: 16),
              Container(
                child: LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: textSecondaryColor.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(learner_green),
                ).paddingOnly(top: 16, left: 16, right: 16),
              ),
              16.height,
            ],
          )
        ],
      ),
    ).cornerRadiusWithClipRRect(10.0).onTap(() {
      LearnerDescription().launch(context);
    }, hoverColor: Colors.transparent, splashColor: Colors.transparent, highlightColor: Colors.transparent);
  }
}
