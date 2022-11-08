import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/button/floating_button.dart';
import '../../components/custom_appbar.dart';
import '../../components/loading_screen.dart';
import '../../constants.dart';
import '../../model/precondition.dart';
import '../precondition_test/introduction.dart';
import 'components/text_form_field.dart';
import 'package:speech_stroop/model/experimental_token.dart';

PreconditionScore colorVisibilityTest = PreconditionScore(0, DateTime.now());
PreconditionScore readingAbilityTest = PreconditionScore(0, DateTime.now());
Precondition precondition =
    Precondition(true, colorVisibilityTest, readingAbilityTest, false);

class ExperimentalSetToken extends StatefulWidget {
  const ExperimentalSetToken({Key key}) : super(key: key);
  static String routeName = "/experimental_settoken";

  @override
  _ExperimentalSetTokenWidgetState createState() =>
      _ExperimentalSetTokenWidgetState();
}

class _ExperimentalSetTokenWidgetState extends State<ExperimentalSetToken> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController tokenController;
  bool loading = false;
  String experimenteeId;

  @override
  void initState() {
    tokenController = TextEditingController();
    super.initState();
  }

  void setExperimenteeNumber(String experimenteeNumber) async {
    setExperimentee(experimenteeNumber);
  }

  @override
  Widget build(BuildContext context) {
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

    return loading
        ? LoadingScreen()
        : Form(
            key: formKey,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: scaffoldKey,
              appBar: const CustomAppBar('กรอกรหัสการทดลอง'),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      deviceWidth(context) * 0.02,
                      0,
                      deviceWidth(context) * 0.025,
                      deviceHeight(context) * 0.04),
                  child: Form(
                    key: formGlobalKey,
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 15, 0, 0),
                            child: TextFormFieldCustom(
                              tokenController,
                              'Experimental code',
                              TextInputType.text,
                              (val) {
                                if (val.isEmpty) {
                                  return 'โปรดระบุรหัสการทดลอง';
                                }
                                experimenteeId = val;
                                return null;
                              },
                            ),
                          ),
                          FloatingButton(() => {
                                if (formGlobalKey.currentState.validate())
                                  {
                                    setExperimenteeNumber(experimenteeId),
                                    Navigator.pushNamed(
                                        context, IntroductionScreen.routeName)
                                  }
                              })
                        ]),
                  ),
                ),
              ),
            ),
          );
  }
}
