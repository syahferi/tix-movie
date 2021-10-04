part of 'widgets.dart';

class ComingSoon extends StatelessWidget {
  final Movie movie;
  final Function? onTap;

  const ComingSoon(this.movie, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(baseImageUrl + "w500" + movie.posterPath);
  }
}
