import 'package:flutter/material.dart';
import 'package:${context.projectName.toLowerCase()}/models/base_model.dart';
import 'package:${context.projectName.toLowerCase()}/utils/inputs_utils.dart';

typedef SearchFunction = Future<List<BaseModel>> Function(String);

class SelectLazy extends StatefulWidget {

  final String _title;
  final SearchFunction _searchFunction;
  final ModelEditingController _controller;

  SelectLazy(this._title, this._searchFunction, this._controller);

  @override
  _SelectLazyState createState() => new _SelectLazyState(this._title, this._searchFunction, this._controller);
}

class _SelectLazyState extends State<SelectLazy> {


  BaseModel _model;
  TextEditingController editingController = TextEditingController();
  final String _title;
  final SearchFunction _searchFunction;
  final ModelEditingController _controller;
  List<BaseModel>itemsSelected = List<BaseModel>();
  List<BaseModel>items = List<BaseModel>();

  _SelectLazyState(this._title, this._searchFunction, this._controller);

  @override
  void initState() {
    super.initState();
    List<BaseModel> ofModel = _controller.multi ? _controller.models : (_controller.model != null ? [_controller.model] : []);
    if (ofModel == null) ofModel = [];
    for (BaseModel item in ofModel) {
      item.sel = true;
      itemsSelected.add(item);
    }
    this.insertItemsSelected();
  }

  void insertItemsSelected() {
    items.clear();
    for (BaseModel item in itemsSelected) {
      items.add(item);
    }
  }

  void filterSearchResults(String query) {
    if (query == null || query.length == 0) {
      return;
    }
    _searchFunction.call(query).then((list) {
      setState(() {
        list.forEach((item) => item.sel = false);
        insertItemsSelected();
        list.removeWhere((item) {
          var exist = itemsSelected.firstWhere((item2) => item2.getId() == item.getId(), orElse: () => null);
          return exist != null;
        });
        items.addAll(list);
        items.sort((a, b) => a.getLabel().compareTo(b.getLabel()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this._title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Pesquisar",
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(right: 4.0),
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed: () => filterSearchResults(editingController.text),
                        child: Icon(Icons.search),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0))
                    )
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _BaseModelItem(items[index], this);
                },
              ),
            ),
            Visibility(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  width: double.infinity,
                  child: new RaisedButton(
                      child: const Text('CONFIRMAR'),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).pop(
                            items.where((item) => item.sel == true).toList()
                        );
                      }
                  )
              ),
              visible: _controller.multi,
            ),
          ],
        ),
      ),
    );
  }

}

class _BaseModelItem extends StatelessWidget {

  final _SelectLazyState _parent;
  final BaseModel _model;

  _BaseModelItem(this._model, this._parent);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: (){
          if (!this._parent._controller.multi) {
            Navigator.of(context).pop(_model);
          }
          else {
            _parent.setState(() {
              _model.sel = !_model.sel;
            });
          }
        },
        child: Card(
          child: ListTile(
            title: Text(
              _model.getLabel(),
              style: TextStyle(fontSize: 24.0),
            ),
            trailing: Visibility(
              child: Icon(Icons.check),
              visible: _model.sel,
            ),
          ),
        ),
      ),
    );
  }

}

