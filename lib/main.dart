import 'package:flutter/material.dart';

// A class to represent a quiz question with a question, four options and an answer
class Question {
  final String question;
  final List<String> options;
  final int answer;

  Question(this.question, this.options, this.answer);
}

// A list of 8 questions for the quiz app
List<Question> questions = [
  Question(
    'What is the capital of India?',
    ['New Delhi', 'Mumbai', 'Kolkata', 'Chennai'],
    0,
  ),
  Question(
    'What is the largest animal in the world?',
    ['Elephant', 'Whale', 'Giraffe', 'Dinosaur'],
    1,
  ),
  Question(
    'Who is the author of Harry Potter series?',
    ['J.R.R. Tolkien', 'George R.R. Martin', 'J.K. Rowling', 'Stephen King'],
    2,
  ),
  Question(
    'Which planet is the closest to the sun?',
    ['Mercury', 'Venus', 'Earth', 'Mars'],
    0,
  ),
  Question(
    'Which sport is played with a black and white ball?',
    ['Basketball', 'Cricket', 'Soccer', 'Tennis'],
    2,
  ),
  Question(
    'Which country is the largest in terms of area?',
    ['China', 'Russia', 'USA', 'Canada'],
    1,
  ),
  Question(
    'Which musical instrument has 88 keys?',
    ['Piano', 'Guitar', 'Violin', 'Flute'],
    0,
  ),
  Question(
    'Which superhero is also known as the Caped Crusader?',
    ['Superman', 'Spiderman', 'Batman', 'Ironman'],
    2,
  ),
];

// A stateful widget to display the quiz app
class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

// A state class to handle the logic and UI of the quiz app
class _QuizAppState extends State<QuizApp> {
  // A variable to keep track of the current question index
  int currentQuestion = 0;

  // A variable to keep track of the score
  int score = 0;

  // A variable to store the user's selected answer
  int? selectedAnswer;

  // A method to check if the user selected the correct answer
  void checkAnswer(int index) {
    // Update the selected answer
    selectedAnswer = index;
    // If the answer is correct, increment the score
    if (index == questions[currentQuestion].answer) {
      score++;
    }
    // If there are more questions, go to the next question
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
      });
    } else {
      // If there are no more questions, show the final score
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Quiz Completed'),
            content:
                Text('Your final score is $score out of ${questions.length}'),
            actions: [
              TextButton(
                onPressed: () {
                  // Reset the quiz app state
                  setState(() {
                    currentQuestion = 0;
                    score = 0;
                    selectedAnswer = null;
                  });
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: Text('Restart'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the question
            Text(
              questions[currentQuestion].question,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            // Display the options as radio buttons
            Expanded(
              child: ListView.builder(
                itemCount: questions[currentQuestion].options.length,
                itemBuilder: (context, index) {
                  return RadioListTile<int>(
                    value: index,
                    groupValue: selectedAnswer,
                    onChanged: (index) {
                      checkAnswer(index!);
                      setState(() {});
                    },
                    title: Text(questions[currentQuestion].options[index]),
                  );
                },
              ),
            ),
            // Display the score and the progress
            Text(
              'Score: $score / ${questions.length}',
              style: TextStyle(fontSize: 18.0),
            ),
            LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: QuizApp(),
  ));
}
