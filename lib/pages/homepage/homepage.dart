import 'package:crypto_wallet/main.dart';
import 'package:crypto_wallet/pages/homepage/tabs/swap_tokens.dart';
import 'package:crypto_wallet/pages/homepage/tabs/token_list.dart';
import 'package:crypto_wallet/service/data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);
  DataService service = DataService();
  var tokensBox;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ciao ${FirebaseAuth.instance.currentUser!.email}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: GestureDetector(
              onTap: () => context.pushNamed(Routes.settings.name),
              child: const CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: TabBar(
        enableFeedback: true,
        automaticIndicatorColorAdjustment: true,
        controller: _tabController,
        tabs: const [
          Tab(icon: Icon(FontAwesomeIcons.coins), text: 'Homepage'),
          Tab(icon: Icon(FontAwesomeIcons.arrowRightArrowLeft), text: 'Swap'),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: TabBarView(
          controller: _tabController,
          children: const [
            TokenList(),
            SwapTokens(),
          ],
        ),
      ),
    );
  }
}
