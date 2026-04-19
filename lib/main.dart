import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MyApp());
}

class MessageBoxClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double tipHeight = 10.0;
    
    // Draw the main rectangle body
    path.addRRect(RRect.fromLTRBR(0, 0, size.width, size.height - tipHeight, Radius.circular(12)));
    
    // Draw the triangular tail at the bottom
    path.moveTo((3*size.width)/4 + 10, size.height - tipHeight);
    path.lineTo((3*size.width)/4 + 20, size.height);
    path.lineTo((3*size.width)/4 + 30, size.height - tipHeight);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // Yusuf will we only have one page?
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commission Compass',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  double returnFontSize(){
    if (kIsWeb){
      return 22;
    } else {
      return 18;
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Commission Compass",
                style: TextStyle(
                  fontSize: returnFontSize(), 
                  fontWeight: FontWeight(800)),
            ),
            Transform.translate(
              offset: const Offset(1.0, 0.0),
              child: const Text("AI-powered commission decision assistant", style: TextStyle(fontSize: 10),),
            )
            // Text(
            //   "AI-powered commission decision assistant",
            //   style: TextStyle(fontSize: 12),
            // )
          ],
        ),
        leading: Center(
          child: Transform.translate(
            offset: const Offset(10.0, 0.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[400],
              ),
              
              
            ),
          )
        ),

        actions: [
          Transform.translate(
            offset: Offset(-17, 0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[400]
                ),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New chat", style: TextStyle(fontSize: 12)),
                    Transform.translate(
                      offset: Offset(5, 0),
                      child: SvgPicture.asset(
                        'assets/message-plus.svg',
                        width: 30,
                        height: 30,
                        semanticsLabel: 'New Chat',
                      )
                    )
                  ] 
                )
              )
            )
          )
        ],

        elevation: 10,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
      ),

      // AI response body (convert to widget class later)
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // user's prompt
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 40),
              child: Align(
                alignment: Alignment.centerRight,
                child: ClipPath(
                  clipper: MessageBoxClipper(),
                  child: Container(
                    width: 180,
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
                    color: Colors.blue,
                    child: Text("Question 1 dadxasdasddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"),
                  ),
                )
              ),
            ),
            
            // AI response
            Padding(
              padding: EdgeInsets.only(left: 10, top: 60),
              child: Text("Final Decision: Decision B! 🔥", style: TextStyle(fontSize: 24, fontWeight: FontWeight(800)),)
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, top: 40),
              child: Text("Key Reasoning 💻", style: TextStyle(fontSize: 20, fontWeight: FontWeight(600)),)
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text("bla bla bla bla bla", style: TextStyle(fontSize: 16))
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, top: 40),
              child: Text("Pros and Cons 🥶", style: TextStyle(fontSize: 20, fontWeight: FontWeight(600)),)
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Table(
                defaultColumnWidth: FixedColumnWidth(150), 
                // columnWidths: const {
                //   0: FlexColumnWidth(1),
                //   1: FlexColumnWidth(1),
                // },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle, 
                border: TableBorder.all(color: Colors.black, width: 1),
                children: [
                  TableRow(
                    children: [
                      Center(child: Text("Pros")),
                      Center(child: Text("Cons"))
                    ]
                  ),

                  TableRow(
                    children: [
                      Center(child: Text("bla bla bla")),
                      Center(child: Text("bla bla bla"))
                    ]
                  ),
                ],
              )
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, top: 40),
              child: Text("Quantifiable Impacts on You 🫵", style: TextStyle(fontSize: 20, fontWeight: FontWeight(600)),)
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text("bla bla bla bla bla", style: TextStyle(fontSize: 16))
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, top: 40),
              child: Text("Suggestions 🤑", style: TextStyle(fontSize: 20, fontWeight: FontWeight(600)),)
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text("bla bla bla bla bla", style: TextStyle(fontSize: 16))
            ),
          ],
        ),
      )
    );
  }
}
