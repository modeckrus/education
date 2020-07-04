import 'package:education/l10n/messages_all.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title {
    return Intl.message(
      'My Application',
      name: 'title',
      desc: 'Title for the Weather Application',
    );
  }

  String get button {
    return Intl.message(
      'Get the Weather',
      name: 'button',
      desc: 'get weather button',
    );
  }

  String get homescreen {
    return Intl.message('HomeScreen',
        name: 'homescreen', desc: 'HomeScreen text');
  }

  String get singin {
    return Intl.message('Sing In', name: 'singin');
  }

  String get passwordnotsame {
    return Intl.message('Password not same', name: 'passwordnotsame');
  }

  String get invalidpassword {
    return Intl.message('Invalid Password', name: 'invalidpassword');
  }

  String get invalidemail {
    return Intl.message('Invalid Email', name: 'invalidemail');
  }

  String get registre {
    return Intl.message('Registre', name: 'registre');
  }

  String get createanaccount {
    return Intl.message('Create an account', name: 'createanaccount');
  }

  String get password {
    return Intl.message('Password', name: 'password');
  }

  String get email {
    return Intl.message('Email', name: 'email');
  }

  String get login {
    return Intl.message('Login', name: 'login');
  }

  String get settingthedate {
    return Intl.message('We setting ur data', name: 'settingthedate');
  }

  String get failure {
    return Intl.message('Failure', name: 'failure');
  }

  String get loading {
    return Intl.message('Loading', name: 'loading');
  }

  String get succes {
    return Intl.message('Succes', name: 'succes');
  }

  String get invalidnick {
    return Intl.message('Invalid Nick', name: 'invalidnick');
  }

  String get nick {
    return Intl.message('Nick', name: 'nick');
  }

  String get invalidsurname {
    return Intl.message('Invalid Surname', name: 'invalidsurname');
  }

  String get surname {
    return Intl.message('Surname', name: 'surname');
  }

  String get name {
    return Intl.message('Name', name: 'name');
  }

  String get invalidname {
    return Intl.message('Invalid Name', name: 'invalidname');
  }

  String get urnameandnick {
    return Intl.message('Your name and Nick', name: 'urnameandnick');
  }

  String get singup {
    return Intl.message('Sing Up', name: 'singup');
  }

  String get singinwithgoogle {
    return Intl.message('Sing In with Google', name: 'singinwithgoogle');
  }

  String get error {
    return Intl.message('Error', name: 'error');
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}
