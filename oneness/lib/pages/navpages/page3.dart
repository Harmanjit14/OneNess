import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:oneness/models/authModel.dart';
import 'package:oneness/pages/home_nav.dart';

class PageThree extends StatefulWidget {
  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  final String resource = """
  {
  resources(id: "$id" ){
    title
    quantity
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
      child: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text(
                "Required Resources!",
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 500,
              child: ListView(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          "https://www.verywellhealth.com/thmb/ZoA6KJefIB58oJPzbFX-H-Roq1o=/2880x1920/filters:fill(87E3EF,1)/the-wheat-allergy-diet-guide-1324279-primary-recirc-70ef0114e17e4f7b9a1faeab8b516e1e.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Wheat",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "amount 3 kg",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

Widget don(String title, int amount) {
  Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              amount.toString(),
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ));
}
