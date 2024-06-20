import 'dart:io';

import 'package:bitcoin_price_view/api.dart';
import 'package:bitcoin_price_view/data_model.dart';
import 'package:flutter/material.dart';

class BitcoinPriceIndexScreen extends StatefulWidget {
  const BitcoinPriceIndexScreen({super.key});

  @override
  _BitcoinPriceIndexScreenState createState() =>
      _BitcoinPriceIndexScreenState();
}

class _BitcoinPriceIndexScreenState extends State<BitcoinPriceIndexScreen> {
  final _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1AE420),
        title: const Text('Bitcoin Price Index'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Alert!'),
                      content: const Text('Are you sure you want to Exit?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Add your logout logic here
                            Navigator.pop(context);
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            exit(0);
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  },
                );
              });
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1AE420),
        onPressed: () => _apiService,
        child: (const Icon(
          Icons.refresh,
          color: Color(0xFFFFFFFF),
        )),
      ),
      body: FutureBuilder<BitcoinPriceIndex>(
        future: _apiService.fetchBitcoinPriceIndex(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            BitcoinPriceIndex bpi = snapshot.data!;
            return Column(
              children: [
                Text('Updated: ${bpi.updatedTime}'),
                const SizedBox(height: 16),
                ...bpi.bpi.entries.map(
                  (entry) => ListTile(
                    title: Text('${entry.value['description']}'),
                    trailing: Text(
                      '${entry.value['rate']} ${entry.value['symbol']}',
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
