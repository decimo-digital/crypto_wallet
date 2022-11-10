import 'package:crypto_wallet/model/purchase.dart';
import 'package:crypto_wallet/utils/extensions.dart';
import 'package:flutter/material.dart';

class PurchasesList extends StatefulWidget {
  const PurchasesList({super.key});

  @override
  State<PurchasesList> createState() => _PurchasesListState();
}

class _PurchasesListState extends State<PurchasesList> {
  final _purchases = ValueNotifier<List<Purchase>>([]);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Purchase>>(
      valueListenable: _purchases,
      builder: (context, value, child) {
        if (value.isEmpty) return child!;
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) => const Card(),
        );
      },
      child: Center(
        child: Text(context.localizations.txtNoPurchasesYet),
      ),
    );
  }
}
