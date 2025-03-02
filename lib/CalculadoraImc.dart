import 'package:flutter/material.dart';
import 'package:imc_flutter_app/Utils/Const.dart';

import 'Calculos.dart';

class CalculadoraImc extends StatefulWidget {
  const CalculadoraImc({super.key});

  @override
  State<CalculadoraImc> createState() => _CalculadoraImcState();
}

class _CalculadoraImcState extends State<CalculadoraImc> {
  final TextEditingController _controllerAltura = TextEditingController();
  final TextEditingController _controllerPeso = TextEditingController();
  String resultado = '';
  String classificacao = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: Const.hampton,
        appBar: AppBar(
          backgroundColor: Const.expresso,
          title: const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                    "Calculadora IMC",
                  style: TextStyle(
                    color: Const.hampton
                  ),
                ),
              )),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Const.expresso,
                    height: 200
                  )
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                            color: Const.birchWhite,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Seus dados",
                                      style: TextStyle(
                                          fontSize: 25, color: Const.expresso),
                                    ),
                                    const SizedBox(height: 30.0),
                                    _fields(context, _controllerPeso,
                                        "Em quilos", "Seu peso"),
                                    _fields(context, _controllerAltura,
                                        "Em metros", "Sua altura"),
                                    _button(context, "Calcular", _calcular),
                                    _button(
                                        context, "limpar campos", _limparCampos)
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    child: Card(
                      elevation: 3,
                      color: _classificadorCores(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 30.0),
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Resultado",
                                  style: TextStyle(
                                      fontSize: 20.0, color: Const.hampton),
                                ),
                                Text(
                                  classificacao,
                                  style: const TextStyle(
                                      fontSize: 25.0, color: Const.hampton),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              children: [
                                Text(
                                  resultado,
                                  style: const TextStyle(
                                      fontSize: 35.0, color: Const.hampton),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Color _classificadorCores() {
    double? imc = double.tryParse(resultado);
    if (imc == null) return Const.birchWhite;
    if (imc < 18.5) return Const.magreza;
    if (imc < 24.9) return Const.ideal;
    if (imc < 29.9) return Const.sobrepeso;
    if (imc < 39.9) return Const.sobrepesoI;
    if (imc >= 40.0) return Const.obeso;
    return Const.birchWhite;
  }

  void _calcular() {
    setState(() {
      resultado =
          Calculos.calculoImc(_controllerAltura.text, _controllerPeso.text)
              .toStringAsFixed(1);
    });
    double? imc = double.tryParse(resultado);
    if (imc != null) {
      if (imc < 18.5) {
        classificacao = "Abaixo do peso";
      } else if (imc < 24.9) {
        classificacao = "Peso ideal";
      } else if (imc < 29.9) {
        classificacao = "Sobrepeso I";
      } else if (imc < 39.9) {
        classificacao = "Obesidade II";
      } else if (imc >= 40.0) {
        classificacao = "Obesidade Grave III";
      }
    }
  }

  Widget _fields(BuildContext context, TextEditingController controller,
      String hintText, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Const.expresso),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7.0),
          TextField(
            controller: controller,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(0, 0, 0, 0.5)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Const.expresso)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Const.expresso)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Const.expressoAlpha50,
                  )),
              focusColor: Const.expresso,
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(BuildContext context, String title, VoidCallback function) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: function,
          style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Const.expresso),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)))),
          child: Text(
            title,
            style: const TextStyle(color: Const.birchWhite),
          ),
        ),
      ),
    );
  }

  void _limparCampos() {
    setState(() {
      _controllerAltura.clear();
      _controllerPeso.clear();
      resultado = '';
      classificacao = '';
    });
  }
}
