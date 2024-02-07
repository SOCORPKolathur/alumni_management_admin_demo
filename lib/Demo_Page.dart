import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';




// class MyHomePage extends StatefulWidget {
//
//
//
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//    late MapShapeSource _shapeSource;
//    late List<MapModel> _mapData;
//
//   @override
//   void initState() {
//     _mapData = _getMapData();
//     _shapeSource = MapShapeSource.asset('assets/australia.json',
//         shapeDataField: 'STATE_NAME',
//         dataCount: _mapData.length,
//         primaryValueMapper: (int index) => _mapData[index].state,
//         dataLabelMapper: (int index) => _mapData[index].stateCode,
//         shapeColorValueMapper: (int index) => _mapData[index].color);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return SfMaps(
//       layers: <MapShapeLayer>[
//         MapShapeLayer(
//           source: _shapeSource,
//           showDataLabels: true,
//          // legend: MapLegend(MapElement.shape),
//           shapeTooltipBuilder: (BuildContext context, int index) {
//             return Padding(
//                 padding: EdgeInsets.all(7),
//                 child: Text(_mapData[index].stateCode,
//                     style: TextStyle(color: Colors.white)));
//           },
//           tooltipSettings: MapTooltipSettings(color: Colors.blue[900]),
//         )
//       ],
//     );
//   }
//
// static List<MapModel> _getMapData() {
//   return <MapModel>[
//     MapModel('Australian Capital Territory', 'ACT', Colors.amber),
//     MapModel('New South Wales', '       New\nSouth Wales', Colors.cyan),
//     MapModel('Queensland', 'Queensland', Colors.amber[400]!),
//     MapModel('Northern Territory', 'Northern\nTerritory', Colors.red[400]!),
//     MapModel('Victoria', 'Victoria', Colors.purple[400]!),
//     MapModel('South Australia', 'South Australia', Colors.lightGreenAccent[200]!),
//     MapModel('Western Australia', 'Western Australia', Colors.indigo[400]!),
//     MapModel('Tasmania', 'Tasmania', Colors.lightBlue[100]!)
//   ];
// }
// }
//
// class MapModel {
//   MapModel(this.state, this.stateCode, this.color);
//
//   String state;
//   String stateCode;
//   Color color;
// }


class Maopppp extends StatefulWidget {
  const Maopppp({super.key});

  @override
  State<Maopppp> createState() => _MaoppppState();
}

class _MaoppppState extends State<Maopppp> {
  @override
  Widget build(BuildContext context) {
    return SimpleMap(
      // String of instructions to draw the map.
      instructions: SMapIndia.instructions,

      // Default color for all countries.

      countryBorder: CountryBorder(color: Colors.black,width: 1),

      // Matching class to specify custom colors for each area.
      colors: SMapIndiaColors(
        inAN: Colors.green,
        inAP: Colors.pink,
        inAR: Colors.red,
        inAS:Colors.orange ,
        inBR: Colors.indigo,
        inHR: Colors.yellow,
        inCH: Colors.redAccent,
        inKA: Colors.pinkAccent,
        inGJ: Colors.grey,
        inTN: Colors.yellowAccent,
        inCT: Colors.amber,
        inDD: Colors.lightBlue,
        inDL: Colors.teal

      ).toMap(),


      // Details of what area is being touched, giving you the ID, name and tapdetails
      callback: (id, name, tapdetails) {
        print(id);
      },
    );
  }
}
