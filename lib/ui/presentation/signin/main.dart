import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  String _email = '';
  String _password = '';
  String _email1 = '';
  String _name = '';
  String _telefono = '';
  String _password1 = '';
  String _primaria = '';
  String _ciudad = '';
  String _selectedLanguage = 'MX';
  bool _isLogin =
      true; // Variable para rastrear si está en el modo de inicio de sesión o registro

  List<String> listaIdioma = ['MX', 'USA'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/signin/bg1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 60.0,
            ),
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Image.asset('assets/signin/finallogo11.png'),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),

              // BOTÓN DESPLEGABLE DE IDIOMA
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 21.0),
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.language),
                      const SizedBox(width: 8.0),
                      DropdownButton<String>(
                        value: _selectedLanguage,
                        items: listaIdioma.map((String idioma) {
                          return DropdownMenuItem<String>(
                            value: idioma,
                            child: TextButton(
                                child: Text(idioma),
                                onPressed: () {
                                  final lang = idioma == "MX" ? "es" : "en";
                                  context
                                      .read<HomeCubit>()
                                      .changeLanguage(lang: lang);
                                }),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLanguage = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(
                height: 30.0,
              ),

              Container(
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Nunito',
                          fontSize: 21.0,
                        ),
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.signinWelcome,
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.signinAppTitle,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 15, 106, 180),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 30.0,
                    ),

                    // Fila de botones redondos para Iniciar Sesión / Registrarse
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isLogin
                                ? const Color.fromARGB(255, 15, 106, 180)
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            fixedSize: const Size(160.0, 50.0),
                            padding: EdgeInsets.zero,
                            side: const BorderSide(
                                color: Colors.white, width: 0.5), // Ajuste aquí
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.signinTapTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0, // Espacio ajustado entre los botones
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !_isLogin
                                ? const Color.fromARGB(255, 15, 106, 180)
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            fixedSize: const Size(160.0, 50.0),
                            padding: EdgeInsets.zero,
                            side: const BorderSide(
                                color: Colors.white, width: 0.5), // Ajuste aquí
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.signupTapTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 30.0,
                    ),

                    _isLogin ? _buildLoginForm() : _buildRegisterForm(),

                    const Divider(
                      height: 30.0,
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          // Lógica para manejar el botón de Iniciar Sesión / Registrarse
                          if (_isLogin) {
                            AutoRouter.of(context).navigate(const HomeRoute());
                            // Lógica para iniciar sesión
                            print('Iniciando sesión con $_email y $_password');
                          } else {
                            AutoRouter.of(context)
                                .navigate(const RecommendationsRoute());
                            // Lógica para registro
                            print('Registrando con $_email y $_password');
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 15, 106, 180),
                          padding: const EdgeInsets.all(13.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        child: Text(
                          _isLogin
                              ? AppLocalizations.of(context)!.signinTapTitle
                              : AppLocalizations.of(context)!.signupTapTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ),

                    const Divider(
                      height: 3.0,
                    ),

                    SizedBox(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.signinForgotPass,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildLoginForm() {
    return Column(
      children: <Widget>[
        TextField(
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.formEmail,
            labelText: AppLocalizations.of(context)!.formEmail,
            suffixIcon: const Icon(Icons.alternate_email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onSubmitted: (valor) {
            _email = valor;
            print('El nombre es $_email');
          },
        ),
        const SizedBox(
          height: 30.0,
        ),
        TextField(
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.formPassword,
            labelText: AppLocalizations.of(context)!.formPassword,
            suffixIcon: const Icon(Icons.lock_outline),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onSubmitted: (valor) {
            _password = valor;
            print('La contraseña es $_password');
            AutoRouter.of(context).navigate(const HomeRoute());
          },
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    // FORMULARIO PARA EL REGISTRO
    return Column(
      children: <Widget>[
        TextField(
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.formEmail,
            labelText: AppLocalizations.of(context)!.formEmail,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onSubmitted: (valor) {
            _email = valor;
            print('El nombre es $_email1');
            AutoRouter.of(context).navigate(const RecommendationsRoute());
          },
        ),
        const SizedBox(
          height: 30.0,
        ),
        TextField(
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.formName,
            labelText: AppLocalizations.of(context)!.formName,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onSubmitted: (valor) {
            _password = valor;
            print('Su nombre es es $_name');
          },
        ),
        TextField(
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.formPhone,
            labelText: AppLocalizations.of(context)!.formPhone,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onSubmitted: (valor) {
            _email = valor;
            print('El telefóno es $_telefono');
          },
        ),
        const SizedBox(
          height: 30.0,
        ),
        TextField(
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.formPassword,
            labelText: AppLocalizations.of(context)!.formPassword,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onSubmitted: (valor) {
            _email = valor;
            print('El nombre es $_password1');
          },
        ),
        const SizedBox(
          height: 30.0,
        ),
        TextField(
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.formSecureQuestion1,
            labelText: AppLocalizations.of(context)!.formSecureQuestion1,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onSubmitted: (valor) {
            _email = valor;
            print('El nombre es $_primaria');
          },
        ),
        const SizedBox(
          height: 30.0,
        ),
        TextField(
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.formSecureQuestion2,
            labelText: AppLocalizations.of(context)!.formSecureQuestion2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onSubmitted: (valor) {
            _email = valor;
            print('El nombre es $_ciudad');
          },
        ),
      ],
    );
  }
}
