import 'package:flutter/material.dart';
import 'dart:math';
import 'package:alumni_management_admin/Models/Language_Model.dart';
import 'package:alumni_management_admin/common_widgets/developer_card_widget.dart';
import 'package:alumni_management_admin/utils.dart';
import 'package:animate_do/animate_do.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Constant_.dart';

class HousesMaster extends StatefulWidget {
  const HousesMaster({Key? key}) : super(key: key);

  @override
  State<HousesMaster> createState() => _HousesMasterState();
}

class _HousesMasterState extends State<HousesMaster> {
  TextEditingController departmentnameContoller=TextEditingController();

  bool filtervalue=false;
  String filterChangeValue="name";
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List datalist = [
    "Edit",
    "Delete",
  ];

  int pagecount = 0;
  int temp = 1;
  List list = new List<int>.generate(1000, (i) => i + 1);
  List <DocumentSnapshot>documentList = [];
  int documentlength =0 ;

  doclength() async {

    final QuerySnapshot result = await FirebaseFirestore.instance.collection("Houses").get();

    final List < DocumentSnapshot > documents = result.docs;

    setState(() {
      documentlength = documents.length;
      pagecount= ((documentlength~/10) +1);
    });
    print(pagecount);
    print(documentlength);
    print("Document Total Length+++++++++++++++++++++++++++++++++++++++++++++++++");
  }

