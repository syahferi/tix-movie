part of 'widgets.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;

  const PromoCard(this.promo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promo.title,
                    style: whiteTextFont,
                  ),
                  Text(
                    promo.subTitle,
                    style: whiteTextFont.copyWith(
                        fontSize: 11, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'OFF ',
                    style: yellowNumberFont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    '${promo.discount}%',
                    style: yellowNumberFont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
