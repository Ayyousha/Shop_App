import 'package:flutter/material.dart';
import 'package:moon/shared/style/colors.dart';



/// default rectangle Form Field
Widget defaultFormField({
  bool isPassword = false,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String labelText,
  required String? Function(String?)? validate,
  required IconData prefix,
  IconData? suffix,
  TextStyle? Style,
  dynamic suffixPress,
  dynamic onSubmit,
  dynamic onChange,
  dynamic onTap,
  bool isClickable = true,
}) =>
    TextFormField(
      // cursorColor: Colors.white,

      enabled: isClickable,
      onTap: onTap,
      style: Style,
      obscureText: isPassword,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: validate,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,

        ),
        labelText: labelText,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPress,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );

/// default line Form Field
Widget defaultFormFieldLine({
  bool isPassword = false,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String labelText,
  required String? Function(String?)? validate,
  IconData? prefix,
  IconData? suffix,
  TextStyle? Style,
  dynamic suffixPress,
  dynamic onSubmit,
  dynamic onChange,
  dynamic onTap,
  bool isClickable = true,
}) =>
    TextFormField(
      // cursorColor: Colors.white,
      enabled: isClickable,
      onTap: onTap,
      style: Style,
      obscureText: isPassword,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: validate,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,

        ),
        labelText: labelText,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPress,
          icon: Icon(
            suffix,
          ),
        )
            : null,

      ),
    );

/// Button Widget
Widget defaultButton({
  double width = double.infinity,
  double? height,
  Color background = defaultColor,
  double radius = 0.0,
  bool isCapital = true,
  required dynamic function,
  required Widget child,
}) =>
    Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: height??40,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),

        color: background,
      ),
      child: MaterialButton(
        child: child,
        onPressed: () {function();},
      ),
    );

/// default Rectangle Button
Widget defaultRectangleButton({
  double width = double.infinity,
  Color background = defaultColor,
  double radius = 0.0,
  bool isCapital = true,
  Color? TextColor ,
  required Function function,
  required String text,
}) =>
    Container(
      height: 40,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: background,
      ),
      child: MaterialButton(
        child: Text(
          isCapital ? text.toUpperCase() : text,
          style: TextStyle(
            color: TextColor ?? Colors.white,
          ),
        ),
        onPressed: () {function();},
      ),
    );

/// default Circular Button
Widget defaultCircularButton({
  double? height ,
  double width = double.infinity,
  Color background = defaultColor,
  double rounderRadius = 0.0,
  bool isCapital = true,
  Color? TextColor ,
  Gradient? LinearGradient,
  FontWeight? FontWeight,
  required Function function,
  required String text,
}) =>
    Container(
      height: height??35,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rounderRadius),
        color: background,
        gradient: LinearGradient,
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rounderRadius),
        ),

        child: Text(
          isCapital ? text.toUpperCase() : text,
          style: TextStyle(
              color: TextColor ?? Colors.white,
              fontSize: 16,
            fontWeight: FontWeight,
          ),
        ),
        onPressed: () {function();},
      ),
    );

/// Navigate to another Screen
void NavigateTo(context, Widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => Widget),
);

/// Navigate To Anther Screen and doesn't Back
void NavigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => Widget),
      (Route<dynamic> route) => false,
);

// /// Flutter Show Toast
// void ShowToast({
//   required String text,
//   required ToastStates state,
// }) => Fluttertoast.showToast(
//     msg: text,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: chooseToastColor(state),
//     textColor: Colors.white,
//     fontSize: 14.0
// );
//
// enum ToastStates {SUCCESS, ERROR, WARNING, NORMAL}
// Color chooseToastColor(ToastStates state)
// {
//   Color color;
//   switch(state) {
//     case ToastStates.NORMAL :
//       color = Colors.grey[300]!;
//       break;
//     case ToastStates.SUCCESS :
//       color = Colors.green[300]!;
//       break;
//     case ToastStates.ERROR :
//       color = Colors.red[300]!;
//       break;
//     case ToastStates.WARNING :
//       color = Colors.amber[300]!;
//       break;
//   }
//   return color;
// }


/// Divider --------
Widget MyDivider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 0),
  child: Container(
    height: 0.3,
    width: double.infinity,
    color: Colors.grey,
  ),
);


/// SizedBox
Widget heightSizedBox(double height) => SizedBox(height: height);
Widget widthSizedBox(double width) => SizedBox(width: width);


/// Custom Page Route
class CustomPageRoute extends PageRouteBuilder{
  final Widget child;
  final AxisDirection direction;

  CustomPageRoute({
    required this.child,
    this.direction = AxisDirection.right,
  }) : super (
      transitionDuration: Duration(milliseconds: 750),
      reverseTransitionDuration: Duration(milliseconds: 750),
      pageBuilder:(context,animation , secondaryAnimation) => child );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation , Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

  Offset getBeginOffset()
  {
    switch (direction){
      case AxisDirection.down:
        return Offset(0, 1);
      case AxisDirection.up:
        return Offset(0, -1);
      case AxisDirection.left:
        return Offset(-1, 0);
      case AxisDirection.right:
        return Offset(1, 0);
    }
  }
}