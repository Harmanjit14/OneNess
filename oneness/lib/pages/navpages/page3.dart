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
                "Recent Donations!",
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 500,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Query(
                options: QueryOptions(documentNode: gql(resource)),
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
                    List temp = result.data["resources"];
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: temp.length,
                        itemBuilder: (context, index) {
                          final String title = temp[index]["title"];
                          final int amount = temp[index]["quantity"];
                          return don(title, amount);
                        });
                  }
                },
              ),
            ),
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
