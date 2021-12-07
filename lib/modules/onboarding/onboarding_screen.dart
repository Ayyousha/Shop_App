
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon/modules/starting/starting_screen.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class boardingInfo
{
 final String image;
   final String title;
     final String body;


 boardingInfo({
     required this.image,
        required this.title,
          required this.body,
    });

}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {



 var boardingController = PageController();
 bool isLast = false;
 bool isFirst = false;

 void onSubmit()
 {
   CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
   {
     Navigator.of(context).pushAndRemoveUntil(
       CustomPageRoute(
         child : StartingScreen(),
         direction: AxisDirection.left,
       ),
           (Route<dynamic> route) => false,
     );
   });
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildPageView(),
          _buildButtonAndSmoothPageIndicator()
        ],
      ),
    );
  }

  /// App Bar
 PreferredSizeWidget _buildAppBar()=> AppBar(
   toolbarHeight: 50,

   leading: Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       if(!isFirst)
         IconButton(
           onPressed: ()
           {
             boardingController.previousPage(
               duration: Duration(
                 milliseconds: 1000,
               ),
               curve: Curves.ease,
             );
           },
           icon: Icon(
             Icons.arrow_back_outlined,
             // Icons.arrow_back_ios_outlined,
             color: Colors.grey,
             semanticLabel: 'Last',
           ),
           splashRadius: 25,
           splashColor: Colors.grey[200],
           highlightColor: Colors.grey[200],
         ),
     ],
   ),
   actions: [
     if(!isLast)
       IconButton(
         onPressed: ()
         {
           boardingController.nextPage(
             duration: Duration(
               milliseconds: 1000,
             ),
             curve: Curves.ease,
           );
         },
         icon: Icon(
           Icons.arrow_forward_outlined,
           // Icons.arrow_forward_ios_outlined,
           color: Colors.grey,
           semanticLabel: 'Next',
         ),
         splashRadius: 25,
         splashColor: Colors.grey[200],
         highlightColor: Colors.grey[200],
       ),
   ],
 );

 /// Page View
 Widget _buildPageView()=> Expanded(
   child: PageView.builder(
     controller: boardingController,
     itemBuilder: (context, index) => _buildPageViewDetails(boarding[index],context),
     itemCount: boarding.length,
     onPageChanged: (int index) {
       if(index == boarding.length - 1) {
         setState(() {
           isLast = true;
         });
       } else {
         setState(() {
           isLast = false;
         });
       };
       if (index == boarding.length -3) {
         setState(() {
           isFirst = true;
         });
       } else {
         setState(() {
           isFirst = false;
         });
       };
     },
   ),
 );

 /// Page View Details
 Widget _buildPageViewDetails(boardingInfo model,context)=> Column(
   crossAxisAlignment: CrossAxisAlignment.center,
   children: [
     Padding(
       padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
       child: Image(
         image: AssetImage('${model.image}'),

       ),
     ),
     SizedBox(height: 20,),
     Text(
       model.title,
         style: Theme.of(context).textTheme.headline5!.copyWith(
             fontWeight: FontWeight.w900,
           fontSize: 30,
           fontFamily: 'pretty1',
           color: Colors.grey[700],
         ),
     ),
     SizedBox(height: 15,),
     Padding(
       padding: const EdgeInsets.symmetric(horizontal: 40),
       child: Text(
         model.body,
         style: Theme.of(context).textTheme.subtitle1!.copyWith(
           fontWeight: FontWeight.w600,
           fontSize: 14,
           color: Colors.grey,
           fontFamily: 'pretty1',
           // height: 1.2
         ),
       ),
     ),
   ],
 );

 /// Skip & Let's Starting Button and Smooth Page Indicator
 Widget _buildButtonAndSmoothPageIndicator()=> Column(
   children: [
     if(isLast == false)
       TextButton(
         onPressed: onSubmit,
         child: Text(
           'SKIP',
           style: TextStyle(
               color: Colors.amber[600],
               fontFamily: 'pretty1',
               fontWeight: FontWeight.bold
           ),
         ),
       ),
     if(isLast)
       OutlinedButton(
         style: TextButton.styleFrom(
           // side: BorderSide(width: 1,color: Colors.grey),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
         ),
         onPressed: onSubmit,
         child: Text(
           'Let\'s Starting',
           style: TextStyle(
             color: Colors.amber[600],
           ),
         ),
       ),
     SizedBox(height: 10,),
     SmoothPageIndicator(
       controller: boardingController,
       count: boarding.length,
       effect: ScrollingDotsEffect(
         spacing: 35,
         dotHeight: 10,
         dotWidth: 10,
         activeDotColor: Colors.amber[600]!,
         dotColor: Colors.grey[300]!,
       ),
     ),
     SizedBox(height: 40,),
   ],
 );


 /// Screen Models
 List<boardingInfo> boarding = [
   boardingInfo(
     image: 'assets/images/map.jpg',
     title: 'Destination',
     body: 'Lorem ipsum dolor sit amet elit consectetur adipiscing, tempus nostra lacinia adipiscing.',
   ),
   boardingInfo(
     image: 'assets/images/card.jpg',
     title: 'Make Payment',
     body: 'Lorem ipsum dolor sit amet consectetur adipiscing, tempus nostra lacinia adipiscing, tempus nostra lacinia nostra lacinia.',
   ),
   boardingInfo(
     image: 'assets/images/delivery.jpg',
     title: 'Delivering',
     body: 'Lorem ipsum dolor sit amet elit consectetur adipiscing, tempus nostra lacinia adipiscing, tempus nostra lacinia nostra lacinia.',
   ),
 ];

}




