import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/bloc/authentication_bloc.dart';
import '../localization/localizations.dart';
import '../user_repository.dart';
import '../validators.dart';
import 'bloc/settinguser_bloc.dart';
import 'setting_user_button.dart';

class SettingUserPage extends StatefulWidget {
  final UserRepository userRepository;
  SettingUserPage(
      {Key key,
      @required this.userRepository,
      @required this.authenticationBloc})
      : super(key: key);
  final AuthenticationBloc authenticationBloc;
  @override
  _SettingUserPageState createState() => _SettingUserPageState(userRepository);
}

class _SettingUserPageState extends State<SettingUserPage> {
  final UserRepository userRepository;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nickController = TextEditingController();
  String image;
  SettinguserBloc settinguserBloc;
  SettinguserBloc get _settinguserBloc => settinguserBloc;

  _SettingUserPageState(this.userRepository);
  @override
  void initState() {
    loadUserData();
    settinguserBloc =
        SettinguserBloc(widget.userRepository, widget.authenticationBloc);
    super.initState();
    _nameController.addListener(_onNameChanged);
    _surnameController.addListener(_onSurNameChanged);
    _nickController.addListener(_onNickChanged);
    // addAvatarWidget = AddAvatarWidget(
    //   userRepository: userRepository,
    //   image: image,
    // );
  }

  // AddAvatarWidget addAvatarWidget;
  @override
  void dispose() {
    _settinguserBloc.close();
    super.dispose();
  }

  void loadUserData() async {
    final user = await userRepository.getUser();
    final doc =
        await Firestore.instance.collection('user').document(user.uid).get();
    _nameController.text = doc.data['Name'];
    _surnameController.text = doc.data['Surname'];
    _nickController.text = doc.data['Nick'];
    image = doc.data['Avatar'];
    // addAvatarWidget.setImage(image);
  }

  bool isNameValid = true;
  bool isSurNameValid = true;
  bool isNickNameValid = true;
  bool isOk = false;
  bool isEnabled = true;
  String get _name => _nameController.text;
  String get _surname => _surnameController.text;
  String get _nick => _nickController.text;

  // String get _avatar => addAvatarWidget.image;
  void _onNameChanged() {
    checkIsOk();
  }

  void _onSurNameChanged() {
    checkIsOk();
  }

  void _onNickChanged() {
    checkIsOk();
  }

  void checkIsOk() {
    isNameValid = _name != null && _name != '';
    isSurNameValid = _surname != null && _name != '';
    isNickNameValid =
        _nick != null && Validators.isValidNick(_nick) && _nick != "";
    isOk = isNameValid && isSurNameValid && isNickNameValid;
    if (isOk && isEnabled) {
      _settinguserBloc.add(NextButtonOkE());
    } else if (!isOk && isEnabled) {
      _settinguserBloc.add(NextButtonFailE());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _settinguserBloc,
      child: BlocListener(
        bloc: _settinguserBloc,
        listener: (context, state) {
          if (state is NextButtonLoadingS) {}
          if (state is NextButtonOkS) {
            isEnabled = true;
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      AppLocalizations.of(context).urnameandnick,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // addAvatarWidget,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 15,
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).name,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            autovalidate: true,
                            autocorrect: false,
                            enabled: isEnabled,
                            validator: (_) {
                              return !isNameValid
                                  ? AppLocalizations.of(context).invalidname
                                  : null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 15,
                          child: TextFormField(
                            controller: _surnameController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).surname,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            autovalidate: true,
                            autocorrect: false,
                            enabled: isEnabled,
                            validator: (_) {
                              return !isSurNameValid
                                  ? AppLocalizations.of(context).invalidsurname
                                  : null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: TextFormField(
                        controller: _nickController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).nick,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        autovalidate: true,
                        autocorrect: false,
                        enabled: isEnabled,
                        validator: (_) {
                          return !isNickNameValid
                              ? AppLocalizations.of(context).invalidnick
                              : null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: fab(),
        ),
      ),
    );
  }

  Widget fab() {
    return SettingUserButton(
      duration: Duration(milliseconds: 250),
      onTap: () async {
        setState(() {
          // _settinguserBloc.add(NextButtonPressedE(
          //     name: _name, surname: _surname, nick: _nick, avatar: _avatar));
          _settinguserBloc.add(NextButtonPressedE(
              name: _name,
              surname: _surname,
              nick: _nick,
              avatar: 'test/avatar.jpeg'));
          isEnabled = false;
          //_settinguserBloc.add(NextButtonPressedE(name: _name, surname: _surname, nick: _nick, avatar: _avatar));
        });
      },
    );
  }
}

// class AddAvatarWidget extends StatefulWidget {
//   AddAvatarWidget({Key key, @required this.userRepository, @required this.image}) : super(key: key);
//   final UserRepository userRepository;
//   _AddAvatarWidgetState state = _AddAvatarWidgetState();
//   String image;
//   void setImage(image){
//     state.setImage(image);
//   }
//   @override
//   _AddAvatarWidgetState createState() => state;
// }

// class _AddAvatarWidgetState extends State<AddAvatarWidget> {
//   void setImage(imagen){
//     setState(() {
//       image = imagen;
//     });
//   }
//   void getImage(context) async {
//     List<MSize> sizes = List();
//     sizes.add(MSize(
//       height: 100,
//       width: 100,
//     ));
//     sizes.add(MSize(width: 20, height: 20));
//     print(sizes);
//     final user = await widget.userRepository.getUser();
//     final result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ImageCapture(
//             path: 'avatar',
//             uid: user.uid,
//           ),
//         ));
//     setState(() {
//       image = result;
//       widget.image = result;
//     });
//   }

//   String image;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         getImage(context);
//       },
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(75)),
//         child: Container(
//           color: Colors.black38,
//           child: SizedBox(
//             height: 150,
//             width: 150,
//             child: image == null
//                 ? Icon(Icons.add)
//                 : MyImage(
//                     path: image,
//                     size: MSize(width: 200, height: 200),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
