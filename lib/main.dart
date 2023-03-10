import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

final imageCarouselController = PageController(initialPage: 1000, viewportFraction: 0.7);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HA Dollhouse',
      debugShowCheckedModeBanner: false,
    
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: Typography.whiteRedmond.copyWith(
          headlineLarge: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 32.0,
          )
        ),
      ),
      home:  Scaffold(body: CallbackShortcuts(
        bindings: {
                    const SingleActivator(LogicalKeyboardKey.arrowLeft): () {
               imageCarouselController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
          },
         const SingleActivator(LogicalKeyboardKey.arrowRight): () {
           imageCarouselController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
          },
        },
        child: const Focus(
          autofocus: true,
          child: MyHomePage(title: 'HA Dollhouse')))),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  
  @override
  Widget build(BuildContext context) {
    
    //https://wallpaperaccess.com/full/2637581.jpg
    List<String> images = [
    "assets/images/Red_rectangle.svg.png",
    "assets/images/floorplan.png",
    "assets/images/Red_rectangle.svg.png",
  ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
                 Flexible(child: Text("HA Dollhouse", style: Theme.of(context).textTheme.headlineLarge)),
                Flexible(child: Text("4:30pm", style: Theme.of(context).textTheme.headlineLarge))
          ],

        ),
        Flexible(
          child: SizedBox(
            height: 300,
           
            child: PageView.builder(
              controller: imageCarouselController,
              padEnds: true,         
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) 
              {  
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: SizedBox(
                  width: 100,
                  //color: index%2 == 0 ? Colors.purple: Colors.yellow,
                  //child: Image.network(images[index%3], fit: BoxFit.cover,),
                  child: Image.asset(images[index%3], fit: BoxFit.cover,),
                 ),
               );
              },
                
            ),
          ),
        ) 

        /*
        Flexible(
          child: SizedBox(
            height: 300,
            child: PageView.builder(
              controller: imageCarouselController,
              padEnds: true,         
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) 
              {  
               return ColoredBox(
                color: index%2 == 0 ? Colors.purple: Colors.yellow,
                 child: SizedBox(
                  //height: 300,
                  width: 100,
                  
                           child: Text('${index % 3}', style: Theme.of(context).textTheme.headlineLarge, textAlign: index%3 == 1 ? TextAlign.left: TextAlign.right),
                         ),
               );
              },
                
            ),
          ),
        ) 
        */       
      ],
    );
  }


}

