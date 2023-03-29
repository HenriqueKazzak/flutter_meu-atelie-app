import 'package:flutter/material.dart';

class NewJobPage extends StatelessWidget {
  const NewJobPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return two option of new job "Ajuste" or "Novo" in  big square buttons left and right on click navigate to ajuste or novo page

    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Pedido"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            height: 10,
          ),
          Row(children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ajuste');
                },
                child: const Text("Ajuste"),
              ),
            )
          ]),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/novo');
                  },
                  child: const Text("Novo"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
