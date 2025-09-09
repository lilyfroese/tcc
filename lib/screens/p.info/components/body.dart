import 'package:flutter/material.dart';
import 'package:tcc/screens/login/components/background.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    // Cores principais atualizadas
    final themeBlue = const Color.fromARGB(255, 155, 198, 248); // Azul suave
    final themeyellow = const Color(0xFFFFC107);                 // Amarelo destaque
    final backgroundCard = Colors.white.withOpacity(0.0);        // Transparente

    return Scaffold(
      body: Background(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isLandscape = constraints.maxWidth > 600;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // Botão de voltar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: themeBlue),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Layout responsivo
                        isLandscape
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _buildProfileHeader(themeyellow)),
                                  const SizedBox(width: 30),
                                  Expanded(
                                    child: _buildInfoAndUtilities(
                                        themeBlue, themeyellow, backgroundCard),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  _buildProfileHeader(themeyellow),
                                  const SizedBox(height: 20),
                                  _buildInfoAndUtilities(
                                      themeBlue, themeyellow, backgroundCard),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Cabeçalho com avatar e nome
  Widget _buildProfileHeader(Color amarelo) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: amarelo.withOpacity(0.3),
          child: const CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage('assets/profile.jpg'),
            backgroundColor: Colors.transparent,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'EDUARDA HELOISY FROESE',
          style: TextStyle(
            color: Colors.blue[200],
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Ativo desde - Jul, 2025',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // Seção com Informações e Utilidades
  Widget _buildInfoAndUtilities(Color azul, Color amarelo, Color fundo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informações Pessoais',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        _buildInfoCard(Icons.person, 'User', 'Lily Froese', azul, fundo),
        _buildInfoCard(Icons.email, 'Email', 'teste@teste.com', azul, fundo),
        _buildInfoCard(Icons.groups_2, 'Grupo', 'A', azul, fundo),
        const SizedBox(height: 20),
        Text(
          'Utilidades',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        _buildUtilityTile(Icons.bar_chart, 'Seu progresso', azul, fundo),
        _buildUtilityTile(Icons.support_agent, 'Fale Conosco', azul, fundo),
        _buildUtilityTile(Icons.logout, 'Log-Out', Colors.redAccent, fundo),
      ],
    );
  }

  // Cartão de informação
  Widget _buildInfoCard(
      IconData icon, String label, String value, Color iconColor, Color background) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tile de utilidade com seta
  Widget _buildUtilityTile(IconData icon, String title, Color iconColor, Color background) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios, // seta
            color: Colors.grey,
            size: 14,
          ),
        ],
      ),
    );
  }
}
