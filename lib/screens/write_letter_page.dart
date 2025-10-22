import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../widgets/platform_indicator.dart';

class WriteLetterPage extends StatefulWidget {
  const WriteLetterPage({super.key});

  @override
  State<WriteLetterPage> createState() => _WriteLetterPageState();
}

class _WriteLetterPageState extends State<WriteLetterPage> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedTime = '6 meses';

  final List<String> _timeOptions = ['6 meses', '1 año', '2 años'];

  void _sendLetter() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> letter = {
        'content': _contentController.text,
        'email': _emailController.text,
        'deliveryDate': _selectedTime,
      };
      await DatabaseHelper().insertLetter(letter);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Carta enviada con éxito'),
          backgroundColor: Colors.green,
        ),
      );
      _formKey.currentState!.reset();
      _contentController.clear();
      _emailController.clear();
      setState(() {
        _selectedTime = '6 meses';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 1. Restauramos el título original
        title: const Text('Escribe tu Carta al Futuro'),

        backgroundColor: Colors.indigo.shade600,
        foregroundColor: Colors.white,
        elevation: 4,

        // 2. Usamos 'actions' para poner el widget a la derecha
        actions: const [
          Padding(
            // 3. Añadimos un poco de padding para que no quede pegado al borde
            padding: EdgeInsets.only(right: 12.0),
            child: PlatformIndicator(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Tu mensaje para el futuro',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  counterText: '${_contentController.text.length} / 500',
                ),
                maxLines: 8,
                maxLength: 500,
                onChanged: (text) => setState(() {}),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El contenido de la carta no puede estar vacío';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico de destino',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un correo electrónico';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Por favor, ingresa un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                value: _selectedTime,
                decoration: InputDecoration(
                  labelText: '¿Cuándo la recibirás?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _timeOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedTime = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Debes seleccionar una opción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: const Icon(Icons.send_rounded),
                label: const Text('Enviar Carta'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade500,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _sendLetter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
