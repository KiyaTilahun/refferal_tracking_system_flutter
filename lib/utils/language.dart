 // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element

 import 'package:PRTS/main.dart';
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
         DropdownMenuItem(
          value: 'es',
          child: Row(
            children: [
              Icon(Icons.language),
              SizedBox(width: 8),
              Text('Afaan Oromo'),
            ],
          ),
        ),
        // Add more DropdownMenuItems for additional languages
      ],
      onChanged: (String? value) async{
        if (value != null) {
          final locale = Locale(value);
             MyApp.setLocale(context, locale); 
            // Navigator.of(context).pop();
        }
      },
    );
  }}