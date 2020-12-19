import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:oneness/models/authModel.dart';
import 'package:oneness/pages/home_nav.dart';

class MainProtest extends StatefulWidget {
  @override
  _MainProtestState createState() => _MainProtestState();
}

class _MainProtestState extends State<MainProtest> {
  int dropVal = 0;
  int stateBut = 0;

  Widget logChild() {
    switch (stateBut) {
      case 0:
        {
          return Text(
            "Participate!",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 20, color: Colors.white)),
          );
        }
        break;
      case 1:
        {
          return SpinKitDoubleBounce(
            color: Colors.white,
            size: 30.0,
          );
        }
        break;
      case 2:
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.checkCircle,
                color: Colors.white,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                "Yay!",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          );
        }
        break;
      case 3:
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.timesCircle,
                color: Colors.white,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                "Error!",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          );
        }
        break;
      default:
        {
          return Text(
            "Continue",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 20, color: Colors.white)),
          );
        }
    }
  }

  final String pro = """
{
  allprotest{
    id
    title
    
  }
}
""";

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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  finName = "";
                  token = "";
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/", (route) => false);
                })
          ],
          title: Text(
            "Choose your Protest",
            style: GoogleFonts.poppins(
              letterSpacing: -0.75,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: Image.asset("people2.gif"),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Query(
                  options: QueryOptions(documentNode: gql(pro)),
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
                      List temp = result.data["allprotest"];
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            final id = temp[index]["id"];
                            final title = temp[index]["title"];
                            return protest_all(id, title, context);
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

Widget protest_all(String id, String title, BuildContext context) {
  String i = id;
  return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlatButton(
            padding: EdgeInsets.all(15),
            color: Colors.brown,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomeNavigation(id)));
            },
            child: Text(
              title,
              style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
            )),
      ));
}
