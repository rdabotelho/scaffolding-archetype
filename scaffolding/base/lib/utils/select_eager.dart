import 'package:flutter/material.dart';
import 'package:${context.projectName.toLowerCase()}/models/base_model.dart';
import 'package:${context.projectName.toLowerCase()}/utils/inputs_utils.dart';

class SelectEager extends StatefulWidget {

  final String _title;
  final Future<List<BaseModel>> _future;
  final ModelEditingController _controller;

  SelectEager(this._title, this._future, this._controller);

  @override
  _SelectEagerState createState() => new _SelectEagerState(this._title, this._future, this._controller);
}

class _SelectEagerState extends State<SelectEager> {

  BaseModel _model;
  TextEditingController editingController = TextEditingController();
  final String _title;
  final Future<List<BaseModel>> _future;
  final ModelEditingController _controller;
  List<BaseModel> notFilteredItems = List<BaseModel>();
  List<BaseModel>items = List<BaseModel>();

  _SelectEagerState(this._title, this._future, this._controller);

  @override
  void initState() {
    super.initState();
    this._future.then((list) {
      List<BaseModel> ofModel = _controller.multi ? _controller.models : (_controller.model != null ? [_controller.model] : []);
      if (ofModel == null) ofModel = [];
      for (BaseModel item in list) {
        bool sel = false;
        for (BaseModel item2 in ofModel) {
          if (item2 != null && item2.getId() == item.getId()) {
            sel = true;
            break;
          }
        }
        item.sel = sel;
      }
      notFilteredItems.addAll(list);
      this.filterSearchResults("");
    });
  }

  void filterSearchResults(String query) {
    if(query.isNotEmpty) {
      List<BaseModel> sublist = this.notFilteredItems.where((item) => item.getLabel().toUpperCase().contains(query.toUpperCase())).toList();
      setState(() {
        this.items.clear();
        this.items.addAll(sublist);
      });
    }
    else {
      setState(() {
        this.items.clear();
        this.items.addAll(this.notFilteredItems);
      });
    }
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
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Pesquisar",
                    prefixIcon: Icon(Icons.search),
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

  final _SelectEagerState _parent;
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

