import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JournalCalendar extends StatefulWidget {
  var monthList = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ],
      monthDayCount = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  var buttonWidth = 130.0, buttonHeight = 50.0;
  TextStyle buttonFontStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  @override
  JournalCalendarState createState() => JournalCalendarState();
}

class JournalCalendarState extends State<JournalCalendar> {
  var selectedMonth = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.monthList[selectedMonth] + ' Journal Entries'),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(4.0, 12.0, 4.0, 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Ink(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(1000.0),
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_rounded,
                                size: 30.0,
                                color: Colors.black,
                              ),
                              Text(
                                'Prev. Month',
                                style: TextStyle(fontSize: 18.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Ink(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(1000.0),
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Next Month',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 30.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                  crossAxisCount: 7,
                  children: List.generate(widget.monthDayCount[selectedMonth],
                      (index) {
                    return Center(
                      child: Text(
                        '$index',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ));
  }
}
