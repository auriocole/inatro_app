

// ignore_for_file: use_key_in_widget_constructors, unnecessary_new, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/colors.dart';


class FormContainerPagamentoWidget extends StatefulWidget {

  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FormContainerPagamentoWidget({
    this.controller,
    this.isPasswordField,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType
  });


  @override
  _FormContainerPagamentoWidgetState createState() => new _FormContainerPagamentoWidgetState();
}

class _FormContainerPagamentoWidgetState extends State<FormContainerPagamentoWidget> {

  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.100),
        //border: ,
      ),
      child: new TextFormField(
        style: TextStyle(color: secondary),
        cursorColor: primary,
        controller: widget.controller,
        keyboardType: TextInputType.phone,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: new InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: secondary.shade200),
          suffixIcon: new GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child:
            widget.isPasswordField==true? Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: _obscureText == false ? secondary : Colors.grey,) : Text(""),
          ),
        ),
      ),
    );
  }
}
