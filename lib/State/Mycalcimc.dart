// ignore: file_names
import 'package:calc_imc/Tratament/TratamentState.dart';
import 'package:flutter/material.dart';

class Mycalcimc extends StatefulWidget {
  const Mycalcimc({super.key});

  @override
  State<Mycalcimc> createState() => _MycalcimcState();
}

class _MycalcimcState extends State<Mycalcimc> {
  late TextEditingController pesoController;
  late TextEditingController alturaController;
  double valorPeso = 50.0;
  double valorAltura = 0.5; // Valor inicial ajustado
  Tratamentstate tratament = Tratamentstate();

  double imc = 0;
  String classificacao = '';
  late Color corResultado;

  @override
  void initState() {
    pesoController = TextEditingController(text: valorPeso.toString());
    alturaController = TextEditingController(text: valorAltura.toStringAsFixed(2)); // Ajuste na precisão
    super.initState();
  }

  @override
  void dispose() {
    pesoController.dispose();
    alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imc == 0
                ? Text(
                    'Adicione valores de peso e altura para calcular IMC',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                : Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 10,
                        color: tratament.getColorImc(imc),
                      ),
                      borderRadius: BorderRadius.circular(150),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          imc.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 42,
                            color: tratament.getColorImc(imc),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          tratament.getClassificacaoIMC(imc),
                          style: TextStyle(
                            fontSize: 25,
                            color: tratament.getColorImc(imc),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Seu Peso',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          enabled: false,
                          controller: pesoController,
                          decoration: InputDecoration(
                            suffixText: 'KG',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          activeTickMarkColor: Colors.purple,
                          trackHeight: 1.5,
                        ),
                        child: Slider(
                          activeColor: Colors.purple,
                          value: valorPeso,
                          onChanged: (peso) {
                            setState(() {
                              valorPeso = peso;
                              pesoController.text = valorPeso.toStringAsFixed(2);
                            });
                          },
                          min: 50,
                          max: 200,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Sua Altura',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          enabled: false,
                          controller: alturaController,
                          decoration: InputDecoration(
                            suffixText: 'M',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          activeTickMarkColor: Colors.purple,
                          trackHeight: 1.5,
                        ),
                        child: Slider(
                          min: 0.5,
                          max: 2.00,
                          activeColor: Colors.purple,
                          value: valorAltura,
                          onChanged: (altura) {
                            setState(() {
                              valorAltura = altura;
                              alturaController.text = valorAltura.toStringAsFixed(2); // Ajuste na precisão
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 22),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(150, 50),
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                try {
                  double peso = double.parse(pesoController.text);
                  double altura = double.parse(alturaController.text);
                  setState(() {
                    imc = peso / (altura * altura);
                    classificacao = tratament.getClassificacaoIMC(imc);
                    corResultado = tratament.getColorImc(imc);
                  });
                } on Exception {
                  setState(() {
                    imc = 0;
                    pesoController.text = '';
                    alturaController.text = '';
                    classificacao = '';
                    corResultado = Colors.transparent;
                  });
                }
              },
              child: Text('Calcular', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
