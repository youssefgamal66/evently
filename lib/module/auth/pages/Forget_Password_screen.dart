import 'package:evently/core/const/app_assets.dart';
import 'package:evently/core/maneger/app_provider.dart';
import 'package:evently/core/routes/app_route_name.dart';
import 'package:evently/module/auth/maneger/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
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
            AppLocalizations.of(context)!.forget_password,
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
                  child: Column(
                    children: [
                      Image.asset(AppAssets.forgetPass),
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
                            label: Text(AppLocalizations.of(context)!.email),
                            labelStyle: TextStyle(color: Color(0xff7B7B7B)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff7B7B7B)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(500, 60),
                              backgroundColor: theme.primaryColor,
                              padding: EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)))),
                          onPressed: () {
                            provider.resetPassword(context, provider.formKey); // ✅ صح
                          },

                          child: Text(
                            AppLocalizations.of(context)!.reset_password,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      )),
    );
  }
}
