
import 'package:alumni_management_admin/common_widgets/developer_card_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import '../Constant_.dart';
import '../Models/Language_Model.dart';
import '../Models/Response_Model.dart';
import '../utils.dart';
class Email_Screen extends StatefulWidget {
  const Email_Screen({super.key});

  @override
  State<Email_Screen> createState() => _Email_ScreenState();
}

class _Email_ScreenState extends State<Email_Screen> {
  TextfieldTagsController controller = TextfieldTagsController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController departmentcon = TextEditingController(text:'Select Department');
  TextEditingController yearcon = TextEditingController(text:'Select Year');
  static List<String> _pickLanguage = <String>[];
  String currentTab = 'ADD';
  String Uservalue="All";
  bool MessageValidationBoolean=false;
  List<bool> Selected = List.generate(100, (index) => false);
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<String> notifylist=[
    "All",
    "Batch",
    "Department",
    "Department/Batch",
    "Gender"
  ];
  List dropDownApplyedvalue=[];
  List StreamData=[];
  List sendList=[];
  List <String> departmentDataList=[];
  List <String> yearDataList=[];
  bool isUsers = true;

  ///Department Fetch Function
  dropDowndataFetchFunc()async{
    setState(() {
      departmentDataList.clear();
      yearDataList.clear();
    });
    setState(() {
      departmentDataList.add('Select Department');
      yearDataList.add('Select Year');
    });
    var departmentdata=await cf.FirebaseFirestore.instance.collection("Department").orderBy("name").get();
    var acadamicYeardata=await cf.FirebaseFirestore.instance.collection("AcademicYear").orderBy("name").get();
    for(int x=0;x<departmentdata.docs.length;x++){
      setState((){
        departmentDataList.add(departmentdata.docs[x]['name'].toString());
      });
    }
    for(int y=0;y<acadamicYeardata.docs.length;y++){
      setState((){
        yearDataList.add(acadamicYeardata.docs[y]['name'].toString());
      });
    }
    print("department Data List $departmentDataList");
    print("Year Data List $yearDataList");
  }

