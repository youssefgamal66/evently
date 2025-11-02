import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/core/const/app_assets.dart';
import 'package:evently/core/maneger/app_provider.dart';
import 'package:evently/core/routes/app_route_name.dart';
import 'package:evently/module/auth/maneger/auth_provider.dart';
import 'package:evently/module/auth/widget/cust_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RegistScreen extends StatelessWidget {
  const RegistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, RouteName.Login);
                },
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(
                AppLocalizations.of(context)!.register,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<AuthProvider>(
                      builder: (context, provider, child) {
                        return Form(
                          key: provider.formKey,
                          child: Column(children: [
                            Image.asset(
                              AppAssets.logoEventle,
                              width: 200,
                            ),
                            TextFormField(
                              controller: provider.nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Invalid Value";
                                } else
                                  return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                  ),
                                  prefixIconColor: Color(0xff7B7B7B),
                                  label:
                                      Text(AppLocalizations.of(context)!.name),
                                  labelStyle:
                                      TextStyle(color: Color(0xff7B7B7B)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff7B7B7B)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: provider.emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Invalid Value";
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return "Invalid Value";
                                } else
                                  return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                  ),
                                  prefixIconColor: Color(0xff7B7B7B),
                                  label:
                                      Text(AppLocalizations.of(context)!.email),
                                  labelStyle:
                                      TextStyle(color: Color(0xff7B7B7B)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff7B7B7B)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustTextForm(
                              controller: provider.passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Invalid Password";
                                } else if (value.length < 6) {
                                  return "Invalid length";
                                } else if (value !=
                                    provider.passwordController.text) {
                                  return "Not Match";
                                } else
                                  return null;
                              },
                              lableText: "Password",
                              isPassword: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustTextForm(
                              controller: provider.rePasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Invalid Password";
                                } else if (value.length < 6) {
                                  return "Invalid length";
                                } else if (value !=
                                    provider.passwordController.text) {
                                  return "Not Match";
                                } else
                                  return null;
                              },
                              lableText: "Re Password",
                              isPassword: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(500, 60),
                                    backgroundColor: theme.primaryColor,
                                    padding: EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)))),
                                onPressed: () {
                                  provider.createAccount(context, provider.formKey); // ✅ صح
                                },

                                child: Text(
                                  AppLocalizations.of(context)!.create_account,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .already_have_account,
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, RouteName.Login);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.login,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        decoration: TextDecoration.underline,
                                        decorationColor: theme.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            AnimatedToggleSwitch<String>.rolling(
                              current: appProvider.lang,
                              values: ["en", "ar"],
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
                            ),
                          ]),
                        );
                      },
                    )))),
      ),
    );
  }
}
