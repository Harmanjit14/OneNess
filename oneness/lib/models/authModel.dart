import 'package:graphql_flutter/graphql_flutter.dart';

String token = "";

Future<int> getToken(String email, String password) async {
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
  mutation{
    tokenAuth(email : "$email", password: "$password"){
      token
    }
  }
""";
  MutationOptions tokenGet = MutationOptions(
    documentNode: gql(getAuthToken),
  );
  print(email);
  print(password);
  print("\n\nstarted\n\n");

  QueryResult result = await _client.mutate(tokenGet);
  if (result.hasException) {
    print(result.exception);
    return 0;
  } else {
    print("done");
    token = result.data["tokenAuth"]["token"];
    print("Done!");

    return 1;
  }
}
