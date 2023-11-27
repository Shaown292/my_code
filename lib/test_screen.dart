// import 'package:flutter/material.dart';
//
// class DropdownCustom extends StatelessWidget {
//   DropdownCustom({super.key,required this.gropValue,required this.gropList,required this.onChanges});
//   final dynamic gropValue;
//   final List<dynamic>gropList;
//   Function (dynamic)onChanges;
//
//   @override
//   Widget build(BuildContext context) {
//     return   DropdownButtonFormField<dynamic>(
//       icon: const Icon(Icons.keyboard_arrow_down_rounded),
//       iconSize: 40,
//       iconDisabledColor: Colors.blue,
//       iconEnabledColor: Colors.pink,
//       decoration: InputDecoration(
//         fillColor: Colors.yellow,
//         filled: true,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(40),
//           borderSide: const BorderSide(
//             color: Colors.black,
//             width: 2,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(40),
//           borderSide: const BorderSide(
//             color: Colors.red,
//             width: 3,
//           ),
//         ),
//       ),
//       hint: const Text('Select your favourite fruit'),
//       dropdownColor: Colors.greenAccent,
//       value: gropValue,
//       // onChanged: (dynamic? newValue) {
//       //   print(newValue.title);
//       //   onChanges();
//       // },
//       onChanged: (dynamic value){
//         onChanges(value);
//       },
//       items: gropList.isEmpty
//           ? null
//           : gropList.map<DropdownMenuItem<dynamic>>((dynamic value) {
//         return DropdownMenuItem<dynamic>(
//           value: value,
//           child: Text(
//             value.title.toString(),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }