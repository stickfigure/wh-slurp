// Generated by CoffeeScript 1.3.3
(function() {
  var COUNT, SCORES, app, express;

  SCORES = {};

  COUNT = 0;

  express = require('express');

  app = express();

  app.get('/slurp/receive', function(req, res) {
    var best_word, bonus, country, data, input_stream, number_of_words, rating_number, score, tagline, user_name;
    user_name = req.query.n;
    country = req.query.c;
    tagline = req.query.t;
    score = parseInt(req.query.s);
    best_word = req.query.b;
    number_of_words = parseInt(req.query.u);
    bonus = parseInt(req.query.bn);
    input_stream = req.query.i;
    rating_number = parseInt(req.query.r);
    data = [user_name, country, tagline, score, best_word, number_of_words, bonus, input_stream, rating_number];
    SCORES[user_name] = data;
    COUNT++;
    if (COUNT % 1000 === 0) {
      console.log("Received " + COUNT);
    }
    res.header('Cache-Control', 'no-cache');
    return res.send("OK");
  });

  app.get('/slurp/gather', function(req, res) {
    console.log("Gathering " + COUNT);
    res.header('Cache-Control', 'no-cache');
    res.json(SCORES);
    SCORES = {};
    return COUNT = 0;
  });

  app.listen(80, null, 10000);

  console.log('Server running on port 80');

}).call(this);
