import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/core/const/app_assets.dart';
import 'package:evently/core/maneger/app_provider.dart';
import 'package:evently/core/routes/app_route_name.dart';
import 'package:evently/module/auth/maneger/auth_provider.dart';
import 'package:evently/module/auth/widget/cust_text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),

      child: SafeArea(
        child: Scaffold(
            body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<AuthProvider>(
              builder: (context, provider, child) {
              return  Form(
                key:provider.formKey,
                child: Column(children: [
                    Image.asset(
                      AppAssets.logoEventle,
                      width: 200,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: provider.emailController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          prefixIconColor: Color(0xff7B7B7B),
                          label:  Text(AppLocalizations.of(context)!.email),
                          labelStyle: TextStyle(color: Color(0xff7B7B7B)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff7B7B7B)),
                              borderRadius: BorderRadius.all(Radius.circular(15)))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustTextForm(
                      controller: provider.passwordController,
                    lableText: "Password",
                      isPassword: true,
                      photo: Icon(Icons.lock),
                      maxline: 1,

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, RouteName.forget);
                          },
                          child:
                          Text(AppLocalizations.of(context)!.forget_password,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: theme.primaryColor),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(500, 60),
                            backgroundColor: theme.primaryColor,
                            padding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(16)))),
                        onPressed: () {
                          provider.login(context, provider.formKey); // ✅ صح
                        },

                        child: Text(AppLocalizations.of(context)!.login,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.donot_have_account,style: TextStyle(
                            fontSize: 17

                        ),),
                        SizedBox(width: 2,),
                        InkWell(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, RouteName.register);
                          },
                          child:
                          Text(AppLocalizations.of(context)!.create_account,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                decoration: TextDecoration.underline,
                                decorationColor: theme.primaryColor),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5,),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: theme.primaryColor,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child:
                            Text(AppLocalizations.of(context)!.or,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: theme.primaryColor,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    )
                    ,
                    SizedBox(height: 10,),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: theme.primaryColor
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.transparent
                      ),

                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.googleLogo,width: 30,),
                          SizedBox(width: 5,),
                          Text(AppLocalizations.of(context)!.login_with_google,style: TextStyle(
                              fontSize: 17
                              ,color: theme.primaryColor

                          ),)
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.ltr,
                      children: [
                        AnimatedToggleSwitch<String>.rolling(
                          current:appProvider.lang,
                          values:  ["en", "ar"],
                          onChanged: (value) {
                            appProvider.changeLang(value);
                          },
                          iconList: [

                            Image.asset(
                              AppAssets.LR_icon,
                            ),
                            Image.asset(
                              AppAssets.eg_icon,
                            ),
                          ],
                          style: ToggleStyle(
                              backgroundColor: Colors.transparent,
                              borderColor: theme.primaryColor,
                              indicatorColor: theme.primaryColor),
                          height: 40,
                          indicatorSize: Size(40, 40),
                        )
                      ],
                    )

                  ]),
              );
              },

            ),
          ),
        )),
      ),
    );
  }
}
