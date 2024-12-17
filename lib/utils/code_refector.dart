import 'package:ueh_mobile_app/utils/exports.dart';

// custom text widget
Widget customText({required String txt, required TextStyle style}) {
  return Text(
    txt,
    style: style,
  );
}

Widget inkwellButtons({
  required Image image,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: 170,
        height: 60,
        child: image,
      ),
    ),
  );
}

// sign up button
Widget signUpContainer({required String st}) {
  return Container(
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
      color: AppColors.kBlueColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: customText(
          txt: st,
          style: const TextStyle(
            color: AppColors.kwhiteColor,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          )),
    ),
  );
}

// rich text
TextSpan richTextSpan ({required String one, required String two}) {
  return TextSpan(children: [
    TextSpan(
        text: one,
        style: TextStyle(fontSize: 13, color: AppColors.kBlackColor)),
    TextSpan(
        text: two,
        style: TextStyle(
          fontSize: 13,
          color: AppColors.kBlueColor,
        )),
  ]);
}

// TextField
Widget customTextField({required String Lone, required String Htwo}) {
  return TextField(
    decoration: InputDecoration(
        labelText: Lone,
        hintText: Htwo,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          width: 5,
          color: AppColors.kDarkblack,
          style: BorderStyle.solid,
        ))),
    autofocus: true,
    keyboardType: TextInputType.multiline,
  );
}
