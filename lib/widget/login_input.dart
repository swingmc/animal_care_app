import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animalCare/util/export_file.dart';

class LoginInput extends StatefulWidget {

  final Image image;
  final bool useImage;
  final String hint;
  final ValueChanged<String>? onChanged;
  final bool lineStretch;
  bool obscureText;
  final TextInputType? keyboardType;
  final String errNotice;
  final bool Function() validate;
  final bool isLengthLimit;
  String buttonImagePath;
  RightButtonCallback rightButtonCallback;
  final bool autofocus;
  final bool hasLeftPadding;
  final bool isWifi;
  final int limitLength ;

  static bool _defaultValidate(){
    return true;
  }

  static void _pressRightButton(dynamic){}

  LoginInput(this.image, this.hint,
      {Key? key,
        this.onChanged,
        this.lineStretch = false,
        this.obscureText = false,
        this.keyboardType,
        this.errNotice = "invalid input",
        this.validate = _defaultValidate,
        this.buttonImagePath = "",
        this.rightButtonCallback = _pressRightButton,
        this.useImage = true,
        this.isLengthLimit = true,
        this.autofocus = false,
        this.hasLeftPadding = true,
        this.isWifi = false,
        this.limitLength = 40,
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();
  bool _isValid = true;
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //是否获取光标监听

    _focusNode.addListener(() {
      print("Has foucs: ${_focusNode.hasFocus}");
      if (!_focusNode.hasFocus) {
        print("lose focus");
        setState(() {
          _isValid = widget.validate();
        });
      }
    });

    //默认不获取focus
    if(!widget.autofocus) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        // Delaying the focus setting to the next frame to ensure the keyboard is fully initialized
        FocusScope.of(context).requestFocus(FocusNode());
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            //SizedBox(width: 40, height: 75,),
            if(widget.useImage)
              Container(
                //padding: EdgeInsets.only(left: 15),
                  width: 24,
                  height: 24,
                  margin: widget.hasLeftPadding ? EdgeInsets.only(left: 24) : null,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: widget.image.image,
                      fit: BoxFit.contain,
                    ),
                  )
              ),
            _input(),
            if(widget.buttonImagePath.length > 0 &&
                widget.rightButtonCallback != LoginInput._pressRightButton)
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 3),
                child:
                SizedBox(
                    height: 48,
                    child: TextButton(
                      onPressed: () { widget.rightButtonCallback(this); },
                      child: Image.asset(widget.buttonImagePath),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          CircleBorder(),
                        ),
                        //backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        //padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        //  EdgeInsets.zero,
                        //),
                      ),
                    )
                ),
              )

          ],
        ),
        Padding(
          padding: widget.hasLeftPadding ? EdgeInsets.only(
            left: 24,
            right: 24,
            bottom : 6
          ) : EdgeInsets.only(),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        ),
        if (!_isValid) // show error message if input is invalid
          Container(
            alignment: Alignment.centerLeft,
            padding: widget.hasLeftPadding ? EdgeInsets.only(left: 24) : null,
            child: Text(
              '${widget.errNotice}',
              style: TextStyle(
                color: errorInfoColor,
                fontSize: 12
              ),
            ),
          ),
      ]
      ,
    );
  }

  _input() {
    return Expanded(child: TextFormField(
      focusNode: _focusNode,
      controller: _textEditingController,
      inputFormatters: [
        // widget.obscureText ? FilteringTextInputFormatter.allow(RegExp(
        //     "[a-zA-Z]|[0-9]|[-.,_~!@#%|/';?^+*]&=")) :
        // FilteringTextInputFormatter.allow(
        //     RegExp("[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]|[-.,_~!@#%|/';?^+*]&=")),
        LengthLimitingTextInputFormatter(widget.limitLength),
        FilteringTextInputFormatter(RegExp("[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"), allow: false)
      ],
      // bind the controller to the TextField
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      cursorColor: primaryColor,
      style: TextStyle(
          fontSize: 18, color: textColor, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
          contentPadding: widget.isWifi ? EdgeInsets.only(left: 24) : EdgeInsets.only(left: 12, right: 20),
          border: InputBorder.none,
          hintText: widget.hint ?? '',
          hintStyle: TextStyle(
              fontSize: 18, color: inputTextColor, fontWeight: FontWeight.w300),
      ),
      // validate input on losing focus
      /*
      onEditingComplete: () {
        setState(() {
          _isValid = widget.validate();
        });
      }
      ,
       */
    ));
  }

// validate input
/*
  bool _validateInput() {
    print("valid");
    // your validation logic here
    final text = _textEditingController.text;
    if(text == "wrong") {
      print("wrong!");
      return false;
    }
    print(text);
    return true; // return true if input is valid, false otherwise
  }
   */
}


//定义输入按钮内部
typedef RightButtonCallback = void Function(_LoginInputState);

void CleanUpContent(_LoginInputState widget){
  widget.setState(() {
    widget._textEditingController.clear();
    widget._isValid = true;
  });
}

void SetPasswordViewable(_LoginInputState widget) {
  widget.setState(() {
    widget.widget.obscureText = false;
    widget.widget.buttonImagePath = UNEYES_ICON;
    widget.widget.rightButtonCallback = SetPasswordUnviewable;
  });
}

void SetPasswordUnviewable(_LoginInputState widget) {
  widget.setState(() {
    widget.widget.obscureText = true;
    widget.widget.buttonImagePath = EYES_ICON;
    widget.widget.rightButtonCallback = SetPasswordViewable;
  });
}