import 'package:flutter/material.dart';
import 'package:tcc/screens/p.edit/profile_edit.dart';
import 'package:tcc/screens/p.info/profile_info.dart';

// Widget que representa o menu inferior de perfil
class ProfileMenuBottomSheet extends StatelessWidget {
  const ProfileMenuBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Margem nas laterais e parte inferior do menu
      padding: const EdgeInsets.only(
        left: 12, 
        right: 12,
        bottom: 24
      ),
      child: Container(
        // Estilo do container do menu
        decoration: BoxDecoration(
          color: Colors.white70, // Fundo branco
          borderRadius: BorderRadius.circular(32), // Bordas bem arredondadas
        ),
        // Espaço interno do conteúdo do menu
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ocupa apenas o espaço necessário
          children: [
            // Pegador visual no topo do menu (linha cinza)
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 16), // Espaço abaixo do pegador

            // Título principal do menu
            const Text(
              'Configurações de Perfil',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16), // Espaço abaixo do título

            // Lista de opções do menu (sem rolagem, altura fixa)
            ListView.separated(
              // Faz com que ocupe só o espaço necessário
              shrinkWrap: true, 
              // Desativa rolagem
              physics: const NeverScrollableScrollPhysics(), 
              // Quantidade de itens na lista
              itemCount: 2, 
              // Espaço entre os itens
              separatorBuilder: (_, __) => const SizedBox(height: 12), 
              itemBuilder: (context, index) {
                // Lista com os dados dos botões do menu
                final items = [
                  {
                    'icon': Icons.edit, // Ícone do botão
                    'title': 'Editar Perfil', // Título do botão
                    'onTap': () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfileEdit(),
                      ));
                    },
                  },
                  {
                    'icon': Icons.info_outline,
                    'title': 'Informações do Perfil',
                    'onTap': () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfileInfo(),
                      ));
                    },
                  },
                ];

                // Retorno visual de cada item do menu
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100], // Fundo do item
                    borderRadius: BorderRadius.circular(16), // Bordas arredondadas
                  ),
                  child: ListTile(
                    leading: Icon(
                      items[index]['icon'] as IconData, // Ícone à esquerda
                      size: 32,
                      color: Colors.blue[200], // Cor do ícone
                    ),
                    title: Text(
                      items[index]['title'] as String, // Título do item
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: const Icon(Icons.chevron_right), // Ícone de seta à direita
                    onTap: items[index]['onTap'] as void Function(), // Ação ao tocar
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24), // Espaço inferior extra
          ],
        ),
      ),
    );
  }
}
