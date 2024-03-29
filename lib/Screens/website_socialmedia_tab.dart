import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx/webviewx.dart';

import 'dart:ui' as ui;

import '../Models/Language_Model.dart';
import '../common_widgets/developer_card_widget.dart';
import '../utils.dart';

class WebsiteAndSocialMediaTab extends StatefulWidget {
  const WebsiteAndSocialMediaTab({super.key});

  @override
  State<WebsiteAndSocialMediaTab> createState() => _WebsiteAndSocialMediaTabState();
}

class _WebsiteAndSocialMediaTabState extends State<WebsiteAndSocialMediaTab> {

  late WebViewXController webviewControllerfacebook;
  late WebViewXController webviewControllerinsta;
  late WebViewXController webviewControlleralumni;

  String facebookUrl = 'https://www.facebook.com/';
  String instaUrl = 'https://www.instagram.com/';
  String youtubeUrl = 'https://youtube.com/';

  bool isView = false;
  bool isFacebook = false;
  bool isInsta = false;

  final initialContent = '<h4> The Page is being loaded Please wait... <h2>';

  @override
  void initState() {
    getAdmin();
    super.initState();
  }

  @override
  void dispose() {
    webviewControllerinsta.dispose();
    webviewControllerfacebook.dispose();
    webviewControlleralumni.dispose();
    super.dispose();
  }

  String alumniLogo = '';
  String alumniWebsite = '';

  getAdmin() async {
    var churchDetails = await FirebaseFirestore.instance.collection('ChurchDetails').get();
    setState(() {
      alumniLogo = churchDetails.docs.first.get("logo");
      alumniWebsite = churchDetails.docs.first.get("website");
    });
  }

  Future<void> launch(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Visibility(
                    visible: isView,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            setState(() {
                              isView = false;
                            });
                          },
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                  KText(
                    text: "Alumni Social Media",
                    style: SafeGoogleFont (
                      'Poppins',
                      fontSize: 36*ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.3999999364*ffem/fem,
                      color: const Color(0xff151d48),
                    ),
                  )],
              ),
            ),
            SizedBox(height: 20),
            !isView
                ? Container(
              height: size.height*0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap:() async {
                            // setState(() {
                            //   isView = true;
                            //   isFacebook = true;
                            //   isInsta = false;
                            // });
                            // await Future.delayed(Duration(seconds: 2)).then((value){
                            //   webviewControllerfacebook.loadContent(
                            //     facebookUrl,
                            //     SourceType.url,
                            //   );
                            // });
                            launch(facebookUrl);
                          },
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Center(
                                        child: Icon(
                                          Icons.facebook,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    KText(
                                      text: "Facebook",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap:() async {
                            // setState(() {
                            //   isView = true;
                            //   isFacebook = false;
                            //   isInsta = true;
                            // });
                            // await Future.delayed(Duration(seconds: 2)).then((value){
                            //   webviewControllerinsta.loadContent(
                            //     instaUrl,
                            //     SourceType.url,
                            //   );
                            // });
                            launch(instaUrl);
                          },
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 300,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.purple,
                                    Colors.pink,
                                    Colors.orange,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Center(
                                        child: Image.asset(
                                          "assets/insta.png",
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                    ),
                                    KText(
                                      text: "Instagram",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap:(){

                          },
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Center(
                                          child: KText(
                                            text: "X",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                      ),
                                    ),
                                    KText(
                                      text: "X",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        InkWell(
                          onTap:(){

                          },
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Center(
                                        child: Image.asset(
                                          "assets/thread.png",
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                    ),
                                    KText(
                                      text: "Thread",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap:() async {
                            // setState(() {
                            //   isView = true;
                            //   isFacebook = false;
                            //   isInsta = false;
                            // });
                            // await Future.delayed(Duration(seconds: 2)).then((value){
                            //   webviewControllerchurch.loadContent(
                            //     churchWebsite,
                            //     SourceType.url,
                            //   );
                            // });
                            launch(alumniWebsite);
                          },
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Image.network(
                                            alumniLogo,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    KText(
                                      text: "alumni Website",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap:() async {
                            // setState(() {
                            //   isView = true;
                            //   isFacebook = false;
                            //   isInsta = false;
                            // });
                            // await Future.delayed(Duration(seconds: 2)).then((value){
                            //   webviewControllerchurch.loadContent(
                            //     churchWebsite,
                            //     SourceType.url,
                            //   );
                            // });
                            launch(youtubeUrl);
                          },
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Color(0xffFF0000),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Center(
                                          child: Icon(Icons.play_arrow,color: Colors.white,)
                                      ),
                                    ),
                                    KText(
                                      text: "YouTube",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    SizedBox(height: size.height * 0.04),
                    const DeveloperCardWidget(),
                    SizedBox(height: size.height * 0.01),
                  ],
                ),
              ),
            )
                : Container(
              height: 550,
              width: double.infinity,
              child: isFacebook ? _buildWebViewXFacebook() : isInsta ? _buildWebViewXInsta() : _buildWebViewXChurch(),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildWebViewXInsta() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: initialContent,
      initialSourceType: SourceType.html,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      onWebViewCreated: (controller) => webviewControllerinsta = controller,
      onPageStarted: (src) =>
          debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (src) =>
          debugPrint('The page has finished loading: $src\n'),
      jsContent: const {
        EmbeddedJsContent(
          js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
        ),
        EmbeddedJsContent(
          webJs:
          "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
          mobileJs:
          "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
        ),
      },
      webSpecificParams: const WebSpecificParams(
        printDebugInfo: true,
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.navigate;
      },
    );
  }

  Widget _buildWebViewXFacebook() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: initialContent,
      initialSourceType: SourceType.html,
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      onWebViewCreated: (controller) => webviewControllerfacebook = controller,
      onPageStarted: (src) =>
          debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (src) =>
          debugPrint('The page has finished loading: $src\n'),
      jsContent: const {
        EmbeddedJsContent(
          js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
        ),
        EmbeddedJsContent(
          webJs:
          "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
          mobileJs:
          "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
        ),
      },

      webSpecificParams: const WebSpecificParams(
        printDebugInfo: true,
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.navigate;
      },
    );
  }

  Widget _buildWebViewXChurch() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: initialContent,
      initialSourceType: SourceType.html,
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      onWebViewCreated: (controller) => webviewControlleralumni = controller,
      onPageStarted: (src) =>
          debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (src) =>
          debugPrint('The page has finished loading: $src\n'),
      jsContent: const {
        EmbeddedJsContent(
          js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
        ),
        EmbeddedJsContent(
          webJs:
          "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
          mobileJs:
          "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
        ),
      },

      webSpecificParams: const WebSpecificParams(
        printDebugInfo: true,
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.navigate;
      },
    );
  }


}
