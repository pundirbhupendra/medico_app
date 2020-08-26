import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medico_app/src/presentation/widget/common_button.dart';
import 'package:medico_app/src/res/app_color.dart';
import 'package:medico_app/src/res/style.dart';
import 'data/service/shared_preferences_service.dart';
import 'route/router.gr.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 5;
  int _currentPage = 0;
  final PageController _pageController = PageController();

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 1.0),
      height: 4.0,
      width: isActive ? 6.0 : 5.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        // borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  SharedPreferencesService sharedPreferencesService;
  @override
  void initState() {
    _checkUserLogin();
    super.initState();
  }

  var mobileNo = '';
  bool isMobileSave = false;
  _checkUserLogin() async {
    sharedPreferencesService = await SharedPreferencesService.instance;
    final isLogout = await sharedPreferencesService.isUserLogOut();
    print(isLogout);
    if (sharedPreferencesService != null) {
      if (sharedPreferencesService.getUserPhoneNo() != null) {
        // setState(() {
        //   mobileNo = sharedPreferencesService.getString("mobileNo");
        //   isMobileSave = true;
        //   _currentPage = _numPages - 1;
        //   _pageController.jumpToPage(_numPages - 1);
        // });
      

      
      }
        if (isLogout !=null) {
          setState(() {
            mobileNo = sharedPreferencesService.getUserPhoneNo();
            isMobileSave = true;
            _currentPage = _numPages - 1;
            _pageController.jumpToPage(_numPages - 1);
          });
        }
  if (sharedPreferencesService.getToken() != null) {
        Navigator.pushReplacementNamed(context, Router.homePage);
       }
   }
    //user login
  }

  final image3 =
      "https://images-na.ssl-images-amazon.com/images/I/51KSHMWpJWL._SX355_.jpg";
  // final image1 =
  // "https://www.tricitymed.org/wp-content/uploads/2016/05/find-a-doctor-san-diego-300x199.jpg";
  final image5 =
      "https://us.123rf.com/450wm/llesia/llesia1603/llesia160300030/53519430-clipboard-in-his-hand-doctor-hand-holding-clipboard-with-checklist-and-pen-for-medical-report-presen.jpg?ver=6";
  //final image2 =
  // "https://cdn1.vectorstock.com/i/1000x1000/63/75/online-doctor-chatting-smartphone-interface-vector-29126375.jpg";

  @override
  Widget build(BuildContext context) {
   // print(sharedPreferencesService.isUserLogOut());
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: ListView(
          primary: false,
          shrinkWrap: true,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.80,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      //  Spacer(),

                      Container(
                        color: Colors.black12,
                       height: 200,
                       width:200,
                       child: Center(child: Text("Comming Soon",
                        style: TextStyle(color:Colors.white),
                       )),
                      ),
                      SizedBox(height: 10),
                      // CachedNetworkImage(
                      //   imageUrl:
                      //       'https://www.jing.fm/clipimg/detail/29-294823_medicine-clipart-doctor-equipment-medical-products-clipart-transparent.png',
                      //   height: MediaQuery.of(context).size.height * 0.6,
                      //   width: MediaQuery.of(context).size.height * 0.5,
                      //   colorBlendMode: BlendMode.color,
                      //   color: AppColors.primaryColor,
                      //   progressIndicatorBuilder:
                      //       (context, url, downloadProgress) =>
                      //           CircularProgressIndicator(
                      //               value: downloadProgress.progress),
                      //   errorWidget: (context, url, error) => Icon(Icons.error),
                      // ),

                      // Spacer(),
                      Text(
                        'Book an appointment with \n the right doctor!',
                        style: kTitleStyle,
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl:
                            'https://cdn.iconscout.com/icon/premium/png-256-thumb/chat-with-lady-doctor-3-1149065.png',
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.height * 0.6,
                        // colorBlendMode: BlendMode.colorBurn,

                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Too busy to see a doctor?\n Chat online instead.',
                        style: kTitleStyle,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl:
                            'https://cdn.iconscout.com/icon/premium/png-256-thumb/medicine-box-1612341-1364477.png',
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.height * 0.6,
                        // colorBlendMode: BlendMode.colorBurn,
                        // color: Colors.red,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Get medicines delivered to\n your doorstep',
                        style: kTitleStyle,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: image5,
                        height: 200,
                        colorBlendMode: BlendMode.color,
                        color: Colors.red,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Keep Your medical history\n handy',
                        style: kTitleStyle,
                      ),
                    ],
                  ),
                  _finalPage(),
                ],
              ),
            ),
            Column(
            //  crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _currentPage != _numPages - 1
                        ? CommonButton(
                            title: "Get Started",
                            titleColor: AppColors.primaryColor,
                            onTap: () {
                              setState(() {
                                _currentPage = _numPages - 1;
                                _pageController.jumpToPage(_numPages - 1);
                              });
                            },
                          )
                        : SizedBox()
                  ],
                ),
                SizedBox(height: 30),
                 _currentPage == _numPages - 1? Text('By Continuing You Are Agree To Terms & Conditions',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.white,fontSize: 10
                ),
                
                ):SizedBox()
              ],
            ),
          ],
        ));
  }

  _finalPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

     Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         CircleAvatar(
           maxRadius:4,
           foregroundColor: Colors.white,
          // backgroundColor: Colors.white,
         ),
         Text('Medico',style: GoogleFonts.calistoga(
           fontSize: 25,color: Colors.white
         )),
         CircleAvatar(
           maxRadius:4,
           foregroundColor: Colors.white,
          // backgroundColor: Colors.white,
         )
       ],
     ),
     SizedBox(height: 20),
        InkWell(
          onTap: () {
            _loginToUser();
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Center(
                child: isMobileSave
                    ? Text('Login With $mobileNo',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ))
                    : Text('Please Login here !',
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ))),
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          ),
        ),
        SizedBox(height: 20),
        InkWell(
            onTap: () {
              Navigator.pushNamed(context, Router.signUpPage);
            },
            child: Text('Not have an account Please Register in here?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 12
                ))),
                
              
      ],
    );
  }

  _loginToUser() {
    
   Navigator.pushNamed(context, Router.loginPage);
  }
}
