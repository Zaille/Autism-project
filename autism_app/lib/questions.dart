import 'package:autismtest/form.dart';
import 'package:autismtest/submitButton.dart';
import "package:flutter/material.dart";
import 'package:autismtest/roundedContainer.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuestionWidget extends StatefulWidget {

  final List<String> questions = <String> [
    "If you point at something across the room, does your child look at it? "
        "\n(FOR EXAMPLE, if you point at a toy or an animal, does your child look at the toy or animal?)",
    "Have you ever wondered if your child might be deaf?",
    "Does your child play pretend or make-believe?"
      "\n(FOR EXAMPLE, pretend to drink from an empty cup, pretend to talk on a phone, or pretend to feed a doll or stuffed animal?)",
    "Does your child like climbing on things?"
      "\n(FOR EXAMPLE, furniture, playground equipment, or stairs)",
    "Does your child make unusual finger movements near his or her eyes?"
      "\n(FOR EXAMPLE, does your child wiggle his or her fingers close to his or her eyes?)",
    "Does your child point with one finger to ask for something or to get help?"
      "\n(FOR EXAMPLE, pointing to a snack or toy that is out of reach)",
    "Does your child point with one finger to show you something interesting?"
      "\n(FOR EXAMPLE, pointing to an airplane in the sky or a big truck in the road)",
    "Is your child interested in other children?"
      "\n(FOR EXAMPLE, does your child watch other children, smile at them, or go to them?)",
    "Does your child show you things by bringing them to you or holding them up for you to see – not to get help, but just to share?"
      "\n(FOR EXAMPLE, showing you a flower, a stuffed animal, or a toy truck)",
    "Does your child respond when you call his or her name? "
      "\n(FOR EXAMPLE, does he or she look up, talk or babble, or stop what he or she is doing when you call his or her name?)",
    "When you smile at your child, does he or she smile back at you?",
    "Does your child get upset by everyday noises? "
      "\n(FOR EXAMPLE, does your child scream or cry to noise such as a vacuum cleaner or loud music?)",
    "Does your child walk?",
    "Does your child look you in the eye when you are talking to him or her, playing with him or her, or dressing him or her?",
    "Does your child try to copy what you do? "
      "\n(FOR EXAMPLE, wave bye-bye, clap, or make a funny noise when you do)",
    "If you turn your head to look at something, does your child look around to see what you are looking at?",
    "Does your child try to get you to watch him or her? "
        "\n(FOR EXAMPLE, does your child look at you for praise, or say “look” or “watch me”?)",
    "Does your child understand when you tell him or her to do something?"
      "\n(FOR EXAMPLE, if you don’t point, can your child understand “put the book on the chair” or “bring me the blanket”?)",
    "If something new happens, does your child look at your face to see how you feel about it?"
      "\n(FOR EXAMPLE, if he or she hears a strange or funny noise, or sees a new toy, will he or she look at your face?)",
    " Does your child like movement activities?"
      "\n(FOR EXAMPLE, being swung or bounced on your knee)",
  ];

  @override
  State<StatefulWidget> createState() {
    return QuestionState();
  }
}

class QuestionState extends State<QuestionWidget> {

  final _formKey = GlobalKey<FormState>();

  int score = 0;
  List<bool> responses = <bool>[];

  int questionIndex = 0;
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            RoundedContainer(
              title: "Question " + (questionIndex + 1).toString(),
              height: 300.0,
              color: Colors.lightBlue.withOpacity(0.2),
              children: [
                Text(
                  widget.questions[questionIndex],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Row(
                  children: <Widget>[
                    Spacer(),
                    _myRadioButton(
                      title: "Yes",
                      value: 1,
                      onChanged: (newValue) => setState(() => _selected = newValue),
                    ),
                    Spacer(),
                    _myRadioButton(
                      title: "No",
                      value: 0,
                      onChanged: (newValue) => setState(() => _selected = newValue),
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(),
              ],
            ),
            SubmitButton(
              text: "   VALIDATE    ",
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 100),
              onPressed: () {
                if (_selected == -1) Fluttertoast.showToast(msg: "Select an item");
                else {
                  if (_selected == 1) {
                    responses.add(true);
                    score ++;
                  }
                  else responses.add(false);
                  if (questionIndex == 19) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FormPage()),
                    );
                  }
                  else {
                    setState(() {
                      questionIndex ++;
                      _selected = -1;
                    });
                  }
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("© 2009 Diana Robins, Deborah Fein, & Marianne Barton.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xffaaaaaa)
                ),
              ),
            ),
          ],
        ),
    );
  }
  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return Container(
      width: 150,
      child: RadioListTile(
        value: value,
        groupValue: _selected,
        onChanged: onChanged,
        title: Text(title),
      ),
    );
  }
}

class QuestionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuestionWidget(),
    );
  }
}