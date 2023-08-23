library flutter_json_widget;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repo_viewer/ui/auth/login/login_view_model.dart';
import 'package:repo_viewer/ui/json_viewer/json_viewer_viewmodel.dart';
import 'package:stacked/stacked.dart';

class JsonViewer extends StatefulWidget {
  final dynamic response;
  const JsonViewer({super.key,required this.response});
  @override
  JsonViewerState createState() => JsonViewerState();
}

class JsonViewerState extends State<JsonViewer> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => JsonViewerViewModel(),
        builder: (ctx, model, child) => SafeArea(
              child: Scaffold(
                  body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Json Viewer",
                        style: GoogleFonts.ibmPlexSans(
                            color: Colors.deepPurple,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      getContentWidget(widget.response),
                    ],
                  ),
                ),
              )),
            ));
  }

  static getContentWidget(dynamic content) {
    if (content == null) {
      return const Text('{}');
    } else if (content is List) {
      return JsonArrayViewer(content, notRoot: false);
    } else {
      return JsonObjectViewer(content, notRoot: false);
    }
  }
}

class JsonObjectViewer extends StatefulWidget {
  final Map<String, dynamic> jsonObj;
  final bool notRoot;

  const JsonObjectViewer(this.jsonObj, {super.key, this.notRoot = false});

  @override
  JsonObjectViewerState createState() => JsonObjectViewerState();
}

class JsonObjectViewerState extends State<JsonObjectViewer> {
  Map<String, bool> openFlag = {};

  @override
  Widget build(BuildContext context) {
    if (widget.notRoot) {
      return Container(
        padding: EdgeInsets.only(left: 20.w),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: _getList()),
      );
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: _getList());
  }

  _getList() {
    List<Widget> list = [];
    for (MapEntry entry in widget.jsonObj.entries) {
      bool ex = isExtensible(entry.value);
      bool ink = isInkWell(entry.value);
      list.add(Container(
        alignment: Alignment.center,
        height: 40.h,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ex
                ? ((openFlag[entry.key] ?? false)
                    ? Icon(Icons.arrow_drop_down,
                        size: 14, color: Colors.grey[700])
                    : Icon(Icons.arrow_right,
                        size: 14, color: Colors.grey[700]))
                : const Icon(
                    Icons.arrow_right,
                    color: Color.fromARGB(0, 0, 0, 0),
                    size: 14,
                  ),
            (ex && ink)
                ? InkWell(
                    child: Text(entry.key,
                        style: const TextStyle(color: Colors.black)),
                    onTap: () {
                      setState(() {
                        openFlag[entry.key] = !(openFlag[entry.key] ?? false);
                      });
                    })
                : Text(entry.key,
                    style: TextStyle(
                        color:
                            entry.value == null ? Colors.grey : Colors.black)),
            const Text(
              ':',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(width: 3),
            getValueWidget(entry)
          ],
        ),
      ));
      list.add(const SizedBox(height: 4));
      if (openFlag[entry.key] ?? false) {
        list.add(getContentWidget(entry.value));
      }
    }
    return list;
  }

  static getContentWidget(dynamic content) {
    if (content is List) {
      return JsonArrayViewer(content, notRoot: true);
    } else {
      return JsonObjectViewer(content, notRoot: true);
    }
  }

  static isInkWell(dynamic content) {
    if (content == null) {
      return false;
    } else if (content is int) {
      return false;
    } else if (content is String) {
      return false;
    } else if (content is bool) {
      return false;
    } else if (content is double) {
      return false;
    } else if (content is List) {
      if (content.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
    return true;
  }

  getValueWidget(MapEntry entry) {
    if (entry.value == null) {
      return Expanded(
          child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(
          'undefined'.toString().capitalize(),
          textAlign: TextAlign.end,
          style: const TextStyle(color: Colors.grey),
        ),
      ));
    } else if (entry.value is int) {
      return Expanded(
          child: Text(
        entry.value.toString(),
        style: const TextStyle(color: Colors.teal),
      ));
    } else if (entry.value is String) {
      return entry.key == "dataType" && entry.value == "string" || entry.value == "string|null"
          ? Expanded(
              child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Text(
                entry.value.toString().capitalize(),
                textAlign: TextAlign.end,
                style: const TextStyle(color: Colors.orange),
              ),
            ))
          : entry.key == "dataType" && entry.value == "reference" ||entry.value == "reference|null"
              ? Expanded(
                  child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    entry.value.toString().capitalize(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.pink),
                  ),
                ))
              :entry.key == "dataType" && entry.value == "array" ||entry.value == "array|null"
              ? Expanded(
                  child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    entry.value.toString().capitalize(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.red),
                  ),
                ))
              : entry.key == "dataType" && entry.value == "integer" || entry.value == "integer|null"
              ? Expanded(
                  child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    entry.value.toString().capitalize(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.red),
                  ),
                ))
              :entry.key == "dataType" && entry.value == "timestamp" ||  entry.value == "timestamp|null"
              ? Expanded(
                  child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    entry.value.toString().capitalize(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.red),
                  ),
                ))
              :entry.key == "dataType" && entry.value == "object" || entry.value == "object|null"
              ? Expanded(
                  child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    entry.value.toString().capitalize(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.purple),
                  ),
                ))
              :entry.key == "dataType" && entry.value == "boolean" || entry.value =="boolean|null"
              ? Expanded(
                  child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    entry.value.toString().capitalize(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.amber),
                  ),
                ))
              :entry.key == "dataType" && entry.value == "geopoint" || entry.value =="geopoint|null"
              ? Expanded(
                  child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    entry.value.toString().capitalize(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.green),
                  ),
                ))
              : entry.key == "dataType" && entry.value == "null"
              ? Expanded(
                  child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    entry.value.toString().capitalize(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.orange),
                  ),
                ))
              : Expanded(
                  child: Text(
                  '\"' + entry.value + '\"',
                  style: const TextStyle(color: Colors.orange),
                ));
    } else if (entry.value is bool) {
      return Expanded(
          child: Text(
        entry.value.toString(),
        style: const TextStyle(color: Colors.purple),
      ));
    } else if (entry.value is double) {
      return Expanded(
          child: Text(
        entry.value.toString(),
        style: const TextStyle(color: Colors.teal),
      ));
    } else if (entry.value is List) {
      if (entry.value.isEmpty) {
        return const Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              'Array[0]',
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      } else {
        return Expanded(
          child: InkWell(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  'Array<${getTypeName(entry.value[0])}>[${entry.value.length}]',
                  textAlign: TextAlign.end,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              onTap: () {
                setState(() {
                  openFlag[entry.key] = !(openFlag[entry.key] ?? false);
                });
              }),
        );
      }
    }
    return Expanded(
      child: InkWell(
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              'Object',
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.purple),
            ),
          ),
          onTap: () {
            setState(() {
              openFlag[entry.key] = !(openFlag[entry.key] ?? false);
            });
          }),
    );
  }

  static isExtensible(dynamic content) {
    if (content == null) {
      return false;
    } else if (content is int) {
      return false;
    } else if (content is String) {
      return false;
    } else if (content is bool) {
      return false;
    } else if (content is double) {
      return false;
    }
    return true;
  }

  static getTypeName(dynamic content) {
    if (content is int) {
      return 'int';
    } else if (content is String) {
      return 'String';
    } else if (content is bool) {
      return 'bool';
    } else if (content is double) {
      return 'double';
    } else if (content is List) {
      return 'List';
    }
    return 'Object';
  }
}

