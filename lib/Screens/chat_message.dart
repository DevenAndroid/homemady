import 'package:flutter/material.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';




class ChatMessageScreen extends StatefulWidget {
  const ChatMessageScreen({Key? key}) : super(key: key);
  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 1.7,
        shadowColor: Colors.grey.shade300,
        titleSpacing: 30,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
        ),
        leadingWidth: AddSize.size40 * 0.9,
        title: const Text( 'Chat',
          style:TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: Color(0xFF1A2E33)
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/Chat.png'),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration:  BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF37C666).withOpacity(0.10),
                            offset: const Offset(.1, .1,
                            ),
                            blurRadius: 20.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/add-square.png',height: 28,),
                        Image.asset('assets/images/camera1.png',height: 28,),
                        SizedBox(
                          width: 210,
                          child: CommonTextFieldWidgetSearch1(

                            hint: 'Type messages...',
                            suffix: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Image.asset('assets/images/PaperPlaneRight.png',height: 10,),
                            ),
                          ),
                        ),
                        Image.asset('assets/images/Group 1727.png',height: 48,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
