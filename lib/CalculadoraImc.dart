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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Const.Hampton,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                  child: Column(
                children: [
                  _fields(context, _controllerPeso, "Em quilos", "Seu peso"),
                  _fields(context, _controllerAltura, "Em centímetros", "Sua altura"),
                  _button(context, "Calcular", () => Calculos.calculoImc(
                      _controllerAltura.value,
                      _controllerPeso.value,
                  _button(context, "limpar campos", _limparCampos)
                ],
              )),
            ],
          ),
        ));
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
              focusColor: Const.Expresso,
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
              backgroundColor: const WidgetStatePropertyAll(Const.Expresso),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)))),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _limparCampos(){
    setState(() {
      _controllerAltura.clear();
      _controllerPeso.clear();
    });
  }
}
