 // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element

 import 'package:final_year/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Language{

  Widget buildLanguageDropdown(BuildContext context) {
    return DropdownButton<String>(
      // onChanged: (String value) {

      // },
       hint: Text(AppLocalizations.of(context)!.changeLanguage),
      icon: Icon(Icons.language),
      items: [
        DropdownMenuItem(
          value: 'en',
          child: Row(
            children: [
              Icon(Icons.language),
              SizedBox(width: 8),
              Text('English'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: 'am',
          child: Row(
            children: [
              Icon(Icons.language),
              SizedBox(width: 8),
              Text('አማርኛ'),
            ],
          ),
        ),
        // Add more DropdownMenuItems for additional languages
      ],
      onChanged: (String? value) {
        if (value != null) {
          final locale = Locale(value);
            MyApp.setLocale(context, locale); 
        }
      },
    );
  }}