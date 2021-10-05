part of 'services.dart';

class MovieService {
  static Future<List<Movie>> getMovies(int page, {http.Client? client}) async {
    String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page&with_watch_monetization_types=flatrate';

    client ??= http.Client();
    var response = await client.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getMovieDetails(Movie movie,
      {http.Client? client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/${movie.id}?api_key=$apiKey&languange=en-US';

    client ??= http.Client();
    var response = await client.get(Uri.parse(url));
    var data = json.decode(response.body);

    List genres = (data as Map<String, dynamic>)['genres'];
    String language;

    switch (data['original_language'].toString()) {
      case 'ja':
        language = 'Japanese';
        break;
      case 'id':
        language = 'Indonesian';
        break;
      case 'ko':
        language = 'Korean';
        break;
      case 'en':
        language = 'English';
        break;
      default:
        language = 'Unknown';
    }

    return MovieDetail(movie,
        genres: genres.map((e) => e['title'].toString()).toList(),
        language: language);
  }

  static Future<List<Credit>> getCredit(int movieId,
      {http.Client? client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';

    client ??= http.Client();
    var response = await client.get(Uri.parse(url));
    var data = json.decode(response.body);

    return (data['cast'] as List)
        .map((e) => Credit(name: e['name'], profilePath: e['profile_path']))
        .take(8)
        .toList();
  }
}
