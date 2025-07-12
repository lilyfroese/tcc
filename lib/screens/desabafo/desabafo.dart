import 'package:flutter/material.dart';

class DesabafoScreen extends StatefulWidget {
  const DesabafoScreen({super.key});

  @override
  State<DesabafoScreen> createState() => _DesabafoScreenState();
}

class _DesabafoScreenState extends State<DesabafoScreen> {
  final List<String> _desabafos = [];
  final TextEditingController _controller = TextEditingController();

  void _enviarDesabafo() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _desabafos.add(texto);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color fundo = const Color(0xFFDCDCDC);       // cinza claro
    final Color blocoBege = const Color(0xFFD6C385);   // bege claro
    final Color inputFundo = const Color(0xFFF1F1F1);  // branco fosco

    return Scaffold(
      backgroundColor: fundo,
      body: SafeArea(
        child: Column(
          children: [
            // Lista de desabafos
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _desabafos.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: blocoBege,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _desabafos[index],
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  );
                },
              ),
            ),
            // Campo de digitar o desabafo
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: inputFundo,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Escreva seu desabafo aqui...',
                      ),
                      onSubmitted: (_) => _enviarDesabafo(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blueAccent),
                    onPressed: _enviarDesabafo,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
