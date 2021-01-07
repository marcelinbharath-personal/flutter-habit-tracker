import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/activity_provider.dart';
import '../../models/activity.dart';

class EditActivityScreen extends StatefulWidget {
  static const routeName = 'edit-activity';
  @override
  _EditActivityScreenState createState() => _EditActivityScreenState();
}

class _EditActivityScreenState extends State<EditActivityScreen> {
  final _descFocusNode = FocusNode();
  final _activityForm = GlobalKey<FormState>();
  var _editedActivity = Activity(id: null, name: '', desc: '');
  var _initValues = {
    'name': '',
    'price': '',
  };
  var _isInit = true;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final activityId = ModalRoute.of(context).settings.arguments as String;
      if (activityId != null) {
        _editedActivity = Provider.of<ActivityProvider>(context, listen: false)
            .findById(activityId);
        _initValues = {
          'id': _editedActivity.id,
          'name': _editedActivity.name,
          'desc': _editedActivity.desc
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _descFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final _isValid = _activityForm.currentState.validate();
    if (!_isValid) {
      return;
    }
    _activityForm.currentState.save();
    setState(() {
      isLoading = true;
    });
    if (_editedActivity.id != null) {
      await Provider.of<ActivityProvider>(context, listen: false)
          .updateActivity(_editedActivity.id, _editedActivity);
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<ActivityProvider>(context, listen: false)
            .addActivity(_editedActivity);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occured!'),
            content: Text('Something went wrong!!'),
            actions: [
              FlatButton(
                  child: Text('Ok'), onPressed: () => Navigator.of(ctx).pop())
            ],
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit Activity'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _activityForm,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'Activity Name'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide Activity name.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_descFocusNode);
                      },
                      onSaved: (newValue) {
                        _editedActivity = Activity(
                            name: newValue,
                            desc: _editedActivity.desc,
                            id: _editedActivity.id);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['desc'],
                      decoration:
                          InputDecoration(labelText: 'Activity Description'),
                      focusNode: _descFocusNode,
                      textInputAction: TextInputAction.next,
                      validator: (newValue) {
                        if (newValue.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _editedActivity = Activity(
                            name: _editedActivity.name,
                            desc: newValue,
                            id: _editedActivity.id);
                      },
                    ),
                    RaisedButton(
                        child: Text('Save'),
                        color: Theme.of(context).primaryColorLight,
                        onPressed: () {
                          _saveForm();
                        })
                  ],
                ),
              ),
            ),
    );
  }
}
