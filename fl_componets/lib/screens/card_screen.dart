import 'package:fl_componets/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
   
  const CardScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Widget'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: const [

          CustomCardType1(),
          SizedBox(height: 10,),
          CustomCardType2(imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',),
          SizedBox(height: 20,),
          CustomCardType2(imageUrl: 'https://mymodernmet.com/wp/wp-content/uploads/2022/02/international-landscape-photographer-awards-20.jpeg',),
          SizedBox(height: 20,),
          CustomCardType2(name: 'Un hermoso paisaje', imageUrl: 'http://cdn.eso.org/images/screen/millour-01-cc.jpg',),
          SizedBox(height: 100,),

        ],
      )
    );
  }
}
