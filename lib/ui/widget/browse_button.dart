part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String? selectedGenre;
  final Function? onTap;

  const BrowseButton(this.selectedGenre, {this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 60,
        child: generateIconBrowseMovie(),
      ),
    );
  }

  Widget generateIconBrowseMovie() {
    switch (selectedGenre) {
      case 'Comedy':
        return Column(
          children: [
            Image.asset('assets/comedy.png'),
            Text(
              selectedGenre ?? '',
              style: blackTextFont.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        );
      case 'War':
        return Column(
          children: [
            Image.asset('assets/war.png'),
            Text(
              selectedGenre ?? '',
              style: blackTextFont.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        );
      case 'Action':
        return Column(
          children: [
            Image.asset('assets/action.png'),
            Text(
              selectedGenre ?? '',
              style: blackTextFont.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        );
      case 'Horor':
        return Column(
          children: [
            Image.asset('assets/horror.png'),
            Text(
              selectedGenre ?? '',
              style: blackTextFont.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        );
      default:
        return Image.asset('assets/popcorn.png');
    }
  }
}
