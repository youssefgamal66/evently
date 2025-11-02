import 'package:flutter/material.dart';

class CustTextForm extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final isPassword;
  final String? lableText;
  final String? hinText;
  final Widget? photo;
  final int? maxline;
  final int? minline;
  final bool isExpand;
  final void Function(String value)? onChanged;
  CustTextForm(
      {super.key,
      this.controller,
      this.validator,
      this.lableText,
      this.hinText,
      this.isPassword = false,
      this.photo,
      this.maxline,
      this.minline,
      this.isExpand = false,
      this.onChanged});

  @override
  State<CustTextForm> createState() => _CustTextFormState();
}

class _CustTextFormState extends State<CustTextForm> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onChanged: widget.onChanged,
        expands: widget.isExpand,
        controller: widget.controller,
        validator: widget.validator,
        maxLines: widget.maxline,
        minLines: widget.minline,
        textAlignVertical: TextAlignVertical.top,
        obscureText: widget.isPassword ? !isShow : false,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          prefixIcon: widget.photo,
          prefixIconColor: Color(0xff7B7B7B),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isShow = !isShow;
                    });
                  },
                  icon: Icon(
                      isShow ? Icons.remove_red_eye : Icons.visibility_off),
                )
              : SizedBox(),
          suffixIconColor: Color(0xff7B7B7B),
          hintText: widget.hinText,
          labelText: widget.lableText,
          labelStyle: TextStyle(color: Color(0xff7B7B7B)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff7B7B7B)),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      ),
    );
  }
}
