import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:oneness/models/authModel.dart';

String upi;
int participants;
String title;

Future<int> getProtest(String id) async {
  final HttpLink _httpLink = HttpLink(
    uri: "http://oneness-backend.herokuapp.com/graphql/",
  );
  final AuthLink authLink = AuthLink(
    getToken: () async => 'JWT $token',
    // OR
    // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );
  final Link link = authLink.concat(_httpLink);
  GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: link,
  );

  String getAuthToken = """
{
  oneprotest(id: "$id"){
    title
    participants
    upiId
  }
}
""";
  QueryOptions tokenGet = QueryOptions(
    documentNode: gql(getAuthToken),
  );
  print("\n\nstarted\n\n");

  QueryResult result = await _client.query(tokenGet);
  if (result.hasException) {
    print(result.exception);
    return 0;
  } else {
    participants = result.data["oneprotest"]["participants"];
    upi = result.data["oneprotest"]["upiId"];
    title = result.data["oneprotest"]["title"];
    print("done");
    return 1;
  }
}
