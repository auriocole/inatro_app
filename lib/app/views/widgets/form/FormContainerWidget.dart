import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';


class FormContainerWidget extends StatefulWidget {

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

  const FormContainerWidget({super.key,
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
  FormContainerWidgetState createState() => FormContainerWidgetState();
}

class FormContainerWidgetState extends State<FormContainerWidget> {

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: secondary,
      ),
      cursorColor: primary,
      controller: widget.controller,
      keyboardType: widget.inputType,
      key: widget.fieldKey,
      obscureText: widget.isPasswordField == true ? _obscureText : false,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        filled: true, // Ativa cor de fundo
        fillColor: secondary.shade50, // A cor que estava no BoxDecoration

        hintText: widget.hintText,
        hintStyle: TextStyle(color: secondary.shade200),

        // Estilos de borda
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),

        // Ícone de mostrar/ocultar senha
        suffixIcon: widget.isPasswordField == true
            ? GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: _obscureText ? Colors.grey : secondary,
          ),
        )
            : null,
      ),
    );
  }
}
