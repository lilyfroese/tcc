import 'package:flutter/material.dart';
import 'package:tcc/screens/principal/components/body.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:tcc/service/meta.service.dart';
import 'puzzle_goal.dart'; // arquivo único do puzzle que vou te fornecer
import '../core/api/api.dart'; // se necessário

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final MetaService metaService = MetaService();
  List<dynamic> metas = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    carregarMetas();
  }

  Future<void> carregarMetas() async {
    final res = await metaService.getMetas();
    if (res.ok && res.data is List) {
      setState(() {
        metas = res.data;
        loading = false;
      });
    } else {
      setState(() => loading = false);
      // tratar erro possivelmente mostrando SnackBar
    }
  }

  // função chamada após criar meta (ao voltar da tela de cadastro)
  Future<void> refreshAfterCreate() async {
    await carregarMetas();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return PuzzleGoal(
      metas: metas, // passa a lista inteira (cada meta é Map)
      onPieceTap: (meta) {
        // aqui você recebe a meta inteira
        print('clicou na meta: ${meta['title']}');
        // por exemplo abrir detalhes
      },
    );
  }
}*/