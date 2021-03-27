import 'package:${context.projectName.toLowerCase()}/models/base_model.dart';
import 'package:${context.projectName.toLowerCase()}/utils/select_eager.dart';
import 'package:${context.projectName.toLowerCase()}/utils/select_lazy.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:${context.projectName.toLowerCase()}/enums/base_enum.dart';
import 'package:intl/intl.dart' show DateFormat;

Widget StringFormField(setState, BuildContext context, TextEditingController controller, InputDecoration decoration, FormFieldValidator<String> validator) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: TextFormField (
      controller: controller,
      decoration: decoration,
      keyboardType: TextInputType.text,
      validator: validator,
    ),
  );
}

Widget IntegerFormField(setState, BuildContext context, TextEditingController controller, InputDecoration decoration, FormFieldValidator<String> validator) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: TextFormField (
      controller: controller,
      decoration: decoration,
      keyboardType: TextInputType.number,
      validator: validator,
    ),
  );
}

Widget DoubleFormField(setState, BuildContext context, TextEditingController controller, InputDecoration decoration, FormFieldValidator<String> validator) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: TextFormField (
      controller: controller,
      decoration: decoration,
      keyboardType: TextInputType.number,
      validator: validator,
    ),
  );
}

Widget DateTimeFormField(setState, BuildContext context, TextEditingController controller, InputDecoration decoration, FormFieldValidator<String> validator) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: DateTimeField(
      format: DateFormat("dd/MM/yyyy"),
      controller: controller,
      decoration: decoration,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
      onChanged: (val) {
        debugPrint(val.toIso8601String());
      },
      onSaved: (val) {
        debugPrint(val.toIso8601String());
      },
    ),
  );
}

Widget ListFormField(setState, BuildContext context, TextEditingController controller, InputDecoration decoration, FormFieldValidator<String> validator) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: TextFormField (
      controller: controller,
      decoration: decoration,
      keyboardType: TextInputType.number,
      validator: validator,
    ),
  );
}

Widget TextAreaFormField(setState, BuildContext context, TextEditingController controller, InputDecoration decoration, FormFieldValidator<String> validator) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: TextFormField (
      controller: controller,
      decoration: decoration,
      keyboardType: TextInputType.text,
      validator: validator,
    ),
  );
}

Widget EnumFormField(setState, BuildContext context, TextEditingController controller, InputDecoration decoration, FormFieldValidator<String> validator, List<EnumValue> items) {

  debugPrint(controller.text);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: DropdownButtonFormField(
      value: controller.text.isNotEmpty ? controller.text : null,
      items: items.map((EnumValue val) {
        return DropdownMenuItem<String>(
          child: Text(val.description),
          value: val.name,
        );
      },
      ).toList(),
      decoration: decoration,
      onChanged: (val) {
        controller.text = val;
      },
    ),
  );
}

Widget SelectEagerFormField(setState, BuildContext context, ModelEditingController controller, InputDecoration decoration, FormFieldValidator<String> validator, Future<List<BaseModel>> future) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => SelectEager(decoration.labelText, future, controller)
              )
          )
              .then((result) {
            if (result == null) return;
            setState(() {
              if (controller.multi) {
                controller.models = result;
              }
              else {
                controller.model = result;
              }
            });
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black38,
                width: 1,
              ),
            ),
          ),
          child: ListTile(
            title: Text(
              decoration.labelText,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            subtitle: Text(controller.getLabel()),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    ),
  );
}

Widget SelectLazyFormField(setState, BuildContext context, ModelEditingController controller, InputDecoration decoration, FormFieldValidator<String> validator, SearchFunction searchFunction) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => SelectLazy(decoration.labelText, searchFunction, controller)
              )
          )
              .then((result) {
            if (result == null) return;
            setState(() {
              if (controller.multi) {
                controller.models = result;
              }
              else {
                controller.model = result;
              }
            });
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black38,
                width: 1,
              ),
            ),
          ),
          child: ListTile(
            title: Text(
              decoration.labelText,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            subtitle: Text(controller.getLabel()),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    ),
  );
}

Widget SelectDropdownFormField(setState, BuildContext context, ModelEditingController controller, InputDecoration decoration, FormFieldValidator<String> validator, Future<List<BaseModel>> future) {
  List<BaseModel> list = new List();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: FutureBuilder(
      future: future,
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          return DropdownButtonFormField<int>(
            value: controller.model != null ? controller.model.getId() : null,
            items: snapshot.data.map<DropdownMenuItem<int>>((BaseModel val) {
              list.add(val);
              return DropdownMenuItem(
                child: Text(val.getLabel()),
                value: val.getId(),
              );
            },
            ).toList(),
            decoration: decoration,
            onChanged: (val) {
              controller.model = list.firstWhere((item) => item.getId() == val);
            },
          );
        }
        else {
          return Text('Carregando...');
        }
      },
    ),
  );
}

Widget BooleanFormField(setState, BuildContext context, TextEditingController controller, InputDecoration decoration, FormFieldValidator<String> validator) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black38,
            width: 1,
          ),
        ),
      ),
      child: SwitchListTile(
        title: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(decoration.labelText)
        ),
        value: controller.text != null ? controller.text == "true" : false,
        onChanged: (bool value) {
          setState(() => controller.text = "$value");
        },
      ),
    ),
  );
}

Widget CompositionFormField(setState, BuildContext context, ModelEditingController controller, InputDecoration decoration, WidgetBuilder builder) {
  List<BaseModel> models = controller.models != null ? controller.models : [];
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black38,
                width: 1.0,
              ),
            ),
          ),
          child: Container(
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: Text(
                decoration.labelText,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              trailing: Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: builder)
                    ).then((model) {
                      if (model == null) return;
                      setState((){
                        models.add(model);
                      });
                    });
                  },
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: models.length,
          itemBuilder: (context, index) {
            var model = models[index];
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black38,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(
                  model.getLabel(),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black45,
                  ),
                ),
                trailing: Material(
                  child: InkWell(
                      onTap: () {
                        setState((){
                          models.removeAt(index);
                        });
                      },
                      child: Icon(Icons.cancel)
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

class ModelEditingController extends TextEditingController {

  bool multi;
  List<BaseModel> models;
  BaseModel model;

  ModelEditingController(this.multi);

  String getLabel() {
    if (multi && models != null) {
      return models.map<String>((e) => e.getLabel()).join(", ");
    }
    else if (model != null) {
      return model.getLabel();
    }
    return "";
  }

}
