import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TokenCard extends StatefulWidget {
  const TokenCard({
    required this.token,
    required this.onTap,
    this.last24h,
    this.trailing,
    super.key,
  });

  final Token token;
  final VoidCallback onTap;
  final num? last24h;
  final Widget? trailing;

  @override
  State<TokenCard> createState() => TokenCardState();
}

class TokenCardState extends State<TokenCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.token.name),
        subtitle: Text(
          NumberFormat.simpleCurrency().format(widget.token.currentPrice),
          style: widget.last24h != null
              ? TextStyle(
                  color: widget.last24h! > 0 ? Colors.green : Colors.red,
                )
              : null,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network(widget.token.image),
          ),
        ),
        trailing: widget.trailing,
        onTap: widget.onTap,
      ),
    );
  }
}
