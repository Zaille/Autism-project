import 'package:autismtest/copyright.dart';
import 'package:autismtest/link.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:autismtest/roundedContainer.dart';

class QuestionsPage extends StatefulWidget {

  final List<String> questions = <String> [
    "If you point at something across the room, does your child look at it? "
        "\n\n(For example, if you point at a toy or an animal, does your child look at the toy or animal?)",
    "Have you ever wondered if your child might be deaf?",
    "Does your child play pretend or make-believe?"
      "\n\n(For example, pretend to drink from an empty cup, pretend to talk on a phone, or pretend to feed a doll or stuffed animal?)",
    "Does your child like climbing on things?"
      "\n\n(For example, furniture, playground equipment, or stairs)",
    "Does your child make unusual finger movements near his or her eyes?"
      "\n\n(For example, does your child wiggle his or her fingers close to his or her eyes?)",
    "Does your child point with one finger to ask for something or to get help?"
      "\n\n(For example, pointing to a snack or toy that is out of reach)",
    "Does your child point with one finger to show you something interesting?"
      "\n\n(For example, pointing to an airplane in the sky or a big truck in the road)",
    "Is your child interested in other children?"
      "\n\n(For example, does your child watch other children, smile at them, or go to them?)",
    "Does your child show you things by bringing them to you or holding them up for you to see – not to get help, but just to share?"
      "\n\n(For example, showing you a flower, a stuffed animal, or a toy truck)",
    "Does your child respond when you call his or her name? "
      "\n\n(For example, does he or she look up, talk or babble, or stop what he or she is doing when you call his or her name?)",
    "When you smile at your child, does he or she smile back at you?",
    "Does your child get upset by everyday noises? "
      "\n\n(For example, does your child scream or cry to noise such as a vacuum cleaner or loud music?)",
    "Does your child walk?",
    "Does your child look you in the eye when you are talking to him or her, playing with him or her, or dressing him or her?",
    "Does your child try to copy what you do? "
      "\n\n(For example, wave bye-bye, clap, or make a funny noise when you do)",
    "If you turn your head to look at something, does your child look around to see what you are looking at?",
    "Does your child try to get you to watch him or her? "
        "\n\n(For example, does your child look at you for praise, or say “look” or “watch me”?)",
    "Does your child understand when you tell him or her to do something?"
      "\n\n(For example, if you don’t point, can your child understand “put the book on the chair” or “bring me the blanket”?)",
    "If something new happens, does your child look at your face to see how you feel about it?"
      "\n\n(For example, if he or she hears a strange or funny noise, or sees a new toy, will he or she look at your face?)",
    " Does your child like movement activities?"
      "\n\n(For example, being swung or bounced on your knee)",
  ];

  @override
  State<StatefulWidget> createState() {
    return QuestionState();
  }
}

class QuestionState extends State<QuestionsPage> {

  int score = 0;
  List<bool> responses = <bool>[];

  int questionIndex = 0;
  bool selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 80),
            child: RoundedContainer(
              context: context,
              title: "Question " + (questionIndex + 1).toString(),
              children: [
                Text(
                  widget.questions[questionIndex],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(flex: 1, child: Container(),),
                        myRadioButton(
                          title: "Yes",
                          value: true,
                          onChanged: (newValue) => setState(() => selected = newValue),
                        ),
                        myRadioButton(
                          title: "No",
                          value: false,
                          onChanged: (newValue) => setState(() => selected = newValue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Builder(
            builder: (context) => NavigationButtons(
              prevCondition: questionIndex > 0,
              previousFunction: () {
                setState(() {
                  questionIndex --;
                  if (!responses[questionIndex]) score --;
                  responses.removeLast();
                  selected = null;
                });
              },
              nextFunction: () {
                if (selected == null)
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Select an item"),
                      behavior: SnackBarBehavior.floating,
                    )
                );
                else {
                  if (
                  (selected & (questionIndex != 1) & (questionIndex != 4) & (questionIndex != 11)) |
                  (!selected & ( (questionIndex == 1) | (questionIndex == 4) | (questionIndex == 11) ))
                  ) setState(() => responses.add(true));
                  else {
                    setState(() => score ++);
                    responses.add(false);
                  }
                  if (questionIndex == 19) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LinkPage(responses: this.responses, score: this.score)),
                    );
                  }
                  else {
                    setState(() {
                      questionIndex ++;
                      selected = null;
                    });
                  }
                }
              },
            ),
          ),
          Copyright(),
        ],
      ),
    );
  }
  Widget myRadioButton({String title, bool value, Function onChanged}) {
    return Expanded(
      flex: 6,
      child: RadioListTile(
        value: value,
        groupValue: selected,
        onChanged: onChanged,
        title: Text(title),
      ),
    );
  }
}