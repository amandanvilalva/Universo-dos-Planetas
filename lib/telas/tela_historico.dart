import 'package:flutter/material.dart';
import '../controle/controle_planeta.dart';
import '../modelo/planeta.dart';

class TelaHistorico extends StatefulWidget {
  const TelaHistorico({super.key});

  @override
  State<TelaHistorico> createState() => _TelaHistoricoState();
}

class _TelaHistoricoState extends State<TelaHistorico> {
  final ControlePlaneta _controlePlaneta = ControlePlaneta();
  List<Planeta> _historicoPlanetas = [];

  @override
  void initState() {
    super.initState();
    _carregarHistorico();
  }

  Future<void> _carregarHistorico() async {
    final planetas = await _controlePlaneta.lerHistorico();
    setState(() {
      _historicoPlanetas = planetas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico Cósmico'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: _historicoPlanetas.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nenhum planeta registrado no histórico.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _historicoPlanetas.length,
              itemBuilder: (context, index) {
                final planeta = _historicoPlanetas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: const Icon(Icons.emoji_objects, color: Colors.amber),
                    title: Text(
                      planeta.nome,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Distância: ${planeta.distancia.toString()} km'),
                        if (planeta.descricao != null && planeta.descricao!.isNotEmpty)
                          Text('Descrição: ${planeta.descricao}',
                              style: TextStyle(color: Colors.grey.shade700)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
