library papai_flutter_auto_complete;

import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class PapaiAutoComplete extends StatelessWidget {
  const PapaiAutoComplete(
      {super.key,
      required this.stringList,
      required this.onChange,
      this.initString,
      required this.enabled,
      required this.label,
      this.textStyle});

  final List<String> stringList;
  final Function(String) onChange;
  final String? initString;
  final bool enabled;
  final TextStyle? textStyle;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Autocomplete<String>(
        initialValue: TextEditingValue(text: initString ?? ''),
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return extractAllSorted(
            cutoff: 70,
            query: textEditingValue.text.toLowerCase(),
            choices: stringList,
          ).map((stringName) => stringName.choice);
        },
        // displayStringForOption: (option) => option,
        onSelected: (String selection) {
          debugPrint('You just selected $selection');
          onChange(selection);
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            enabled: enabled,
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            style: textStyle ?? _kTextStyleBodyMedium,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(label),
            ),
            onChanged: onChange,
            onFieldSubmitted: (_) => onFieldSubmitted(),
          );
        },
        //TODO: Improve style of suggestion texts
        // optionsViewBuilder: (BuildContext context,
        //     AutocompleteOnSelected<String> onSelected,
        //     Iterable<String> options) {
        //   return Align(
        //     alignment: Alignment.topLeft,
        //     child: Material(
        //       elevation: 4.0,
        //       child: SizedBox(
        //         height: 200,
        //         child: ListView.builder(
        //           padding: const EdgeInsets.all(10.0),
        //           itemCount: options.length,
        //           itemBuilder: (BuildContext context, int index) {
        //             final option = options.toList()[index];
        //             return GestureDetector(
        //               onTap: () {
        //                 print(options.toString());
        //                 onSelected(option);
        //               },
        //               child: ListTile(
        //                 title: Text(
        //                   option,
        //                   style: kTextStyleBodyMedium,
        //                 ),
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //     ),
        //   );
        // },
      ),
    );
  }
}

const _kTextStyleBodyMedium = TextStyle(
  color: Colors.black,
  fontSize: 15,
);
