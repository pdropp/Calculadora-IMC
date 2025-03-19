import "package:flutter/material.dart";


class Tratamentstate {
  getClassificacaoIMC<String>(double imc) {
    if (imc <= 18.5) {
      return 'Abaixo do peso';
    } else if (imc > 18.5 && imc <= 24.9) {
      return 'Peso normal';
    } else if (imc > 25.0 && imc < 29.9) {
      return 'Sobrepeso';
    } else if (imc >= 30.0 && imc < 34.9) {
      return 'Obesidade grau I';
    } else if (imc >= 35.0 && imc < 39.9) {
      return 'Obesidade grau II';
    } else {
      return 'Obesidade grau III';
    }
  }

  getColorImc<Color>(double imc) {
    if (imc <= 18.5) {
      return Colors.blue;
    } else if (imc > 18.5 && imc <= 24.9) {
      return Colors.green;
    } else if (imc > 25.0 && imc < 29.9) {
      return Colors.amber[400];
    } else if (imc >= 30.0 && imc < 34.9) {
      return Colors.amber[700];
    } else if (imc >= 35.0 && imc < 39.9) {
      return Colors.red[400];
    } else {
      return Colors.red[700];
    }
  }
}
