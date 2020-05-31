import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:routine/utils/ActivityCategory.dart';
import 'package:routine/utils/firebase.dart';
import 'package:routine/utils/Activity.dart';
import 'package:routine/utils/helpers.dart';

final Color accentBackgroundColor = const Color(0xFF7de3fa);
final Color midBackgroundColor = const Color(0xFF2f1cff);

class MyDashboardPage extends StatefulWidget {
  final String title;
  MyDashboardPage({Key key, this.title}) : super(key: key);

  @override
  _MyDashboardPageState createState() => _MyDashboardPageState();
}

class _MyDashboardPageState extends State<MyDashboardPage> {
  List<Activity> activityList;
  List<ActivityCategory> categoryList;

  Map<String, String> categoryMap = new Map();
  Activity acceptedActivity;

  Future<List<Activity>> getUserMatchingActivities({bool force = false}) async {
    await getUserMatchingCategories(force: force);

    if (force || activityList == null) {
      activityList = await FirebaseUtils().getUserMatchingActivities();
    }

    int acceptedActivityId = await FirebaseUtils().getUserCurrentActivity();
    if (force || acceptedActivityId != null) {
      acceptedActivity = activityList.firstWhere(
          (element) => element.id == acceptedActivityId,
          orElse: () => null);
    }

    return activityList;
  }

  Future<Map<String, String>> getUserMatchingCategories(
      {bool force = false}) async {
    if (force || categoryMap == null) {
      categoryList = await FirebaseUtils().getCategories();
    }

    print("THIS IS A TEST");
    for (var y in categoryList) {
      print(y.name);
      print(y.imageUrl);
      categoryMap.putIfAbsent(y.name, () => y.imageUrl);
    }

    return categoryMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[dashboard(context)],
        ));
  }

  Widget dashboard(context) {
    return Container(
        height: double.infinity,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.indigoAccent])),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // dashboard
              children: <Widget>[
                Text(
                  "DASHBOARD",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontFamily: "Open Sans"),
                ),
              ],
            ),
            Container(
              // color: Colors.red,
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 24,
                    top: 48,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "5",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                                letterSpacing: 1,
                                fontFamily: 'Open Sans'),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "TO DO",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: 'Open Sans'),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: FutureBuilder<List<int>>(
                      future: FirebaseUtils().getUserCompletedActivites(),
                      builder: (ctxt, snapshot) {
                        return CircularPercentIndicator(
                          radius: 130.0,
                          backgroundColor: Colors.white38,
                          lineWidth: 3.0,
                          percent: 0.66,
                          progressColor: Colors.white,
                          center: Container(
                            padding: const EdgeInsets.only(top: 32),
                            child: Column(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    snapshot.hasData
                                        ? snapshot.data.length.toString()
                                        : '0',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 36,
                                        color: Colors.white,
                                        letterSpacing: 1,
                                        fontFamily: 'Open Sans'),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Center(
                                  child: Text(
                                    "COMPLETED",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontFamily: 'Open Sans'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 48,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "2",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                                letterSpacing: 1,
                                fontFamily: 'Open Sans'),
                          ),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                            "DONE",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: 'Open Sans'),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                // color: Colors.green,
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      width: 60.0,
                      height: 60.0,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.blue,
                                  letterSpacing: 1,
                                  fontFamily: 'Open Sans'),
                            ),
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: Text(
                              "SOCIAL",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.blue,
                                  fontFamily: 'Open Sans'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      width: 60.0,
                      height: 60.0,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "4",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.blue,
                                  letterSpacing: 1,
                                  fontFamily: 'Open Sans'),
                            ),
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: Text(
                              "PHYSICAL",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.blue,
                                  fontFamily: 'Open Sans'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 5),
                        width: 60.0,
                        height: 60.0,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Text(
                                "1",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blue,
                                    letterSpacing: 1,
                                    fontFamily: 'Open Sans'),
                              ),
                            ),
                            SizedBox(height: 5),
                            Center(
                              child: Text(
                                "MENTAL",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blue,
                                    fontFamily: 'Open Sans'),
                              ),
                            )
                          ],
                        )),
                  ],
                )),
            FutureBuilder<List<Activity>>(
                future: getUserMatchingActivities(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  activityList = snapshot.data;

                  List<Widget> textWidgets = [];
                  List<Activity> activitiesToShow = activityList;

                  if (acceptedActivity != null) {
                    textWidgets = [
                      Text('Your current challenge',
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white)),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'You can mark your challenge as completed or skip it!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ];

                    activitiesToShow = [acceptedActivity];
                  } else {
                    textWidgets = [
                      Text('Your challenges',
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white)),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'You can accept or reject any challenge!',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ];
                  }

                  return Container(
                      padding: EdgeInsets.symmetric(),
                      child: Column(
                        children: [
                          ...textWidgets,
                          for (final activity in activitiesToShow)
                            Card(
                                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Text(activity.name,
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              SizedBox(height: 6),
                                              Text(activity.description,
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                            ]),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 225),
                                            child: Image.network(
                                              categoryMap[activity.categories],
                                            )),
                                      ],
                                    ),
                                    Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                            iconSize: 30,
                                            icon: Icon(Icons.check),
                                            color: Colors.green,
                                            onPressed: () async {
                                              if (acceptedActivity != null) {
                                                // i.e. we're marking this as completed
                                                final bool result =
                                                    await FirebaseUtils()
                                                        .setUserCompletedActivity(
                                                            acceptedActivity);

                                                if (!result) {
                                                  await showAlertDialog(context,
                                                      title:
                                                          'Error completing challenge',
                                                      message:
                                                          'There was an error marking the challenge as completed. Please try again later!');
                                                } else {
                                                  setState(() {
                                                    getUserMatchingActivities(
                                                        force: true);
                                                    acceptedActivity = null;
                                                  });
                                                }
                                              } else {
                                                // i.e. we choosing to do this challenge
                                                final bool result =
                                                    await FirebaseUtils()
                                                        .setUserNewActivity(
                                                            activity);

                                                if (!result) {
                                                  await showAlertDialog(context,
                                                      title:
                                                          'Error accepting challenge',
                                                      message:
                                                          'There was an error accepting the challenge. Please try again later!');
                                                } else {
                                                  setState(() =>
                                                      acceptedActivity =
                                                          activity);
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: IconButton(
                                            iconSize: 30,
                                            icon: acceptedActivity == null
                                                ? Icon(Icons.clear)
                                                : Icon(Icons.skip_next),
                                            color: Colors.red,
                                            onPressed: () async {
                                              if (acceptedActivity == null) {
                                                // i.e. we want to reject this challenge
                                                setState(() => activityList
                                                    .remove(activity));
                                              } else {
                                                // i.e. we want to skip this challenge after already choosing it
                                                final bool result =
                                                    await FirebaseUtils()
                                                        .userSkipCurrentActivity();

                                                if (!result) {
                                                  await showAlertDialog(context,
                                                      title:
                                                          'Error skipping challenge',
                                                      message:
                                                          'There was an error skipping th challenge. Please try again later!');
                                                } else {
                                                  setState(() =>
                                                      acceptedActivity = null);
                                                }
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                                ))
                        ],
                      ));
                }),
          ]),
        ));
  }
}
