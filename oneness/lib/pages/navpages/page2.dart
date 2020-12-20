import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:oneness/models/authModel.dart';
import 'package:oneness/pages/home_nav.dart';

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  final String allDonations = """
  {
  donations(id: "$id" ){
    madeBy{
      name
    }
    amount
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
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 300,
              child: Query(
                options: QueryOptions(documentNode: gql(allDonations)),
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
                    List temp = result.data["donations"];
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: temp.length,
                        itemBuilder: (context, index) {
                          final String by = temp[index]["madeby"]["name"];
                          final int amount = temp[index]["amount"];
                          return don(by, amount);
                        });
                  }
                },
              ),
            ),
            Container(child: Image.asset("donation.gif"))
          ],
        ),
      )),
    );
  }
}

Widget don(String by, int amount) {
  return Container(
      child: Card(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        by,
        style: GoogleFonts.poppins(fontSize: 16),
      ),
      Text(
        amount.toString(),
        style: GoogleFonts.poppins(fontSize: 14),
      )
    ]),
  ));
}
