import 'package:flutter/material.dart';
import '../modelo/planeta.dart';

class TelaDetalhes extends StatelessWidget {
  final Planeta planeta;

  const TelaDetalhes({super.key, required this.planeta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes de ${planeta.nome}'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.emoji_objects,
                size: 100,
                color: Colors.amber.shade700,
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoRow('Nome:', planeta.nome),
            _buildInfoRow('Tamanho (km):', planeta.tamanho.toString()),
            _buildInfoRow('Distância (km):', planeta.distancia.toString()),
            _buildInfoRow('Apelido:', planeta.apelido ?? 'N/A'),
            _buildInfoRow('Descrição:', planeta.descricao ?? 'Sem descrição disponível.'),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Voltar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
