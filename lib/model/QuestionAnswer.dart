class Question {
  Question(this.imgLink, this.answers);

  final String imgLink;

  final String answers;

  String toString() => 'Question { text: $imgLink, answers: $answers }';
}

// class Answer {
//   Answer(this.text, this.score);
//
//   final String text;
//
//   final int score;
//
//   String toString() => 'Answer { text: $text, score: $score }';
// }

main(List<String> args) {
  final vehicle = [
    Question('suv.png', 'suv'),
    Question('campervan.png', 'campervan'),
    Question('pickup.png', 'pickup'),
    Question('sedan.png', 'sedan'),
    Question('supercar.png', 'supercar'),
    Question('van.png', 'van'),
    Question('limo.png', 'limo'),
  ];

  //print(questions.length); // 3
  // print(questions[0].text); // What's your favorite color?
  // print(questions[0].answers); // [Answer { text: Black, score: 3 }, Answer { text: Blue, score: 1 }, Answer { text: White, score: 1 }]
  // print(questions[0].answers.length); // 3
  // questions[0].answers.forEach((answer) => print(answer.text)); // print all three options('text') of 'answers'
  // print(questions[0].answers[0]); // Answer { text: Black, score: 3 }
  // print(questions[0].answers[0].text); // Black
  // print(questions[0].answers[0].score); // 3
}