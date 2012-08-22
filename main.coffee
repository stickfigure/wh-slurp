SCORES = {}
COUNT = 0
LAST = null

express = require('express')
app = express()

app.get '/slurp/receive', (req, res) ->
	user_name = req.query.n
	country = req.query.c
	tagline = req.query.t
	score = parseInt(req.query.s)
	best_word = req.query.b
	number_of_words = parseInt(req.query.u)
	bonus = parseInt(req.query.bn)
	input_stream = req.query.i
	rating_number = parseInt(req.query.r)

	data = [user_name, country, tagline, score, best_word, number_of_words, bonus, input_stream, rating_number]

	SCORES[user_name] = data
	COUNT++
	LAST = new Date()
	
	if COUNT % 500 == 0
		console.log(LAST + ": Received #{COUNT}")

	res.header('Content-Type', 'application/json')
	res.header('Cache-Control', 'no-cache')
	res.send('{"s":"OK"}')
	
app.get '/slurp/gather', (req, res) ->
	now = new Date()
	if LAST
		console.log(now + ": Gathering #{COUNT}, last submit was " + (now.getTime() - LAST.getTime()) + " ms ago")
	else
		console.log(now + ": Gathering but nothing has been submitted yet"); 
		
	res.header('Content-Type', 'application/json')
	res.header('Cache-Control', 'no-cache')
	res.json(SCORES)
	SCORES = {}
	COUNT = 0

# This sets port 80, all interfaces, and a backlog of 50k
app.listen(80, null, 50000)
console.log(new Date() + ': Server running on port 80')