  @override
  void initState() {
    doclength();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.only(left:width/170.75,top: height/54.25),
      child: FadeInRight(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: EdgeInsets.symmetric(vertical: height/81.375, horizontal: width/170.75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    KText(
                      text: "Houses",
                      style: SafeGoogleFont (
                          'Nunito',
                          fontSize: width / 82.538,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left:width/1.39),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          departmentnameContoller.clear();
                        });
                        addItemPopUp();
                      },
                      child: Container(
                        height: height / 16.275,
                        width: width/10.9714,
                        decoration: BoxDecoration(
                          color: Constants().primaryAppColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1, 2),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child:
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width / 227.66),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add,color:Colors.white),
                              KText(
                                text: "Add",
                                style: SafeGoogleFont(
                                  'Nunito',
                                  fontSize: width / 120.571,
                                  color:Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Container(
                width:width/1.26,
                height:height/12.316666,
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/455.33,vertical: height/217),
                  child: Row(
                    children: [
                      SizedBox(
                        width:width/12.075,
                        child: Row(
                          children: [
                            KText(
                              text: "SL.No.",
                              style:  SafeGoogleFont (
                                'Nunito',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8),
                              child: Transform.rotate(
                                angle:  0,
                                child: Opacity(
                                  // arrowdown2TvZ (8:2307)
                                  opacity: 0.7,
                                  child: Container(
                                    width: width/153.6,
                                    height: height/73.9,
                                    child: Image.asset(
                                      'assets/images/arrow-down-2.png',
                                      width: width/153.6,
                                      height: height/73.9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width/1.85,
                        child: Row(
                          children: [
                            KText(
                              text: "Name",
                              style:  SafeGoogleFont (
                                'Nunito',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    filtervalue = !filtervalue;
                                    filterChangeValue="name";
                                  });
                                },
                                child: Transform.rotate(
                                  angle: filterChangeValue=="name"&&filtervalue ? 200 : 0,
                                  child: Opacity(
                                    // arrowdown2TvZ (8:2307)
                                    opacity: 0.7,
                                    child: Container(
                                      width: width/153.6,
                                      height: height/73.9,
                                      child: Image.asset(
                                          'assets/images/arrow-down-2.png',
                                          width: width/153.6,
                                          height: height/73.9,
                                          color:filterChangeValue=="name"&&filtervalue?Colors.green:Colors.transparent
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width:width/7.588,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KText(
                              text: "Actions",
                              style:  SafeGoogleFont (
                                'Nunito',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8),
                              child: Transform.rotate(
                                angle: 0,
                                child: Opacity(
                                  // arrowdown2TvZ (8:2307)
                                  opacity: 0.7,
                                  child: Container(
                                    width: width/153.6,
                                    height: height/73.9,


                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                child: SizedBox(
                  width:width/1.26,
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      children: [
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("Houses").orderBy(filterChangeValue,descending: filtervalue).snapshots(),
                          builder: (context, snapshot) {

                            if(snapshot.hasData==null){
                              return const Center(child: CircularProgressIndicator(),);
                            }
                            if(!snapshot.hasData){
                              return const Center(child: CircularProgressIndicator(),);
                            }

                            // return SingleChildScrollView(
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   child: Column(
                            //     children: [
                            //       SizedBox(
                            //         height:height/1.55,
                            //         child: ListView.builder(
                            //           shrinkWrap: true,
                            //           physics: const NeverScrollableScrollPhysics(),
                            //           itemCount:  pagecount == temp ? snapshot.data!.docs.length.remainder(10) == 0 ? 10 : snapshot.data!.docs.length.remainder(10) : 10 ,
                            //           itemBuilder: (context, index) {
                            //             var DepartmentData=snapshot.data!.docs[(temp*10)-10+index];
                            //             List<GlobalKey<State<StatefulWidget>>>popMenuKeys = List.generate(snapshot.data!.docs.length, (index) => GlobalKey(),);
                            //             return
                            //               ((temp*10)-10+index >= documentlength)?const SizedBox():
                            //               SizedBox(
                            //               height: height/15.850,
                            //               width: double.infinity,
                            //               child: Row(
                            //                 children: [
                            //                   SizedBox(
                            //                     width:width/12.075,
                            //                     child:
                            //                     KText(
                            //                       text: "${((temp*10)-10+index) + 1}",
                            //                       style:  SafeGoogleFont (
                            //                         'Nunito',
                            //                         fontSize:width/105.07,
                            //                         fontWeight: FontWeight.w600,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                   SizedBox(
                            //                     width: width/1.9,
                            //                     child:
                            //                     KText(
                            //                       text: DepartmentData['name'].toString(),
                            //                       style:  SafeGoogleFont (
                            //
                            //                         'Nunito',
                            //                         fontSize:width/105.07,
                            //                         fontWeight: FontWeight.w600,
                            //                       ),
                            //                     ),
                            //
                            //                   ),
                            //
                            //                   GestureDetector(
                            //                     onTap: () {
                            //                       Popupmenu(context, popMenuKeys[index], size,DepartmentData['name'].toString(),snapshot.data!.docs[index].id);
                            //                     },
                            //                     child: SizedBox(
                            //                         key: popMenuKeys[index],
                            //                         width:width/7.588,
                            //                         child: const Icon(
                            //                             Icons.more_horiz)),
                            //                   ),
                            //
                            //                 ],
                            //               ),
                            //
                            //             );
                            //           },),
                            //
                            //       ),
                            //       Stack(
                            //         alignment: Alignment.centerRight,
                            //         children: [
                            //           SizedBox(
                            //             width: double.infinity,
                            //             height:height/13.02,
                            //             child: ListView.builder(
                            //                 shrinkWrap: true,
                            //                 scrollDirection: Axis.horizontal,
                            //                 itemCount: pagecount,
                            //                 itemBuilder: (context,index){
                            //                   return InkWell(
                            //                     onTap: (){
                            //                       setState(() {
                            //                         temp=list[index];
                            //                       });
                            //                       print(temp);
                            //                     },
                            //                     child: Container(
                            //                         height:30,width:30,
                            //                         margin: const EdgeInsets.only(left:8,right:8,top:10,bottom:10),
                            //                         decoration: BoxDecoration(
                            //                             borderRadius: BorderRadius.circular(100),
                            //                             color:temp.toString() == list[index].toString() ?  Constants().primaryAppColor : Colors.transparent
                            //                         ),
                            //                         child: Center(
                            //                           child: Text(list[index].toString(),style: SafeGoogleFont(
                            //                               'Nunito',
                            //                               fontWeight: FontWeight.w700,
                            //                               color: temp.toString() == list[index].toString() ?  Colors.white : Colors.black
                            //
                            //                           ),),
                            //                         )
                            //                     ),
                            //                   );
                            //
                            //                 }),
                            //           ),
                            //           temp > 1 ?
                            //           Padding(
                            //             padding: const EdgeInsets.only(right: 150.0),
                            //             child:
                            //             InkWell(
                            //               onTap:(){
                            //                 setState(() {
                            //                   temp= temp-1;
                            //                 });
                            //               },
                            //               child: Container(
                            //                   height:height/16.275,
                            //                   width:width/11.3833,
                            //                   decoration:BoxDecoration(
                            //                       color:Constants().primaryAppColor,
                            //                       borderRadius: BorderRadius.circular(80)
                            //                   ),
                            //                   child: Center(
                            //                     child: Text("Previous Page",style: SafeGoogleFont(
                            //                       'Nunito',
                            //                       fontWeight: FontWeight.w700,
                            //                       color: Colors.white,
                            //                     ),),
                            //                   )),
                            //             ),
                            //           )  : Container(),
                            //           Container(
                            //             child: temp < pagecount ?
                            //             Padding(
                            //               padding: const EdgeInsets.only(right: 20.0),
                            //               child: InkWell(
                            //                 onTap:(){
                            //                   setState(() {
                            //                     temp= temp+1;
                            //                   });
                            //                 },
                            //                 child:
                            //                 Container(
                            //                     height:height/16.275,
                            //                     width:width/11.3833,
                            //                     decoration:BoxDecoration(
                            //                         color:Constants().primaryAppColor,
                            //                         borderRadius: BorderRadius.circular(80)
                            //                     ),
                            //                     child: Center(
                            //                       child: Text("Next Page",style: SafeGoogleFont(
                            //                         'Nunito',
                            //                         fontWeight: FontWeight.w700,
                            //                         color: Colors.white,
                            //                       ),),
                            //                     )),
                            //               ),
                            //             )  : Container(),
                            //           )
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // );
                            //


                            return SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height / 1.55,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: pagecount == temp
                                          ? snapshot.data!.docs.length.remainder(10) == 0
                                          ? 10
                                          : snapshot.data!.docs.length.remainder(10)
                                          : 10,
                                      itemBuilder: (context, index) {
                                        // Calculate the actual index of the item based on the current page (temp)
                                        int actualIndex = (temp - 1) * 10 + index;
                                        if (actualIndex >= snapshot.data!.docs.length) {
                                          return const SizedBox();
                                        }
                                        var DepartmentData = snapshot.data!.docs[actualIndex];
                                        List<GlobalKey<State<StatefulWidget>>> popMenuKeys =
                                        List.generate(snapshot.data!.docs.length, (index) => GlobalKey(),);
                                        return SizedBox(
                                          height: height / 15.850,
                                          width: double.infinity,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width / 12.075,
                                                child: KText(
                                                  text: "${actualIndex + 1}",
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: width / 105.07,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width / 1.9,
                                                child: KText(
                                                  text: DepartmentData['name'].toString(),
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: width / 105.07,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Popupmenu(context, popMenuKeys[index], size,
                                                      DepartmentData['name'].toString(), DepartmentData.id);
                                                },
                                                child: SizedBox(
                                                  key: popMenuKeys[index],
                                                  width: width / 7.588,
                                                  child: const Icon(Icons.more_horiz),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: height / 13.02,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: pagecount,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  temp = list[index];
                                                });
                                                print(temp);
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                margin: const EdgeInsets.only(
                                                    left: 8, right: 8, top: 10, bottom: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: temp.toString() == list[index].toString()
                                                      ? Constants().primaryAppColor
                                                      : Colors.transparent,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    list[index].toString(),
                                                    style: SafeGoogleFont(
                                                      'Nunito',
                                                      fontWeight: FontWeight.w700,
                                                      color: temp.toString() == list[index].toString()
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      temp > 1
                                          ? Padding(
                                        padding: const EdgeInsets.only(right: 150.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              temp = temp - 1;
                                            });
                                          },
                                          child: Container(
                                            height: height / 16.275,
                                            width: width / 11.3833,
                                            decoration: BoxDecoration(
                                              color: Constants().primaryAppColor,
                                              borderRadius: BorderRadius.circular(80),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Previous Page",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                          : Container(),
                                      Container(
                                        child: temp < pagecount
                                            ? Padding(
                                          padding: const EdgeInsets.only(right: 20.0),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                temp = temp + 1;
                                              });
                                            },
                                            child: Container(
                                              height: height / 16.275,
                                              width: width / 11.3833,
                                              decoration: BoxDecoration(
                                                color: Constants().primaryAppColor,
                                                borderRadius: BorderRadius.circular(80),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Next Page",
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                            : Container(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );


                          },),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height / 65.1),
              const DeveloperCardWidget(),
              SizedBox(height: height / 65.1),

            ],
          ),
        ),
      ),
    );
  }

  viewPopup(Name) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (ctx) {

        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            width: size.width * 0.5,
            height:height/3.695,
            // margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
            decoration: BoxDecoration(
              color: Constants().primaryAppColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1, 2),
                  blurRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                  width: double.infinity,
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/81.375),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Academic Year Details",
                          style:  SafeGoogleFont (
                            'Nunito',
                            fontSize: width/78.3,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: height/16.275,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1, 2),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal:width/227.66),
                              child: Center(
                                child: KText(
                                  text: "CLOSE",
                                  style:  SafeGoogleFont (
                                    'Nunito',
                                    fontSize: width/105.375,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(left:width/61.44),
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.15,
                            child: KText(
                              text: "Name",
                              style: SafeGoogleFont (
                                  'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: width/95.375
                              ),
                            ),
                          ),
                          const Text(":"),
                          SizedBox(width: width/68.3),
                          Text(
                            Name.toString(),
                            style: SafeGoogleFont (
                                'Nunito',
                                fontSize: width/105.571
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      },
    );
  }


  editPopUp(Docid,name) {

    setState(() {
      departmentnameContoller.text=name;
    });
    double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                  width:width/2.56,
                  height:height/2.956,
                  // margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        SizedBox(
                          width:width/1.70666,
                          height: height/9.2375,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/81.375),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: "EDIT Item",
                                      style:  SafeGoogleFont (
                                        'Nunito',
                                        fontSize: width/88.3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: width/5.12,),
                                    /*Row(
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            FirebaseFirestore.instance.collection("Department").doc(Docid).update({
                                              "name":departmentnameContoller.text
                                            });
                                            Navigator.pop(context);

                                          },
                                          child: Container(
                                            height: height/16.275,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(1, 2),
                                                  blurRadius: 3,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                              EdgeInsets.symmetric(horizontal:width/227.66),
                                              child: Center(
                                                child: KText(
                                                  text: "UPDATE",
                                                  style:  SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: width/105.375,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: width/136.6),
                                        InkWell(
                                          onTap: () async {

                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: height/16.275,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(1, 2),
                                                  blurRadius: 3,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                              EdgeInsets.symmetric(horizontal:width/227.66),
                                              child: Center(
                                                child: KText(
                                                  text: "CANCEL",
                                                  style:  SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: width/105.375,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                            height: height/14.78,
                            width: width/5.12,
                            margin: EdgeInsets.only(bottom: height/73.9),
                            decoration: BoxDecoration(
                                color: const Color(
                                    0xffDDDEEE),
                                borderRadius:
                                BorderRadius.circular(
                                    3)),
                            child:
                            TextFormField(
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .allow(RegExp(
                                    "[a-zA-Z ]")),
                              ],
                              controller:departmentnameContoller,
                              decoration: InputDecoration(
                                border:
                                InputBorder
                                    .none,
                                contentPadding: EdgeInsets.only(
                                    bottom:
                                    height/73.9,
                                    top: height/369.5,
                                    left:
                                    width/153.6),
                                counterText:
                                "",
                              ),
                              validator: (value)=>value!.isEmpty?"Field is Required":null,
                            )),

                        Padding(
                          padding:  EdgeInsets.only(top:height/30.39),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: width/5.2925,
                              ),

                              /// Update Button
                              GestureDetector(
                                onTap:(){
                                  if(_formkey.currentState!.validate()){
                                    FirebaseFirestore.instance.collection("Houses").doc(Docid).update({
                                      "name":departmentnameContoller.text

                                    });
                                    Navigator.pop(context);
                                    final snackBar = SnackBar(content: AwesomeSnackbarContent(title: 'Sucess!', message: 'Updated this Houses', contentType: ContentType.success,),);
                                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
                                  }

                                },
                                child: Container(
                                    height: height/18.475,
                                    width: width/12.8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffD60A0B),
                                      borderRadius:
                                      BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: KText(
                                        text: 'Update',
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width/96,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: const Color(0xffFFFFFF),
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: width/76.8,
                              ),

                              ///Cancel Button
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    departmentnameContoller.clear();
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    height: height/18.475,
                                    width: width/12.8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff00A0E3),
                                      borderRadius:
                                      BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: KText(
                                        text: 'Cancel',
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width/96,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: const Color(0xffFFFFFF),
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: width/76.8,
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
        );
      },
    );
  }

  addItemPopUp() {
    double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                  width:width/2.56,
                  height:height/2.956,
                  // margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width:width/1.70666,
                          height: height/9.2375,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/81.375),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: "Add Item",
                                      style:  SafeGoogleFont (
                                        'Nunito',
                                        fontSize: width/88.3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: width/5.12,),
                                    /* Row(
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            FirebaseFirestore.instance.collection("Department").doc().set({
                                              "name":departmentnameContoller.text,
                                              "timestamp":DateTime.now().millisecondsSinceEpoch
                                            });
                                            setState((){
                                              departmentnameContoller.clear();
                                            });
                                            Navigator.pop(context);

                                          },
                                          child: Container(
                                            height: height/16.275,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(1, 2),
                                                  blurRadius: 3,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                              EdgeInsets.symmetric(horizontal:width/227.66),
                                              child: Center(
                                                child: KText(
                                                  text: "Save",
                                                  style:  SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: width/105.375,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: width/136.6),
                                        InkWell(
                                          onTap: () async {

                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: height/16.275,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(1, 2),
                                                  blurRadius: 3,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                              EdgeInsets.symmetric(horizontal:width/227.66),
                                              child: Center(
                                                child: KText(
                                                  text: "CANCEL",
                                                  style:  SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: width/105.375,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                            height: height/14.78,
                            width: width/5.12,
                            margin: EdgeInsets.only(bottom: height/73.9),
                            decoration: BoxDecoration(
                                color: const Color(
                                    0xffDDDEEE),
                                borderRadius:
                                BorderRadius.circular(
                                    3)),
                            child:
                            TextFormField(
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .allow(RegExp(
                                    "[a-zA-Z ]")),
                              ],
                              controller:departmentnameContoller,
                              decoration: InputDecoration(
                                border:
                                InputBorder
                                    .none,
                                contentPadding: EdgeInsets.only(
                                    bottom:
                                    height/73.9,
                                    top: height/369.5,
                                    left:
                                    width/153.6),
                                counterText:
                                "",
                              ),
                              validator: (value)=>value!.isEmpty?"Field is Required":null,
                            )),
                        Padding(
                          padding:  EdgeInsets.only(top:height/30.39),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [

                              SizedBox(
                                width: width/5.2925,
                              ),

                              /// Save Button
                              GestureDetector(
                                onTap:() async {
                                  print('Justttttttttt');
                                  if(_formkey.currentState!.validate()){
                                    var document = await FirebaseFirestore.instance.collection("Houses").where("name",isEqualTo: departmentnameContoller.text).get();
                                    if(document.size <1) {
                                      FirebaseFirestore.instance.collection(
                                          "Houses").doc().set({
                                        "name": departmentnameContoller.text,
                                        "timestamp": DateTime
                                            .now()
                                            .millisecondsSinceEpoch
                                      });
                                      groupfunction();

                                      Navigator.pop(context);
                                    }
                                    else{
                                      final snackBar = SnackBar(content: AwesomeSnackbarContent(title: 'Error!', message: 'Already the Course is added', contentType: ContentType.failure,),);
                                      ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
                                      print('Added Already');
                                      Navigator.pop(context);
                                    }
                                  }


                                },
                                child: Container(
                                    height: height/18.475,
                                    width: width/12.8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffD60A0B),
                                      borderRadius:
                                      BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: KText(
                                        text: 'Save',
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width/96,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: const Color(0xffFFFFFF),
                                        ),
                                      ),
                                    )),
                              ),

                              SizedBox(
                                width: width/76.8,
                              ),

                              ///Cancel Button
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    departmentnameContoller.clear();
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    height: height/18.475,
                                    width: width/12.8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff00A0E3),
                                      borderRadius:
                                      BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: KText(
                                        text: 'Cancel',
                                        style: SafeGoogleFont(
                                          'Nunito',
                                          fontSize: width/96,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: const Color(0xffFFFFFF),
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: width/76.8,
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
        );
      },
    );
  }

  String randomOpaqueColorHex() {
    int randomColor = Random().nextInt(0xffffffff);
    return '#${randomColor.toRadixString(16).padLeft(8, '0')}';
  }
  groupfunction()async{
    var groupdocument=await FirebaseFirestore.instance.collection("Groups").where("Houses",isEqualTo:departmentnameContoller.text).get();
    Color randomColor() {
      Random random = Random();
      return Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1.0, // Full opacity
      );
    }

    print(randomColor().value.toRadixString(16));
    if(groupdocument.docs.length==0){
      var Color=randomColor().value.toRadixString(16);
      var AcademicYear= await FirebaseFirestore.instance.collection("AcademicYear").get();
      for(int i=0;i<AcademicYear.docs.length;i++){
        FirebaseFirestore.instance.collection("Groups").doc().set({
          "AccademicYear":AcademicYear.docs[i]['name'].toString(),
          "Houses":departmentnameContoller.text,
          "Img":"",
          "color":"0x${randomColor().value.toRadixString(16)}"
        });
      }

    }

    setState((){
      departmentnameContoller.clear();
    });
  }

  Popupmenu(BuildContext context, key, size,DataName,DocumentID) async {
    print(
        "Popupmenu open-----------------------------------------------------------");
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final render = key.currentContext!.findRenderObject() as RenderBox;
    await showMenu(
      color: const Color(0xffFFFFFF),
      elevation: 0,
      context: context,
      position: RelativeRect.fromLTRB(
          render.localToGlobal(Offset.zero).dx,
          render.localToGlobal(Offset.zero).dy + 50,
          double.infinity,
          double.infinity),
      items: datalist
          .map((item) => PopupMenuItem<String>(
        enabled: true,
        onTap: () async {
          if (item == "Edit") {
            editPopUp(DocumentID,DataName);
          }
          else if (item == "Delete") {
            CoolAlert.show(
                context: context,
                type: CoolAlertType.info,
                text: "${DataName} will be deleted",
                title:
                "Delete this Record?",
                width: size.width *
                    0.4,
                backgroundColor:
                Constants()
                    .primaryAppColor
                    .withOpacity(
                    0.8),
                showCancelBtn: true,
                cancelBtnText: 'Cancel',
                cancelBtnTextStyle: SafeGoogleFont (
                    'Nunito',color: Colors.black),
                onConfirmBtnTap:
                    () async {
                  FirebaseFirestore.instance.collection("Houses").doc(DocumentID).delete();
                  //   snackbar
                  final snackBar = SnackBar(content: AwesomeSnackbarContent(title: 'Sucess!', message: 'Houses: ${DataName} has been Deleted Sucessfully...', contentType: ContentType.success,),);
                  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

                });
          }
        },
        value: item,
        child: Container(
          height: height / 18.475,
          decoration: BoxDecoration(
              color: item == "Edit"
                  ? const Color(0xff5B93FF).withOpacity(0.6)
                  : const Color(0xffE71D36).withOpacity(0.6),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              item == "Edit"
                  ? const Icon(
                Icons.edit,
                color: Colors.white,
                size: 18,
              )
                  : const Icon(
                Icons.delete,
                color: Colors.white,
                size: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ))
          .toList(),
    );
  }
}
