import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:flutter/material.dart';

class TokenCard extends StatefulWidget {
  const TokenCard({
    required this.token,
    required this.onTap,
    this.trailing,
    super.key,
  });

  final Token token;
  final VoidCallback onTap;

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
        subtitle: Text(widget.token.currentPrice.toString()),
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
