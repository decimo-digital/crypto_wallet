import 'package:flutter/material.dart';

class CoinDetails extends StatefulWidget {
  const CoinDetails({required this.coinId, super.key});

  final String coinId;

  @override
  State<CoinDetails> createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coinId),
      ),
    );
  }
}
