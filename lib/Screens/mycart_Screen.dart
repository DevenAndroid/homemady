import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:homemady/widgets/custome_textfiled.dart';


class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: 'My Cart', context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                 return Slidable(
                   startActionPane: ActionPane(
                     motion: ScrollMotion(),
                     children: [
                       SlidableAction(
                           onPressed: (context) {},
                         backgroundColor: Colors.red,
                         icon: Icons.delete_outline_outlined,
                         label: 'Delete',
                       )
                     ],
                   ),
                     child: Column(
                       children: [
                         Text('data'),
                         Text('data')
                       ],
                     )
                 );
              },
            )
          ],
        ),
      ),
    );
  }
}
