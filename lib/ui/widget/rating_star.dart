part of 'widgets.dart';

class RatingStar extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;

  const RatingStar(this.voteAverage,
      {Key? key, this.starSize = 20, this.fontSize = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();

    List<Widget> widgets = List.generate(
        5,
        (index) => Icon(
              index < n ? Icons.star : Icons.star_outline,
              color: accentColor2,
              size: starSize,
            ));

    widgets.add(SizedBox(width: 3));
    widgets.add(Text(
      '$voteAverage/10',
      style: whiteNumberFont.copyWith(
        fontWeight: FontWeight.w100,
        fontSize: fontSize,
      ),
    ));

    return Row(
      children: widgets,
    );
  }
}
