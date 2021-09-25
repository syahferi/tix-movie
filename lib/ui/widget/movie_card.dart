part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function? onTap;

  const MovieCard(this.movie, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
            image: NetworkImage(baseImageUrl + "w500" + movie.backdropPath),
            fit: BoxFit.cover),
      ),
      child: Container(
        height: 140,
        width: 210,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: whiteTextFont,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            RatingStar(movie.voteAverage),
          ],
        ),
      ),
    );
  }
}
