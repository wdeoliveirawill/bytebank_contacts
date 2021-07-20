import 'package:bytebank_app/screens/contacts_list.dart';
import 'package:bytebank_app/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DashBoard")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/bytebank_logo.png"),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FeatureItem(
                  name: "Transfer",
                  icon: Icons.monetization_on,
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ContactsList()),
                    );
                  },
                ),
                _FeatureItem(
                  name: "Transaction Feed",
                  icon: Icons.description,
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => TransactionsList()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function? onClick;

  const _FeatureItem({
    Key? key,
    required this.name,
    required this.icon,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick!(),
          // onTap: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => ContactsList()),
          //   );
          // },
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