class JsonArrayViewer extends StatefulWidget {
  final List<dynamic> jsonArray;

  final bool notRoot;

  const JsonArrayViewer(this.jsonArray, {super.key, this.notRoot = false});

  @override
  JsonArrayViewerState createState() => JsonArrayViewerState();
}

class JsonArrayViewerState extends State<JsonArrayViewer> {
  late List<bool> openFlag;

  @override
  Widget build(BuildContext context) {
    if (widget.notRoot) {
      return Container(
          padding: EdgeInsets.only(left: 20.w),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _getList()));
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: _getList());
  }

  @override
  void initState() {
    super.initState();
    openFlag = List.filled(widget.jsonArray.length, false);
  }

  _getList() {
    List<Widget> list = [];
    int i = 0;
    for (dynamic content in widget.jsonArray) {
      bool ex = JsonObjectViewerState.isExtensible(content);
      bool ink = JsonObjectViewerState.isInkWell(content);
      list.add(Container(
        alignment: Alignment.center,
        height: 40.h,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ex
                ? ((openFlag[i])
                    ? Icon(Icons.arrow_drop_down,
                        size: 14, color: Colors.grey[700])
                    : Icon(Icons.arrow_right,
                        size: 14, color: Colors.grey[700]))
                : const Icon(
                    Icons.arrow_right,
                    color: Color.fromARGB(0, 0, 0, 0),
                    size: 14,
                  ),
            (ex && ink)
                ? getInkWell(i)
                : Text('[$i]',
                    style: TextStyle(
                        color: content == null
                            ? Colors.grey
                            : Colors.purple[900])),
            const Text(
              ':',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(width: 3),
            getValueWidget(content, i)
          ],
        ),
      ));
      list.add(const SizedBox(height: 4));
      if (openFlag[i]) {
        list.add(JsonObjectViewerState.getContentWidget(content));
      }
      i++;
    }
    return list;
  }

  getInkWell(int index) {
    return InkWell(
        child: Text('[$index]', style: TextStyle(color: Colors.purple[900])),
        onTap: () {
          setState(() {
            openFlag[index] = !(openFlag[index]);
          });
        });
  }

  getValueWidget(dynamic content, int index) {
    if (content == null) {
      return const Expanded(
          child: Text(
        'undefined',
        textAlign: TextAlign.end,
        style: TextStyle(color: Colors.grey),
      ));
    } else if (content is int) {
      return Expanded(
          child: Text(
        content.toString(),
        style: const TextStyle(color: Colors.teal),
      ));
    } else if (content is String) {
      return Expanded(
          child: Text(
        '\"' + content + '\"',
        style: const TextStyle(color: Colors.redAccent),
      ));
    } else if (content is bool) {
      return Expanded(
          child: Text(
        content.toString(),
        style: const TextStyle(color: Colors.purple),
      ));
    } else if (content is double) {
      return Expanded(
          child: Text(
        content.toString(),
        style: const TextStyle(color: Colors.teal),
      ));
    } else if (content is List) {
      if (content.isEmpty) {
        return const Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              'Array[0]',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      } else {
        return Expanded(
          child: InkWell(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  'Array<${JsonObjectViewerState.getTypeName(content)}>[${content.length}]',
                  textAlign: TextAlign.end,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              onTap: () {
                setState(() {
                  openFlag[index] = !(openFlag[index]);
                });
              }),
        );
      }
    }
    return Expanded(
      child: InkWell(
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              'Object',
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.purple),
            ),
          ),
          onTap: () {
            setState(() {
              openFlag[index] = !(openFlag[index]);
            });
          }),
    );
  }
}
