import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;

  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'London', 'Berlin', 'Rome'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Who painted the Mona Lisa?',
      'options': [
        'Leonardo da Vinci',
        'Pablo Picasso',
        'Vincent van Gogh',
        'Michelangelo'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'What is the largest planet in our solar system?',
      'options': ['Jupiter', 'Saturn', 'Mars', 'Earth'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Who is Rambabu?',
      'options': ['Playboy', 'Singer', 'Dancer', 'Player'],
      'correctAnswerIndex': 3,
    },
  ];

  void checkAnswer(int selectedIndex) {
    if (selectedIndex ==
        questions[currentQuestionIndex]['correctAnswerIndex']) {
      setState(() {
        score++;
      });
    }

    goToNextQuestion();
  }

  void goToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        showResultDialog();
      }
    });
  }

  void showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Text('Your score: $score out of ${questions.length}'),
          actions: [
            TextButton(
              child: Text('Restart Quiz'),
              onPressed: () {
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  questions[currentQuestionIndex]['question'],
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              SizedBox(
                height: 40.0,
                width: double.infinity,
              ),
              ...List.generate(
                questions[currentQuestionIndex]['options'].length,
                (index) => Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => checkAnswer(index),
                      child: Text(
                          questions[currentQuestionIndex]['options'][index]),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
