import 'package:flutter/material.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/components/button/secondary_button.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/update_user.dart';
import 'package:speech_stroop/model/user.dart';
import 'package:speech_stroop/screens/auth/components/text_form_field.dart';
import 'package:speech_stroop/screens/profile/profile_screen.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm(this.updateUser, {Key key}) : super(key: key);
  final UpdateUser updateUser;
  @override
  ProfileFormState createState() => ProfileFormState();
}

class ProfileFormState extends State<ProfileForm> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formGlobalKey = GlobalKey<FormState>();
  bool loading = false;

  UpdateUser updateUser;

  bool profileFormEnabled;

  TextEditingController usernameController;
  TextEditingController nameController;
  TextEditingController surnameController;
  TextEditingController emailController;
  TextEditingController dobController;
  TextEditingController genderController;
  TextEditingController educationController;

  DateTime dob;
  String genderValue;
  String educationValue;

  @override
  void initState() {
    super.initState();
    updateUser = widget.updateUser;

    usernameController = TextEditingController(text: userProfile.username);
    nameController = TextEditingController(text: userProfile.name);
    surnameController = TextEditingController(text: userProfile.surname);
    emailController = TextEditingController(text: userProfile.email);
    dobController = TextEditingController(
        text: userProfile.dateOfBirth.toString().split(' ')[0]);
    dob = userProfile.dateOfBirth;
    genderController = TextEditingController(text: userProfile.gender);
    educationController = TextEditingController(text: userProfile.education);

    genderValue = userProfile.gender;
    educationValue = userProfile.education;

    print({
      "username": usernameController.text,
      "name": nameController.text,
      "surname": surnameController.text,
      "email": emailController.text,
      "dateOfBirth": dobController.text,
      "gender": genderValue,
      "education": educationValue,
    });

    profileFormEnabled = false;
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return secondaryColor;
    }
    return const Color(0xFF525252);
  }

  Widget getFormButton() {
    Widget button;
    profileFormEnabled
        ? button = SecondaryButton(
            "บันทึกข้อมูล", () => {showSimpleModalDialog(context)})
        : button = PrimaryButton(
            "แก้ไขข้อมูล",
            () => {
                  setState(() => {profileFormEnabled = true}),
                });
    return button;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
        child: Form(
            key: formGlobalKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: TextFormFieldCustom(
                    usernameController,
                    'ชื่อเล่น',
                    TextInputType.name,
                    (val) {
                      if (val.isEmpty) {
                        return 'โปรดระบุชื่อเล่น';
                      }
                      return null;
                    },
                    // TODO: create func validateOnChanged ?
                    (val) {
                      if (formGlobalKey.currentState.validate()) {
                        formGlobalKey.currentState.save();
                      }
                    },
                    profileFormEnabled, true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: TextFormFieldCustom(
                            nameController,
                            'ชื่อจริง',
                            TextInputType.name,
                            (val) {
                              if (val.isEmpty) {
                                return 'โปรดระบุชื่อจริง';
                              }
                              return null;
                            },
                            (val) {
                              if (formGlobalKey.currentState.validate()) {
                                formGlobalKey.currentState.save();
                              }
                            },
                            profileFormEnabled,
                            true,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormFieldCustom(
                          surnameController,
                          'นามสกุล',
                          TextInputType.name,
                          (val) {
                            if (val.isEmpty) {
                              return 'โปรดระบุนามสกุล';
                            }
                            return null;
                          },
                          (val) {
                            if (formGlobalKey.currentState.validate()) {
                              formGlobalKey.currentState.save();
                            }
                          },
                          profileFormEnabled,
                          true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: TextFormFieldCustom(
                    emailController,
                    'อีเมล',
                    TextInputType.emailAddress,
                    (val) {
                      bool isEmailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val);
                      if (val.isEmpty) {
                        return 'โปรดระบุอีเมล';
                      } else if (!isEmailValid) {
                        return 'โปรดระบุอีเมลให้ถูกต้อง';
                      }
                      return null;
                    },
                    (val) {
                      if (formGlobalKey.currentState.validate()) {
                        formGlobalKey.currentState.save();
                      }
                    },
                    profileFormEnabled,
                    true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: TextFormFieldCustom(
                            dobController,
                            'วันเกิด',
                            TextInputType.number,
                            (val) {
                              RegExp exp = RegExp(
                                  r"((19|20)\d\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])");
                              Iterable<RegExpMatch> matches =
                                  exp.allMatches(val);
                              if (val == '') {
                                return 'โปรดระบุวันเกิดของคุณ';
                              } else if (matches.isEmpty) {
                                return 'โปรดระบุวันเกิดของคุณให้ถูกต้อง';
                              }
                              //TODO: check if value is before today
                              return null;
                            },
                            (val) {
                              if (formGlobalKey.currentState.validate()) {
                                formGlobalKey.currentState.save();
                              }
                            },
                            profileFormEnabled,
                            true,
                            const Icon(Icons.calendar_today),
                            () {
                              DateTime today = DateTime.now();
                              DateTime firstDate = DateTime(1942);
                              DateTime lastDate = DateTime(
                                  today.year - 18, today.month, today.day);
                              showDatePicker(
                                      context: context,
                                      initialDate: lastDate,
                                      firstDate: firstDate,
                                      lastDate: lastDate)
                                  .then((date) => {
                                        setState(() => {
                                              dob = date,
                                              dob != null
                                                  ? dobController.text = dob
                                                      .toString()
                                                      .split(' ')[0]
                                                  : null
                                            })
                                      });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: profileFormEnabled
                            ? DropdownButtonFormField(
                                decoration: InputDecoration(
                                  label: const Text(
                                    'เพศ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: formBorder,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: formBorder,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: formBorder,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabled: profileFormEnabled,
                                ),
                                disabledHint: Text(genderValue,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w300,
                                    )),
                                value: genderValue,
                                onChanged: profileFormEnabled
                                    ? (val) {
                                        setState(() {
                                          genderValue = val;
                                        });
                                        if (formGlobalKey.currentState
                                            .validate()) {
                                          formGlobalKey.currentState.save();
                                          setState(() {
                                            genderValue = val;
                                          });
                                        }
                                      }
                                    : null,
                                items: genderList,
                                validator: (value) {
                                  if (value == null) {
                                    return 'โปรดระบุเพศของคุณ';
                                  }
                                  return null;
                                },
                              )
                            : TextFormFieldCustom(
                                genderController,
                                'เพศ',
                                TextInputType.text,
                                null,
                                null,
                                false,
                                true,
                              ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: profileFormEnabled
                      ? DropdownButtonFormField(
                          decoration: InputDecoration(
                            label: const Text(
                              'ระดับการศึกษาสูงสุด',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: formBorder,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: formBorder,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: formBorder,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabled: profileFormEnabled,
                          ),
                          disabledHint: Text(genderValue,
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w300,
                              )),
                          value: educationValue,
                          onChanged: profileFormEnabled
                              ? (val) {
                                  setState(() {
                                    educationValue = val;
                                  });
                                  if (formGlobalKey.currentState.validate()) {
                                    formGlobalKey.currentState.save();
                                    setState(() {
                                      educationValue = val;
                                    });
                                  }
                                }
                              : null,
                          items: educationList,
                          validator: (value) {
                            if (value == null) {
                              return 'โปรดระบุระดับการศึกษาสูงสุดของคุณ';
                            }
                            return null;
                          },
                        )
                      : TextFormFieldCustom(
                          educationController,
                          'ระดับการศึกษาสูงสุด',
                          TextInputType.text,
                          null,
                          null,
                          false,
                          true,
                        ),
                ),
                getFormButton()
              ],
            )),
      ),
    );
  }

  showSimpleModalDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 270),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () => Navigator.pushNamed(
                            context, ProfileScreen.routeName),
                        icon: const Icon(
                          Icons.close,
                          color: Color(0xFF37265F),
                        ),
                        iconSize: 30,
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: (const Text('ต้องการบันทึกหรือไม่',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xFF22005D),
                                      fontFamily: 'BaiJamjuree',
                                      wordSpacing: 1)))),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Column(
                              children: [
                                PrimaryButton(
                                  "บันทึก",
                                  () async => {
                                    updateUser = UpdateUser(
                                      tel: updateUser.tel,
                                      username: usernameController.text,
                                      name: nameController.text,
                                      surname: surnameController.text,
                                      email: emailController.text,
                                      dateOfBirth: dob,
                                      gender: genderValue,
                                      education: educationValue,
                                      precondition: updateUser.precondition,
                                    ),
                                    print({
                                      "tel": updateUser.tel,
                                      "username": updateUser.username,
                                      "name": updateUser.name,
                                      "surname": updateUser.surname,
                                      "email": updateUser.email,
                                      "dateOfBirth": updateUser.dateOfBirth,
                                      "gender": updateUser.gender,
                                      "education": updateUser.education,
                                      "precondition": updateUser.precondition,
                                    }),
                                    await updateUserProfile(updateUser),
                                    Navigator.pushNamed(
                                        context, ProfileScreen.routeName),
                                  },
                                ),
                                SecondaryButton(
                                    "ยกเลิก",
                                    () => Navigator.pushNamed(
                                        context, ProfileScreen.routeName))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
