// Importações necessárias do Flutter e da biblioteca de fontes Google
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Classe Body que representa a tela principal com informações do usuário
class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    // Definição das cores que serão usadas na tela
    final themeBlue = const Color(0xFF1565C0);     // Azul principal
    final themeyellow = const Color(0xFFFFC107);   // Amarelo destaque
    final backgroundCard = const Color(0xFFF1F1F1); // Cor dos cartões

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Cor de fundo da tela
      body: SafeArea( // Garante que o conteúdo não fique sob barras do sistema
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Verifica se a tela está em modo paisagem (largura > 600)
            bool isLandscape = constraints.maxWidth > 600;

            // Torna a tela rolável em dispositivos pequenos
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight( // Ajusta o tamanho interno da coluna
                  child: Column(
                    children: [
                      // Linha superior com botão de voltar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: themeBlue),
                            onPressed: () {
                              Navigator.pop(context); // Volta para a tela anterior
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), // Espaçamento abaixo da linha

                      // Se estiver em modo paisagem, divide em duas colunas
                      isLandscape
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildProfileHeader(themeyellow),
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  child: _buildInfoAndUtilities(
                                    themeBlue,
                                    themeyellow,
                                    backgroundCard,
                                  ),
                                ),
                              ],
                            )
                          // Se for retrato, exibe empilhado
                          : Column(
                              children: [
                                _buildProfileHeader(themeyellow),
                                const SizedBox(height: 20),
                                _buildInfoAndUtilities(
                                  themeBlue,
                                  themeyellow,
                                  backgroundCard,
                                ),
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
    );
  }

  /// Constrói o cabeçalho com foto de perfil, nome e data de entrada
  Widget _buildProfileHeader(Color amarelo) {
    return Column(
      children: [
        // Avatar com borda amarela suave
        CircleAvatar(
          radius: 50,
          backgroundColor: amarelo.withOpacity(0.3),
          child: const CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage('assets/profile.jpg'), // Imagem do usuário
            backgroundColor: Colors.transparent,
          ),
        ),
        const SizedBox(height: 15),

        // Nome da pessoa
        Text(
          'Eduarda Heloisy Froese',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),

        // Data de entrada/registro
        Text(
          'Ativo desde - Jul, 2025',
          style: GoogleFonts.poppins(
            color: Colors.grey.shade700,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  /// Constrói a seção com Informações Pessoais e Utilidades
  Widget _buildInfoAndUtilities(
    Color azul, 
    Color amarelo, 
    Color fundo
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título da seção de informações
        Text(
          'Informações Pessoais',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),

        // Cartões com ícone + informação
        _buildInfoCard(
          Icons.person, 
          'User', 
          'Lily Froese', 
          azul, 
          fundo
        ),
        _buildInfoCard(
          Icons.email, 
          'Email', 
          'teste@teste.com', 
          azul, 
          fundo
        ),
        _buildInfoCard(
          Icons.groups_2, 
          'Grupo', 
          'A', 
          azul, 
          fundo
        ),

        const SizedBox(height: 20),

        // Título da seção de utilidades
        Text(
          'Utilidades',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),

        // Tiles clicáveis com ícones e setas
        _buildUtilityTile(
          Icons.bar_chart, 
          'Seu progresso', 
          azul, 
          fundo
        ),
        _buildUtilityTile(
          Icons.support_agent, 
          'Fale Conosco', 
          azul, 
          fundo
        ),
        _buildUtilityTile(
          Icons.logout, 
          'Log-Out', 
          Colors.redAccent, // Destaque vermelho para o log-out
          fundo
        ),
      ],
    );
  }

  /// Cria um cartão de informação (ícone + texto)
  Widget _buildInfoCard(
    IconData icon, 
    String label, 
    String value, 
    Color iconColor, 
    Color background
  ) {
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
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Cria um botão do tipo "tile" com ícone, título e uma setinha
  Widget _buildUtilityTile(
    IconData icon, 
    String title, 
    Color iconColor, 
    Color background
  ) {
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
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios, 
            color: Colors.grey,
            size: 14,
          ),
        ],
      ),
    );
  }
}
