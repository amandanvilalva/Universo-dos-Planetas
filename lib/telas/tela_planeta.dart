import 'package:flutter/material.dart';
import '../controle/controle_planeta.dart';
import '../modelo/planeta.dart';

class TelaPlaneta extends StatefulWidget {
  final bool isIncluir;
  final Planeta planeta;
  final Function() onFinalizado;

  const TelaPlaneta({
    super.key,
    required this.isIncluir,
    required this.planeta,
    required this.onFinalizado,
  });

  @override
  State<TelaPlaneta> createState() => _TelaPlanetaState();
}

class _TelaPlanetaState extends State<TelaPlaneta> {
  final _formKey = GlobalKey<FormState>();
  final ControlePlaneta _controlePlaneta = ControlePlaneta();

  late TextEditingController _nomeController;
  late TextEditingController _tamanhoController;
  late TextEditingController _distanciaController;
  late TextEditingController _apelidoController;
  late TextEditingController _descricaoController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.planeta.nome);
    _tamanhoController = TextEditingController(text: widget.planeta.tamanho.toString());
    _distanciaController = TextEditingController(text: widget.planeta.distancia.toString());
    _apelidoController = TextEditingController(text: widget.planeta.apelido ?? '');
    _descricaoController = TextEditingController(text: widget.planeta.descricao ?? '');
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _tamanhoController.dispose();
    _distanciaController.dispose();
    _apelidoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvarPlaneta() {
    if (_formKey.currentState!.validate()) {
      widget.planeta
        ..nome = _nomeController.text
        ..tamanho = double.parse(_tamanhoController.text)
        ..distancia = double.parse(_distanciaController.text)
        ..apelido = _apelidoController.text
        ..descricao = _descricaoController.text;

      if (widget.isIncluir) {
        _controlePlaneta.inserirPlaneta(widget.planeta);
      } else {
        _controlePlaneta.alterarPlaneta(widget.planeta);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Planeta ${widget.isIncluir ? 'adicionado' : 'atualizado'} com sucesso!',
          ),
          backgroundColor: Colors.green,
        ),
      );
      widget.onFinalizado();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isIncluir ? 'Adicionar Planeta' : 'Editar Planeta'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('Nome', _nomeController, 'Informe um nome válido (mínimo 3 caracteres)', minLength: 3),
                _buildTextField('Tamanho (km)', _tamanhoController, 'Informe um tamanho válido', isNumber: true),
                _buildTextField('Distância (km)', _distanciaController, 'Informe uma distância válida', isNumber: true),
                _buildTextField('Apelido', _apelidoController, null),
                _buildTextField('Descrição', _descricaoController, 'Adicione uma breve descrição sobre o planeta', maxLines: 3),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: _salvarPlaneta,
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String? validationMessage, {bool isNumber = false, int minLength = 0, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        validator: (value) {
          if (validationMessage != null && (value == null || value.isEmpty || value.length < minLength)) {
            return validationMessage;
          }
          return null;
        },
      ),
    );
  }
}
