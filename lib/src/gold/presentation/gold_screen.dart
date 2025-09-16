import 'package:flutter/material.dart';
import 'package:gold_stream_app/src/gold/data/fake_gold_api.dart';
import 'package:gold_stream_app/src/gold/presentation/widgets/gold_header.dart';

class GoldScreen extends StatelessWidget {
  
  const GoldScreen({super.key});
  @override
  Widget build(BuildContext context) {
    
    /// Platzhalter für den Goldpreis
    /// soll durch den Stream `getGoldPriceStream()` ersetzt werden
    double goldPrice = 69.22;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoldHeader(),
              SizedBox(height: 20),
              Text(
                'Live Kurs:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: getGoldPriceStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    goldPrice = snapshot.data!;
                  }
                  return Text(
                    goldPrice.toStringAsFixed(2) + ' €',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
