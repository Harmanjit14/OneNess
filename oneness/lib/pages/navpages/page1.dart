import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:oneness/models/authModel.dart';
import 'package:oneness/pages/home_nav.dart';
import 'package:table_calendar/table_calendar.dart';

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final String updates = """
  {
  myblog(id: "$id"){
    title
    body
    author{
      name
    }
  }
}
  """;
  final String date = """
{
  dates(id : "$id"){
    day
    month
    year
    title
  }
}
""";

  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HttpLink _httpLink = HttpLink(
      uri: "http://oneness-backend.herokuapp.com/graphql/",
    );
    final AuthLink authLink = AuthLink(
      getToken: () async => 'JWT $token',
      // OR
      // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    );
    final Link link = authLink.concat(_httpLink);
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
          defaultPolicies: DefaultPolicies(
              query: Policies(fetch: FetchPolicy.cacheAndNetwork)),
          link: link,
          cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject)),
    );
    return GraphQLProvider(
      client: client,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  "Welcome back",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  finName,
                  style: GoogleFonts.poppins(shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.5, 0.5),
                      blurRadius: 1.5,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ], fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: TableCalendar(
                  locale: "en_US",
                  onDaySelected: (day, events, holidays) {},
                  // events: periodDays,
                  // holidays: exerciseDays,
                  calendarController: _calendarController,
                  calendarStyle: CalendarStyle(
                    holidayStyle:
                        TextStyle(color: Colors.red[700], fontSize: 20),
                    weekendStyle: TextStyle(color: Colors.black),
                    selectedColor: Colors.green[900],
                    todayColor: Colors.green,
                    markersColor: Colors.pink,
                    outsideDaysVisible: false,
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                  ),
                ),
              ),Divider(),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(
                  "Events",
                  style: GoogleFonts.poppins(
                      fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 300,
                child: Query(
                  options: QueryOptions(documentNode: gql(date)),
                  builder: (result, {fetchMore, refetch}) {
                    if (result.hasException) {
                      print(result.exception);
                      return Container(
                        child: Text("Error Fetching Data!"),
                      );
                    } else if (result.loading) {
                      return Container(
                        child: SpinKitCircle(
                          color: Colors.brown,
                        ),
                      );
                    } else {
                      List temp = result.data["dates"];
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: temp.length,
                          itemBuilder: (context, index) {
                            final day = temp[index]["day"];
                            final title = temp[index]["title"];
                            final month = temp[index]["month"];
                            final year = temp[index]["year"];
                            return Text("Click on date to view more!");
                          });
                    }
                  },
                ),
              ),
              Divider(),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(
                  "Updates",
                  style: GoogleFonts.poppins(
                      fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 500,
                child: Query(
                  options: QueryOptions(documentNode: gql(updates)),
                  builder: (result, {fetchMore, refetch}) {
                    if (result.hasException) {
                      print(result.exception);
                      return Container(
                        child: Text("Error Fetching Data!"),
                      );
                    } else if (result.loading) {
                      return Container(
                        child: SpinKitCircle(
                          color: Colors.brown,
                        ),
                      );
                    } else {
                      List temp = result.data["myblog"];
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: temp.length,
                          itemBuilder: (context, index) {
                            final id = temp[index]["id"];
                            final title = temp[index]["title"];
                            final body = temp[index]["body"];
                            final author = temp[index]["author"]["name"];
                            return update(title, body, author);
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget update(String title, String body, String author) {
  return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Card(
        child: Text(title),
      ));
}
