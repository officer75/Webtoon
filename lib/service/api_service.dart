import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstance = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstance.add(WebtoonModel.fromjson(webtoon));
      }
      return webtoonInstance;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getTodaysToonsDetail(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoonDetail = jsonDecode(response.body);

      return WebtoonDetailModel.fromjson(webtoonDetail);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getEpisodeToonsById(
      String id) async {
    List<WebtoonEpisodeModel> webtoonInstance = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstance.add(WebtoonEpisodeModel.fromJson(webtoon));
      }
      return webtoonInstance;
    }
    throw Error();
  }
}
