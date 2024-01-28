import 'package:calculator_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion='';
  var userAnswer='';
  final List<String> buttons=[
    'C','DEL','%','/',
    '9','8','7','x',
    '6','5','4','-',
    '3','2','1','+',
    '0','.','Ans','=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _CustomClipper(),
          child: Container(
            color: Colors.grey[900],
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  width: 250,
                    image: AssetImage(
                        'lib/logo.png',
                    )
                )
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 30,),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                    child: Text(
                        userQuestion,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                    child: Text(
                        userAnswer,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  alignment: Alignment.centerRight,
                ),
              ],
            ),
          ),
          ),
          Expanded(
            flex: 2,
              child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
              itemBuilder: (BuildContext context,int index){
                if(index==0){
                  return MyButton(
                    ButtonTapped: (){
                      setState(() {
                        userQuestion='';

                      });
                    },
                    doubleTap: (){
                      setState(() {
                        userQuestion='';
                        userAnswer='';
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.grey[800],
                    textColor: Colors.white,
                  );
                }
                else if(index==1){
                  return MyButton(
                    ButtonTapped: (){
                      setState(() {
                        userQuestion=userQuestion.substring(0,userQuestion.length-1);
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.grey[800],
                    textColor: Colors.white,
                  );
                }
                else if(index==buttons.length-1){
                  return MyButton(
                    ButtonTapped: (){
                      setState(() {
                        equalOnpressed();
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.orange,
                    textColor: Colors.white,
                  );
                }
                else if(index==buttons.length-2){
                  return MyButton(
                    ButtonTapped: (){
                      setState(() {
                        if(userAnswer==''){
                          userQuestion='Error - UserAnswer is empty';
                        }
                        else{
                          userQuestion+='Ans';
                        }
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.orange,
                    textColor: Colors.white,
                  );
                }
                else{
                  return MyButton(
                    ButtonTapped: (){
                      setState(() {
                        userQuestion+=buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index])?Colors.orange:Colors.grey[200],
                    textColor: isOperator(buttons[index])?Colors.white:Colors.black,
                  );
                }
                  }
                  ),
                ),
        ],
              ),
          );

  }
  bool isOperator(String s){
    if(s=='%'||s=='/'||s=='+'||s=='='||s=='x'||s=='-')
      {return true;}
    return false;
  }
  void equalOnpressed(){
    String finalQuestion=userQuestion;
    finalQuestion=finalQuestion.replaceAll('x','*');
    finalQuestion=finalQuestion.replaceAll('Ans',userAnswer);
    Parser p=Parser();
    Expression exp=p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer=eval.toString();

  }
}
class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();

    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
