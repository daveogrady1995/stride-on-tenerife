import 'dart:convert';

import 'package:masterPiece/environment/APIKeys.dart';
import 'package:masterPiece/models/Tweet.dart';
import 'package:masterPiece/models/TwitterUser.dart';
import 'package:http/http.dart' as http;

class TwitterAPIService {
  Future<List<Tweet>> getTwitterNewsFeed() async {
    /*String queryParameters = '?expansions=attachments.poll_ids,attachments.media_keys,author_id,' +
        'entities.mentions.username,geo.place_id,in_reply_to_user_id,referenced_tweets.id,' +
        'referenced_tweets.id.author_id&tweet.fields=attachments,author_id,context_annotations,' +
        'conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,possibly_sensitive,' +
        'public_metrics,referenced_tweets,reply_settings,source,text,withheld&user.fields=created_at,' +
        'description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,' +
        'username,verified,withheld&place.fields=contained_within,country,country_code,full_name,geo,id,name,' +
        'place_type&poll.fields=duration_minutes,end_datetime,id,options,voting_status&media.fields=duration_ms,height,' +
        'media_key,preview_image_url,type,url,width,public_metrics,non_public_metrics,organic_metrics,promoted_metrics&max_results=20';*/

    final queryParameters = {
      'user_id': '236469815',
      'screen_name': 'visit_tenerife',
      'include_rts': 'true',
      'count': '50',
      'tweet_mode': 'extended'
    };

    // final uri = Uri.parse(
    //     'https://api.twitter.com/2/users/236469815/tweets' + queryParameters);

    final uri = Uri.https(
        'api.twitter.com', '/1.1/statuses/user_timeline.json', queryParameters);

    final response = await http.get(uri,
        headers: {"Authorization": 'Bearer ' + APIKeys().bearerToken});

    if (response.statusCode == 200) {
      var tweetsMap = json.decode(response.body);

      List<Tweet> tweets = [];

      for (var tweet in tweetsMap) {
        // if tweet has no image then return empty string
        var photoUrl = "";
        try {
          photoUrl = tweet["entities"]["media"][0]["media_url"];
        } on NoSuchMethodError {}

        var dateCreated = tweet["created_at"];
        var tweetText = tweet["full_text"];

        if (photoUrl.isNotEmpty) {
          tweets.add(new Tweet(dateCreated, tweetText, photoUrl));
        }
      }
      return tweets;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tweets');
    }
  }

//  Future<TwitterUser> getUserInfo() async {
//    final _twitterOauth = new twitterApi(
//      consumerKey: APIKeys().consumerKey,
//      consumerSecret: APIKeys().consumerSecret,
//      token: APIKeys().token,
//      tokenSecret: APIKeys().tokenSecret,
//    );
//
//    final response = await _twitterOauth.getTwitterRequest(
//      // Http Method
//      "GET",
//      // Endpoint you are trying to reach
//      "users/lookup.json",
//      // The options for the request
//      options: {
//        "Name": "visit_Tenerife",
//        "user_id": "236469815",
//      },
//    );
//
//    if (response.statusCode == 200) {
//      var userMap = json.decode(response.body);
//
//      var username = userMap[0]["name"];
//      var userHandle = userMap[0]["screen_name"];
//
//      return new TwitterUser(username, userHandle);
//    } else {
//      throw Exception('Failed to load twitter user');
//    }
//  }
}
