import 'package:alumni_management_admin/Screens/Dashboard.dart';
import 'package:alumni_management_admin/Screens/usersmanagment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


List<bool> isSelected = [true, false, false, false, false,false, false, false, false,];
List<NavElement> navElements = [
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
  NavElement(),
];
List<String> texts = [
  'Dashboard',
  'User Management',
  'Reports',
  'Users',
  'Gallery',
  'News ',
  'Messages',
  'Setting',
  'Sign out',
];
List<IconData> icons = [
  Icons.data_saver_off,
  Icons.groups,
  Icons.auto_graph_rounded,
  Icons.person_outlined,
  Icons.image_outlined,
  Icons.newspaper_sharp,
  Icons.message,
  Icons.settings,
  Icons.logout_sharp,
];

class MyWidget extends StatefulWidget {
  const MyWidget({Key ?key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  void select(int n) {
    for (int i = 0; i < 9; i++) {
      if (i == n)
        isSelected[i] = true;
      else
        isSelected[i] = false;
    }
  }
  var pages;
  @override
  void initState() {
    setState(() {
      pages = DashBoard();
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFAFBFC),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 670.0,
                  width: 230.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 14.0,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
                            child: Container(
                                width: 45,
                                height: 45,
                                child: Image.asset("assets/dummy logo.png")),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text("Alumni \nAssociation",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 20
                          ),)

                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: navElements
                            .map(
                              (e) => NavElement(
                            index: navElements.indexOf(e),
                            text: texts[navElements.indexOf(e)],
                            icon: icons[navElements.indexOf(e)],
                            active: isSelected[navElements.indexOf(e)],
                            onTap: () {
                              setState(() {
                                select(navElements.indexOf(e));
                                if(navElements.indexOf(e)==0){
                                  setState(() {
                                    pages=DashBoard();
                                  });
                                }
                                if(navElements.indexOf(e)==1){
                                  setState(() {
                                    pages=UsersManagement();
                                  });
                                }
                              });
                            },
                          ),
                        )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: pages
            )

          ],
        ),
      ),
    );
  }
}

class NavElement extends StatefulWidget {
  final bool ? active;
  final Function ? onTap;
  final IconData ? icon;
  final String ? text;
  final int ? index;

  NavElement({this.onTap, this.active, this.icon, this.text, this.index});

  @override
  _NavElementState createState() => _NavElementState();
}

Color conColor = Colors.white;

class _NavElementState extends State<NavElement> with TickerProviderStateMixin {
  late AnimationController _tcc; //text color controller
  late Animation<Color?> _tca; //text color animation
  late AnimationController _icc; //icon color controller
  late Animation<Color?> _ica; //icon color animation
  late AnimationController _lsc; //letter spacing controller
  late Animation<double> _lsa; //letter spacing animation
  double width = 140.0;
  double opacity = 0.0;

  @override
  void initState() {
    print('hello');
    super.initState();
    _tcc = AnimationController(
        duration: Duration(milliseconds: 375),
        reverseDuration: Duration(milliseconds: 300),
        vsync: this);
    _tca = ColorTween(begin: Colors.black54, end: Colors.black).animate(
        CurvedAnimation(
            parent: _tcc, curve: Curves.easeOut, reverseCurve: Curves.easeIn));

    _tcc.addListener(() {
      setState(() {});
    });

    _icc = AnimationController(
        duration: Duration(milliseconds: 375),
        reverseDuration: Duration(milliseconds: 300),
        vsync: this);
    _ica = ColorTween(begin: Colors.black, end: Colors.white).animate(
        CurvedAnimation(
            parent: _icc, curve: Curves.easeOut, reverseCurve: Curves.easeIn));

    _icc.addListener(() {
      setState(() {});
    });

    _lsc = AnimationController(
        duration: Duration(milliseconds: 375),
        reverseDuration: Duration(milliseconds: 300),
        vsync: this);
    _lsa = Tween(begin: 0.0, end: 1.5).animate(CurvedAnimation(
        parent: _lsc, curve: Curves.easeOut, reverseCurve: Curves.easeIn));

    _lsc.addListener(() {
      setState(() {});
    });

   if (widget.active!) {
      _icc.forward();
      _tcc.forward();
      _lsc.forward();
    }

    // To delay arrival of each Nav bar element
    Future.delayed(Duration(milliseconds: 150 * (widget.index! + 1)), () {
      setState(() {
        width = 0.0;
        opacity = 1.0;
        print(1000 ~/ (5 - (widget.index!)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active!) {
      _icc.reverse();
    }
    return MouseRegion(
      onEnter: (value) {
        _tcc.forward();
        _lsc.forward();
      },
      onExit: (value) {
        _tcc.reverse();
        _lsc.reverse();
      },
      opaque: false,
      child: GestureDetector(
        onTap: () {
          widget.onTap!();
          _icc.forward();
          _tcc.forward();
          _lsc.forward();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
          padding: EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
          height: 60.0,
          width: 200.0,
          child: Row(
            children: [
              AnimatedContainer(
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 300),
                height: widget.active! ? 45.0 : 35.0,
                width: widget.active! ? 195.0 : 35.0,
                decoration: BoxDecoration(
                  color: widget.active! ? Color(0xff5D5FEF) : Colors.white,
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(
                      widget.icon,
                      color: _ica.value,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Stack(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 375),
                          height: 60.0,
                          width: 130.0,
                          alignment: Alignment((width == 0.0) ? -0.9 : -1.0,
                              (width == 0.0) ? 0.0 : -0.9),
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 375),
                            opacity: opacity,
                            child: Text(
                              widget.text!,
                              style: GoogleFonts.poppins(
                                fontWeight: widget.active! ? FontWeight.w500: FontWeight.w500,
                                color: widget.active! ? Colors.white : _tca.value,
                                letterSpacing: widget.active! ? 2.0 : _lsa.value,
                                fontSize: widget.active! ? 13.0 : 12.0,
                              ),
                            ),
                          ),
                        ),
                        Positioned( // Supports the entrance animation
                          right: 0.0,
                          child: AnimatedContainer(
                            height: 60.0,
                            width: width,
                            color: Colors.white,
                            duration: Duration(milliseconds: 375),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
