import 'package:flutter/material.dart';

class MainServicoPage extends StatelessWidget {
  const MainServicoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Pedido"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "Qual será o tipo do serviço?",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              )
            ]),
        const SizedBox(
          height: 30,
        ),
        Row(children: <Widget>[
          Expanded(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ajuste1');
                    },
                    icon: Icon(Icons.cut),
                    label: Text("Ajuste"),
                  ))),
          const SizedBox(
            height: 10,
          ),
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Ajuste - para roupas que precisam de pequenos ajustes",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sobmedida1');
                      },
                      icon: Icon(Icons.style),
                      label: Text("Novo"),
                    ))),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Novo - para roupas personalizadas sob medida",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}
