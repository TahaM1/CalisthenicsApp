import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutineForm extends StatefulWidget {
  @override
  RoutineFormState createState() => RoutineFormState();
}

class RoutineFormState extends State<RoutineForm> {
  final formKey = GlobalKey<FormState>();
  //List<Widget> list = listofText().add(SubmitExercisesButton(_formKey));
  List<String> userInputs = new List<String>();

  //final textController = TextEditingController();
  @override
  void dispose() {
    //textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Routine Name',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter a Routine Name';
                }
                return null;
              },
              onSaved: (value) {
                userInputs.add(value);
              },
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          ),
          ExcerciseTextField(number: 1, savedList: userInputs),
          ExcerciseTextField(number: 2, savedList: userInputs),
          ExcerciseTextField(number: 3, savedList: userInputs),
          ExcerciseTextField(number: 4, savedList: userInputs),
          SubmitExercisesButton(formkey: formKey)
        ],
      ),
    );
  }
}

class ExcerciseTextField extends StatelessWidget {
  final int number;
  final List<String> savedList;

  ExcerciseTextField({this.number, this.savedList}); //constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Excerise #${number}'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter An Excercise Please';
          }
          return null;
        },
        onSaved: (value) {
          print(value);
          savedList.add(value.replaceAll(' ', ''));
          print(savedList);
        },
      ),
    );
  }
}

class SubmitExercisesButton extends StatelessWidget {
  final GlobalKey<FormState> formkey;

  SubmitExercisesButton({this.formkey});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        if (formkey.currentState.validate()) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Processing Data')));
          formkey.currentState.save();
        }
      },
      child: Text('Submit'),
    );
  }
}
