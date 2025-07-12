import 'package:flutter/material.dart';

class WaterDataProvider with ChangeNotifier {
  double _totalAtual = 0;
  double _totalMeta = 2000;

  double get totalAtual => _totalAtual;
  double get totalMeta => _totalMeta;

  void atualizarTotal(double novoValor) {
    _totalAtual = novoValor;
    notifyListeners(); // avisa quem estiver ouvindo
  }

  void atualizarMeta(double novaMeta) {
    _totalMeta = novaMeta;
    notifyListeners(); // idem
  }
}
