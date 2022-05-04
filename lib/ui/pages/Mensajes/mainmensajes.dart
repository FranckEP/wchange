import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mensajepriv.dart/menpriv.dart';

class Mensajes extends StatefulWidget {
  const Mensajes({Key? key}) : super(key: key);

  @override
  State<Mensajes> createState() => _Mensajes();
}

class _Mensajes extends State<Mensajes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.red.shade100,
        child: ListView.builder(
          itemCount: 9,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => {
                Get.to(() => const Priv())
              },
              child: Card(
                elevation: 1,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.red.shade300, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(8.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/147/147140.png'),
                    backgroundColor: Colors.blue,
                  ),
                  title: Text('Jorge coach'),
                  subtitle: Text(
                      'Hi men, how are you?'),
                ),]
                ),
              )
            );
          }
        )
      ),
    );
  }

}

/*Widget buildSearchBar() {
 final searchTextEditingController = TextEditingController();
 return Container(
   margin: const EdgeInsets.all(10),
   height: 20,
   child: Row(
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       const SizedBox(
         width: 10,
       ),
       const Icon(
         Icons.person_search,
         color: Colors.white,
         size: 24,
       ),
       const SizedBox(
         width: 5,
       ),
       Expanded(
         child: TextFormField(
           textInputAction: TextInputAction.search,
           controller: searchTextEditingController,
           onChanged: (value) {
             if (value.isNotEmpty) {
               buttonClearController.add(true);
               setState(() {
                 _textSearch = value;
               });
             } else {
               buttonClearController.add(false);
               setState(() {
                 _textSearch = "";
               });
             }
           },
           decoration: const InputDecoration.collapsed(
             hintText: 'Search here...',
             hintStyle: TextStyle(color: Colors.white),
           ),
         ),
       ),
       StreamBuilder(
           stream: buttonClearController.stream,
           builder: (context, snapshot) {
             return snapshot.data == true
                 ? GestureDetector(
                     onTap: () {
                       searchTextEditingController.clear();
                       buttonClearController.add(false);
                       setState(() {
                         _textSearch = '';
                       });
                     },
                     child: const Icon(
                       Icons.clear_rounded,
                       color: AppColors.greyColor,
                       size: 20,
                     ),
                   )
                 : const SizedBox.shrink();
           })
     ],
   ),
   decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(30),
     color: Colors.red.shade300,
   ),
 );
}*/
