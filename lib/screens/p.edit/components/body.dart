import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBlue = const Color(0xFF1565C0);
    final themeYellow = const Color(0xFFFFC107);
    final backgroundCard = const Color(0xFFF1F1F1);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Topo com botão de voltar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: themeBlue),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Avatar com ícone de edição
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: themeYellow.withOpacity(0.3),
                    child: const CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeBlue,
                    ),
                    child: const Icon(Icons.edit, color: Colors.white, size: 18),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Campos de edição
              _buildInputField("Primeiro Nome", "Eduarda Heloisy", backgroundCard),
              _buildInputField("Último Nome", "Froese", backgroundCard),
              _buildInputField("Email", "teste@teste.com", backgroundCard),
              _buildInputField("Grupo", "A", backgroundCard),

              const SizedBox(height: 30),

              // Botão Salvar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // ação de salvar
                  },
                  child: Text(
                    'Salvar',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Botão Alterar Senha
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: themeBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // ação de alterar senha
                  },
                  child: Text(
                    'Alterar Senha',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: themeBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Campo customizado de input com fundo em bolha (estilo info)
  Widget _buildInputField(String label, String value, Color backgroundColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          "$label*",
          style: GoogleFonts.poppins(
            color: Colors.grey.shade700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