  @override
  void initState() {

    dropDowndataFetchFunc();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height/81.375, horizontal: width/170.75),
      child: SingleChildScrollView(
        child: FadeInRight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height/81.375, horizontal: width/170.75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top:height/81.375),
                      child: KText(
                        text: "EMAIL COMMUNICATION",
                        style: SafeGoogleFont (
                            'Nunito',
                          fontSize: width / 82.538,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff030229),),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left:width/1.39),
                    child: InkWell(
                        onTap:(){
                          if(currentTab.toUpperCase() == "VIEW") {
                            setState(() {
                              currentTab = "Add";
                            });
                          }else{
                            setState(() {
                              currentTab = 'View';
                            });
                          }

                        },
                        child: Container(
                          height:height/18.6,
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
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal:width/227.66),
                            child: Center(
                              child: KText(
                                text: currentTab.toUpperCase() == "VIEW" ? "Send Email" : "View Emails",
                                style: SafeGoogleFont (
                                  'Nunito',
                                  fontSize:width/105.07,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                ],
              ),
              currentTab.toUpperCase() == "ADD"
                  ? Container(
                height: size.height * 1.2,
                width: width/1.28,
                margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(1, 2),
                      blurRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width/68.3, vertical: height/81.375),
                        child: Row(
                          children: [
                            const Icon(Icons.message),
                            SizedBox(width: width/136.6),
                            KText(
                              text: "EMAIL",
                              style: SafeGoogleFont (
                                'Nunito',
                                fontSize: width/68.3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 54.64),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: height / 13.02,
                                width: width / 2.464,

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text("Please Select : ",style:  SafeGoogleFont (
                                      'Poppins',
                                    )),

                                    Container(
                                      height: height / 13.02,
                                      width: width / 6.464,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey.shade300
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField2<String>(

                                          hint: KText(
                                              text:'Select',
                                              style:  SafeGoogleFont (
                                                'Poppins',
                                              )
                                          ),
                                          items: notifylist.map((String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: KText(
                                                text: item,
                                                style:  SafeGoogleFont (
                                                  'Poppins',
                                                )
                                            ),
                                          ))
                                              .toList(),
                                          value: Uservalue,
                                          onChanged: (String? value) {
                                            setState(() {
                                              Uservalue = value!;
                                            });
                                            dropdownSelectStreamData();
                                          },
                                          buttonStyleData:  const ButtonStyleData(
                                          ),decoration: const InputDecoration(
                                            border: InputBorder.none
                                        ),

                                        ),
                                      ),
                                    ),


                                    Padding(
                                      padding:  EdgeInsets.only(left:width/27.32),
                                      child: InkWell(
                                        onTap: () async {
                                          print("Apply Button-------------------------------------------------------");
                                          getStreamDatafunction();
                                        },
                                        child: Container(
                                          height: height / 16.6,
                                          decoration: BoxDecoration(
                                            color: Constants().primaryAppColor,
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black26,
                                                offset: Offset(1, 2),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width /60.6),
                                            child: Center(
                                              child: KText(
                                                text: "Apply",
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  color: Colors.white,
                                                  fontSize: width / 106.6,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                height:height/5.0,
                                width: width/1.536,
                                color: Colors.white,
                                child: SingleChildScrollView(
                                  physics: const ScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height/92.375,
                                              horizontal: width/192
                                          ),
                                          child:
                                          Uservalue == "Department/Batch"?Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: "Department",
                                                    style: SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize: width / 105.571,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: height / 108.5),
                                                  Material(
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Color(0xffDDDEEE),
                                                    elevation: 5,
                                                    child:
                                                    SizedBox(
                                                      height: height / 16.02,
                                                      width: width / 7.0,
                                                      child: DropdownButtonHideUnderline(
                                                        child:
                                                        DropdownButtonFormField2<
                                                            String>(
                                                          isExpanded:true,
                                                          hint: Text(
                                                            'Select Department',
                                                            style:
                                                            SafeGoogleFont(
                                                              'Nunito',
                                                            ),
                                                          ),
                                                          items: departmentDataList
                                                              .map((String
                                                          item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style:
                                                                  SafeGoogleFont(
                                                                    'Nunito',
                                                                  ),
                                                                ),
                                                              )).toList(),
                                                          value:
                                                          departmentcon.text,
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              departmentcon.text =
                                                              value!;
                                                            });

                                                          },
                                                          buttonStyleData:
                                                          const ButtonStyleData(


                                                          ),
                                                          menuItemStyleData:
                                                          const MenuItemStyleData(

                                                          ),
                                                          decoration:
                                                          const InputDecoration(
                                                              border:
                                                              InputBorder
                                                                  .none),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: width / 68.3),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: "Year",
                                                    style: SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize: width / 105.571,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: height / 108.5),
                                                  Material(
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Color(0xffDDDEEE),
                                                    elevation: 5,
                                                    child: SizedBox(
                                                      height: height / 16.02,
                                                      width: width / 7.0,
                                                      child: DropdownButtonHideUnderline(
                                                        child:
                                                        DropdownButtonFormField2<
                                                            String>(
                                                          isExpanded:true,
                                                          hint: Text(
                                                            'Select Year',
                                                            style:
                                                            SafeGoogleFont(
                                                              'Nunito',
                                                            ),
                                                          ),
                                                          items: yearDataList
                                                              .map((String
                                                          item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style:
                                                                  SafeGoogleFont(
                                                                    'Nunito',
                                                                  ),
                                                                ),
                                                              )).toList(),
                                                          value:
                                                          yearcon.text,
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              yearcon.text =
                                                              value!;
                                                            });

                                                          },
                                                          buttonStyleData:
                                                          const ButtonStyleData(


                                                          ),
                                                          menuItemStyleData:
                                                          const MenuItemStyleData(

                                                          ),
                                                          decoration:
                                                          const InputDecoration(
                                                              border:
                                                              InputBorder
                                                                  .none),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ):
                                          Uservalue=="All"?
                                          Row(
                                            children: [

                                              Checkbox(
                                                value: isUsers,
                                                onChanged: (val) {
                                                  setState(() {
                                                    isUsers = val!;
                                                  });
                                                  print("Users Alll000000000000000000000000000000000000000000000000");
                                                  print(isUsers);
                                                },
                                              ),
                                              SizedBox(width: width / 136.6),
                                              const Text("Users")
                                            ],
                                          ):
                                          SizedBox(
                                            child: GridView.builder(
                                              itemCount: StreamData.length,
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 5,
                                                childAspectRatio: 110/50,
                                              ),
                                              itemBuilder: (context, index) {
                                                return SizedBox(
                                                  height:height/18.475,
                                                  width:width/10.24,
                                                  child: Row(
                                                    children: [

                                                      Checkbox(
                                                        value: Selected[index],
                                                        onChanged: (val) {
                                                          setState(() {
                                                            Selected[index] = !Selected[index];
                                                          });
                                                          if(Selected[index]==true){
                                                            setState(() {
                                                              dropDownApplyedvalue.add(StreamData[index]);
                                                            });
                                                            print("if Funcion------------------------------------");
                                                            print(StreamData[index]);
                                                            print(Selected[index]);
                                                            print(dropDownApplyedvalue);
                                                          }
                                                          else{
                                                            setState(() {
                                                              dropDownApplyedvalue.remove(StreamData[index]);
                                                            });
                                                            print("Else Funcion------------------------------------");
                                                            print(StreamData[index]);
                                                            print(Selected[index]);
                                                            print(dropDownApplyedvalue);
                                                          }
                                                        },
                                                      ),
                                                      SizedBox(width: width / 136.6),
                                                      SizedBox(
                                                        width:width/12.8,
                                                        child: Text(StreamData[index],style: TextStyle(
                                                            overflow: TextOverflow.ellipsis
                                                        ),),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        padding: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                        child: Form(
                          key:_formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text:
                                      "Single/Multiple Email (Separate By Comma) *",
                                      style:SafeGoogleFont (
                                        'Nunito',
                                        color: Colors.black,
                                        fontSize: width/105.076,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height:height/73.9),
                                    Container(
                                      decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                          borderRadius: BorderRadius.circular(3)),
                                      child: Autocomplete<String>(
                                        optionsViewBuilder: (context, onSelected, options) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:width/136.6, vertical: height/162.75),
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: Material(
                                                elevation: 4.0,
                                                child: ConstrainedBox(
                                                  constraints:  const BoxConstraints(maxHeight: 20),
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: options.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      final dynamic option = options.elementAt(index);
                                                      return TextButton(
                                                        onPressed: () {
                                                          onSelected(option);
                                                        },
                                                        child: Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(
                                                                vertical: height/43.4),
                                                            child: Text(
                                                              '#$option',
                                                              textAlign: TextAlign.left,
                                                              style: const TextStyle(
                                                                color: Color.fromARGB(255, 74, 137, 92),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        optionsBuilder: (TextEditingValue textEditingValue) {
                                          if (textEditingValue.text == '') {
                                            return const Iterable<String>.empty();
                                          }
                                          return _pickLanguage.where((String option) {
                                            return option.contains(textEditingValue.text.toLowerCase());
                                          });
                                        },
                                        onSelected: (String selectedTag) {
                                          controller.addTag = selectedTag;
                                        },
                                        fieldViewBuilder: (context, ttec, tfn, onFieldSubmitted) {
                                          return TextFieldTags(
                                            textEditingController: ttec,
                                            focusNode: tfn,
                                            textfieldTagsController: controller,
                                            initialTags: const [],
                                            textSeparators: const [' ', ','],
                                            letterCase: LetterCase.normal,
                                            validator: (String tag) {
                                              if (tag == 'php') {
                                                return 'No, please just no';
                                              } else if (controller.getTags!.contains(tag)) {
                                                return 'you already entered that';
                                              }
                                              return null;
                                            },
                                            inputfieldBuilder:
                                                (context, tec, fn, error, onChanged, onSubmitted) {
                                              return ((context, sc, tags, onTagDelete) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(horizontal:width/136.6),
                                                  child: TextField(
                                                    controller: tec,
                                                    focusNode: fn,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,

                                                      helperStyle: TextStyle(
                                                        color: Constants().primaryAppColor,
                                                      ),
                                                      errorText: error,
                                                      prefixIconConstraints: BoxConstraints(
                                                          maxWidth: size.width * 0.74),
                                                      prefixIcon: tags.isNotEmpty
                                                          ? SingleChildScrollView(
                                                        controller: sc,
                                                        scrollDirection: Axis.horizontal,
                                                        child: Row(
                                                            children: tags.map((String tag) {
                                                              return Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: const BorderRadius.all(
                                                                    Radius.circular(20.0),
                                                                  ),
                                                                  color: Constants().primaryAppColor,
                                                                ),
                                                                margin:
                                                                EdgeInsets.only(right: width/136.6),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal: width/136.6, vertical: height/162.75),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    InkWell(
                                                                      child: Text(
                                                                        tag,
                                                                        style: const TextStyle(
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: width/341.5),
                                                                    InkWell(
                                                                      child: Icon(
                                                                          Icons.cancel,
                                                                          size:width/97.571,
                                                                          color: Colors.black
                                                                      ),
                                                                      onTap: () {
                                                                        onTagDelete(tag);
                                                                      },
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList()),
                                                      )
                                                          : null,
                                                    ),
                                                    onChanged: onChanged,
                                                    onSubmitted: onSubmitted,
                                                  ),
                                                );
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: height /21.7),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: "Subject *",
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        color: Colors.black,
                                        fontSize: width/105.076,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height:height/73.9),
                                    Container(
                                      decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                          borderRadius: BorderRadius.circular(3)),
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(
                                            horizontal: width/192,
                                            vertical: height/92.375
                                        ),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: InputBorder.none
                                          ),
                                          style: TextStyle(fontSize: width /113.83),
                                          controller: subjectController,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: height /21.7),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: "Message *",
                                    style: SafeGoogleFont (
                                      'Nunito',
                                      color: Colors.black,
                                      fontSize: width/105.076,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height:height/73.9),
                                  Container(
                                    height:size.height*0.15,
                                      width: double.infinity,
                                      decoration: BoxDecoration(color: const Color(0xffDDDEEE),
                                          borderRadius: BorderRadius.circular(3)),
                                      child: TextFormField(
                                        style: TextStyle(fontSize: width /113.83),
                                        controller: descriptionController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: width/91.06,
                                                top: height/162.75,
                                                bottom: height/162.75)),
                                        maxLines: null,
                                        validator: (value) {
                                          if(value!.isEmpty){
                                            setState(() {
                                              MessageValidationBoolean=true;
                                            });
                                          }
                                          else{
                                            setState(() {
                                              MessageValidationBoolean=false;
                                            });
                                          }
                                          return null;
                                        },
                                        onChanged:(value){
                                          if(value.isEmpty){
                                            setState(() {
                                              MessageValidationBoolean=true;
                                            });
                                          }
                                          else{
                                            setState(() {
                                              MessageValidationBoolean=false;
                                            });
                                          }


                                        },
                                      )),
                                  descriptionController.text==""&& MessageValidationBoolean? KText(
                                    text: "Field is Required",
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      color: Colors.red,
                                      fontSize: width / 136.6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ):const SizedBox(),

                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top:height/13.9),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if(descriptionController.text==""){
                                          setState(() {
                                            MessageValidationBoolean=true;
                                          });
                                        }
                                        if(_formkey.currentState!.validate()){
                                          if(descriptionController.text==""){
                                            setState(() {
                                              MessageValidationBoolean=true;
                                            });
                                          }
                                         if(MessageValidationBoolean==false){
                                           List<String>? tagss = await controller.getTags;
                                           if(tagss!.isNotEmpty) {
                                             Response response = await sendEmail(
                                                 tagss, subjectController.text,
                                                 descriptionController.text);
                                             if (response.code == 200) {
                                               CoolAlert.show(
                                                   context: context,
                                                   type: CoolAlertType.success,
                                                   text: "Mail Sended successfully!",
                                                   width: size.width * 0.4,
                                                   backgroundColor: Constants()
                                                       .primaryAppColor
                                                       .withOpacity(0.8));
                                               setState(() {
                                                 controller.clearTags();
                                                 subjectController.text = "";
                                                 descriptionController.text = "";
                                                 currentTab = 'ADD';
                                               });
                                             }
                                             else {
                                               CoolAlert.show(
                                                   context: context,
                                                   type: CoolAlertType.error,
                                                   text: "Failed to Send",
                                                   width: size.width * 0.4,
                                                   backgroundColor: Constants()
                                                       .primaryAppColor
                                                       .withOpacity(0.8));
                                               setState(() {
                                                 controller.clearTags();
                                                 subjectController.text = "";
                                                 descriptionController.text = "";
                                               });
                                             }
                                           }
                                           else{
                                             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                           }
                                         }
                                          else{
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          }
                                        }
                                        else{
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.send,
                                                    color: Colors.white),
                                                SizedBox(width: width /273.2),
                                                KText(
                                                  text: "SEND",
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    color: Colors.white,
                                                    fontSize: width /136.6,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                                  ),
                                )
                  : currentTab.toUpperCase() == "VIEW" ?
              SizedBox(  height: size.height * 0.85,
                                  width: width/1.28,)
                  : Container(),
              SizedBox(height: height / 65.1),
              DeveloperCardWidget(),
              SizedBox(height: height / 65.1),
            ],
          ),
        ),
      ),
    );

  }

  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Constants().primaryAppColor, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Constants().primaryAppColor),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Please fill required fields !!',
                  style: TextStyle(color: Colors.black)),
            ),
            const Spacer(),
            TextButton(
                onPressed: () => debugPrint("Undid"), child: const Text("Undo"))
          ],
        )),
  );
  dropdownSelectStreamData() async {
    setState(() {
      StreamData.clear();
      sendList.clear();
    });
    if(Uservalue=="All"){
      setState(() {
        isUsers=true;
      });
    }
    else if(Uservalue=="Batch"){
      var Data=await FirebaseFirestore.instance.collection("AcademicYear").orderBy("timestamp").get();
      for(int i=0;i<Data.docs.length;i++){
        setState(() {
          StreamData.add(Data.docs[i]['name']);
        });
      }
    }
    else if(Uservalue=="Department"){
      var Data=await FirebaseFirestore.instance.collection("Department").orderBy("timestamp").get();
      for(int i=0;i<Data.docs.length;i++){
        setState(() {
          StreamData.add(Data.docs[i]['name']);
        });
      }
    }
    else if(Uservalue=="Gender"){
      setState(() {
        StreamData.add("Male");
        StreamData.add("Female");
      });
    }

  }

  Future<Response> sendEmail(receiverMail, String subject, String description) async {
    Response response = Response();
    DocumentReference documentReferencer = FirebaseFirestore.instance.collection('mail').doc();
    var json = {
      "to": receiverMail,
      "message": {
        "subject": subject,
        "text": description,
      },
    };
    var result = await documentReferencer.set(json).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }


  /// Apply button function
  getStreamDatafunction()async{
    setState(() {
      sendList.clear();
    });

    print("Submitted data Entered--------------------------------------------");
    print(Uservalue);
    if(Uservalue=="All"){
      print("Alllllllllllllll Enteredddddddddddddddddddddddddddddddddddddddd");
      var UserData=await FirebaseFirestore.instance.collection("Users").get();
      for(int x=0;x<UserData.docs.length;x++){

        setState(() {
          sendList.add(UserData.docs[x]['Token']);
        });
        print(sendList);
        print("Sned List___________________________________________________");
      }
    }
    else if(Uservalue=="Batch"){
      print("Batch Entered--------------------------------------------");
      print(dropDownApplyedvalue);
      var UserData=await FirebaseFirestore.instance.collection("Users").get();
      for(int x=0;x<UserData.docs.length;x++){
        if(dropDownApplyedvalue.contains(UserData.docs[x]['yearofpassed'])){
          print(dropDownApplyedvalue);
          setState(() {
            sendList.add(UserData.docs[x]['Token']);
          });
          print(sendList);
          print("Sned List___________________________________________________");
        }

      }
    }
    else if(Uservalue=="Department"){
      print("Department Entered--------------------------------------------");
      print(dropDownApplyedvalue);
      var UserData=await FirebaseFirestore.instance.collection("Users").get();
      for(int x=0;x<UserData.docs.length;x++){
        if(dropDownApplyedvalue.contains(UserData.docs[x]['subjectStream'])){
          print(dropDownApplyedvalue);
          setState(() {
            sendList.add(UserData.docs[x]['Token']);
          });
          print(sendList);
          print("Sned List___________________________________________________");
        }
      }
    }

    else if(Uservalue=="Gender"){

      print("Gender Entered--------------------------------------------");
      print(dropDownApplyedvalue);
      var UserData=await FirebaseFirestore.instance.collection("Users").get();
      for(int x=0;x<UserData.docs.length;x++){
        if(dropDownApplyedvalue.contains(UserData.docs[x]['Gender'])){
          print(dropDownApplyedvalue);
          setState(() {
            sendList.add(UserData.docs[x]['Token']);
          });
          print(sendList);
          print("Sned List___________________________________________________");
        }
      }

    }
  }
}
