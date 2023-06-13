import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SobMedidaEtapa2Page extends StatefulWidget {
  const SobMedidaEtapa2Page({Key? key}) : super(key: key);

  @override
  State<SobMedidaEtapa2Page> createState() => _SobMedidaEtapa2PageState();
}

class _SobMedidaEtapa2PageState extends State<SobMedidaEtapa2Page> {
  List<File> _imagemSobMedida = [];

  Future _escolherImagens() async {
    final pickedFiles = await ImagePicker().pickMultiImage();

    setState(() {
      if (pickedFiles !=null){
        _imagemSobMedida = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
