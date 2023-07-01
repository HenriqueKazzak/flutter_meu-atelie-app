import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

import '../../../models/Servico.dart';

class AjusteEtapa4Page extends StatefulWidget {
  final Servico servico;

  const AjusteEtapa4Page({Key? key, required this.servico}) : super(key: key);

  @override
  _AjusteEtapa4PageState createState() => _AjusteEtapa4PageState();
}

class _AjusteEtapa4PageState extends State<AjusteEtapa4Page> {
  late DateTime _selectedDate;
  final FirebaseService _fireBaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.servico.dataEntrega;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.servico.dataEntrega = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etapa 4/4 - Selecionar Data de Entrega'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Data da Entrega',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Selecione a data da entrega',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.calendar_today,textDirection: TextDirection.rtl),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Voltar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      log(widget.servico.toString());
                      _fireBaseService.save('pedidos', widget.servico);
                      Navigator.pushNamed(context, '/home');

                    },
                    child: const Text('Finalizar Pedido'),
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
