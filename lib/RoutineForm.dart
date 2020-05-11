import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutineForm extends StatefulWidget {
  @override
  RoutineFormState createState() => RoutineFormState();
}

class RoutineFormState extends State<RoutineForm> {
  final _formKey = GlobalKey<FormState>();
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
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Excerise #${1}'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter An Excercise Please';
                }
                return null;
              },
              onSaved: (value) => userInputs.add(value),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Excerise #${2}'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter An Excercise Please';
                }
                return null;
              },
              onSaved: (value) => userInputs.add(value),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Excerise #${3}'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter An Excercise Please';
                }
                return null;
              },
              onSaved: (value) => userInputs.add(value),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Excerise #${4}'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter An Excercise Please';
                }

                return null;
              },
              onSaved: (value) {
                userInputs.add(value);

                print(userInputs);
              },
            ),
          ),
          SubmitExercisesButton(_formKey)
        ],
      ),
    );
  }
}

List<Widget> listofText() {
  List<Widget> list = new List<Widget>();

  for (var i = 0; i < 4; i++) {
    list.add(Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Excerise #${i + 1}'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter An Excercise Please';
          }
          return null;
        },
      ),
    ));
  }

  return list;
}

class SubmitExercisesButton extends StatelessWidget {
  GlobalKey<FormState> _key;

  SubmitExercisesButton(GlobalKey<FormState> key) {
    this._key = key;
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        if (_key.currentState.validate()) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Processing Data')));
          _key.currentState.save();
        }
      },
      child: Text('Submit'),
    );
  }
}
