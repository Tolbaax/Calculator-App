import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(calculator());
}

class calculator extends StatefulWidget {
  const calculator({Key? key}) : super(key: key);

  @override
  _calculatorState createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  List<String>buttons=[
    'C','Del','%','/',
    '9','8','7','*',
    '6','5','4','+',
    '3','2','1','-',
    '0','.','Ans','=',
  ];
  String input='';
  String output='';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            input,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              output,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                            ),
                          )),
                    ],
                  ),
                )),
            Expanded(
                flex: 5,
                child: Container(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ), itemBuilder: (context,index){

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          if(buttons[index]=='C'){
                            setState(() {
                              input='';
                              output='';
                            });
                          }
                          else if(buttons[index]=='Del'){
                            setState(() {
                              input=input.substring(0,input.length-1);
                            });
                          }
                          else if(buttons[index]=='=')
                          {
                            Expression exp=Parser().parse(input);
                            double result=exp.evaluate(EvaluationType.REAL,ContextModel());
                            setState(() {
                              output=result.toString();
                            });
                          }
                          else if(buttons[index]=='Ans') {
                            setState(() {
                              input = output;
                              output='';
                            });
                          }
                          else if(buttons[index]=='%'||buttons[index]=='/'||buttons[index]=='*'||
                              buttons[index]=='+'||buttons[index]=='-')
                          {
                            if(input.endsWith('%')||input.endsWith('*')||input.endsWith('/')||
                                input.endsWith('+')||input.endsWith('-'))
                            {
                              null;
                            }
                            else
                            {
                              setState(() {
                                input=input+buttons[index];
                              });
                            }
                          }
                          else
                          {
                            setState(() {
                              input=input+buttons[index];
                              print(input);
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: buttoncolor(buttons[index]),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text(buttons[index],
                              style: TextStyle(fontSize: 25,color: textcolor(buttons[index])))),
                        ),
                      ),
                    );
                  }),
                )),
          ],
        ),
      ),
    );
  }
  Color? buttoncolor(String c)
  {
    if(c=='C'){
      return Colors.green[700];
    }
    else if(c=='Del'){
      return Colors.red[700];
    }
    else if(c=='%'||c=='/'||c=='*'||c=='+'||c=='-'||c=='='){
      return Colors.blueAccent;
    }
    else{
      return Colors.grey[300];
    }
  }
  Color? textcolor(String t){
    if(t=='C'||t=='Del'||t=='%'||t=='/'||t=='*'||t=='+'||t=='-'||t=='='){
      return Colors.white;
    }
    else{
      return Colors.black;
    }
  }

}
