part of 'widgets.dart';

class SelectableBox extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;
  final double width;
  final double height;
  final String? text;
  final Function? onTap;
  final TextStyle? style;

  const SelectableBox(
    this.text, {
    Key? key,
    this.isSelected = false,
    this.isEnabled = true,
    this.width = 144,
    this.height = 60,
    this.onTap,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onTapAction = onTap;

    return GestureDetector(
      onTap: () {
        if (onTapAction != null) {
          onTapAction();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: (!isEnabled)
                ? Color(0xffe4e4e4)
                : isSelected
                    ? accentColor2
                    : Colors.transparent,
            border: Border.all(
              color: (!isEnabled)
                  ? Color(0xffe4e4e4)
                  : isSelected
                      ? Colors.transparent
                      : Color(0xffe4e4e4),
            )),
        child: Center(
          child: Text(
            text ?? 'None',
            style: (style ?? blackTextFont).copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
