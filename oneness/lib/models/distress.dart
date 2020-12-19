import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<int> sendDistress() {
  print("started");
  Timer(Duration(seconds: 0), () async {
    print("1");
    await getAndsendLoc();
  });
  Timer(Duration(seconds: 20), () async {
    await getAndsendLoc();
  });
  Timer(Duration(seconds: 40), () async {
    await getAndsendLoc();
  });
}

Future<int> getAndsendLoc() async {
  HttpLink _httpLink = HttpLink(
    headers: {
      "Authorization": "JWT $token",
    },
    uri: "https://raise-backend.herokuapp.com/graphql",
  );
  AuthLink _authLink = AuthLink(
    //  headerKey: "Authorization",
    getToken: () async {
      return "JWT $token";
    },
  );
  Link _link = _authLink.concat(_httpLink);
  GraphQLClient _client = GraphQLClient(
    defaultPolicies: DefaultPolicies(
        mutate:
            Policies(error: ErrorPolicy.all, fetch: FetchPolicy.networkOnly),
        query: Policies(fetch: FetchPolicy.noCache)),
    cache: NormalizedInMemoryCache(dataIdFromObject: typenameDataIdFromObject),
    link: _link,
  );
  Position position = await Geolocator.getCurrentPosition(
      timeLimit: Duration(seconds: 10), desiredAccuracy: LocationAccuracy.best);
  double lat = position.latitude;
  double long = position.longitude;
  print(lat);
  print(long);
  String getAuthToken = """
  mutation{
    addPolice(latitude: "$lat" , longitude: "$long" ){
      __typename
    }
  }
""";
  MutationOptions tokenGet = MutationOptions(
    documentNode: gql(getAuthToken),
  );
  QueryResult result = await _client.mutate(tokenGet);
  if (result.hasException) {
    print(result.exception);
    return 0;
  } else {
    print("done");
    return 1;
  }
}