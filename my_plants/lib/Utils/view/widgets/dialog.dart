import 'package:flutter/material.dart';

void showDialogCustom(BuildContext context, Function callback, String title) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => _Dialog(
        title: "Añade tu planta",
        content: "Ingresa el nombre de tu nueva planta",
        callback: callback),
  );
}

class _DecorationDialog extends StatelessWidget {
  const _DecorationDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      child:
          Image(image: AssetImage(("assets/images/decoration_card_add.png"))),
    );
  }
}

class _Dialog extends StatelessWidget {
  final String title, content;

  String namePlant = "";

  final Function callback;
  _Dialog({
    required this.content,
    required this.title,
    required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(title, style: TextStyle(color: Color(0xff008F39))),
      content: Stack(
        children: [
          //  _DecorationDialog(),
          Column(
            mainAxisSize: MainAxisSize.min, //SE ADAPTE AL CONTENIDO
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        content,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xff008F39), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        autocorrect: false,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "Dalia",
                            prefixIcon: Icon(
                              Icons.edit,
                              color: Color(0xff008F39),
                            ),
                            border: InputBorder.none),
                        onChanged: (value) => namePlant = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Debes llenar el campo de texto";
                          }
                          return null;

                          /* return null; */
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancelar',
              style: TextStyle(color: Color(0xff008F39)),
            )),
        TextButton(
            onPressed: () {
              /* formNameBloc.add(ValidateFormEvent()); */
              if (formKey.currentState?.validate() ?? false) {
                FocusScope.of(context).unfocus();
                callback(namePlant);
                Navigator.of(context).pop();
              }
            },
            child: Text(
              'Aceptar',
              style: TextStyle(color: Color(0xff008F39)),
            ))
      ],
    );
  }
}
