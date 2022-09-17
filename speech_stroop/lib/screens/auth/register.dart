import 'package:speech_stroop/model/precondition.dart';
import 'package:speech_stroop/model/user.dart';

UserHealthScore userHealthScores = UserHealthScore(0, 0);
PreconditionScore colorVisibilityTest = PreconditionScore(0, DateTime.now());
PreconditionScore readingAbilityTest = PreconditionScore(0, DateTime.now());
Precondition precondition =
    Precondition(true, colorVisibilityTest, readingAbilityTest, false);
User registerReq = User('', '', '', '', '', '', DateTime.now(), '', '',
    userHealthScores, precondition);
