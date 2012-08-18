SCORES = {}
COUNT = 0

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
	
	if COUNT % 1000 == 0
		console.log("Received #{COUNT}")

	res.header('Cache-Control', 'no-cache')
	res.send("OK")
	
app.get '/slurp/gather', (req, res) ->
	console.log("Gathering #{COUNT}")
	res.header('Cache-Control', 'no-cache')
	res.json(SCORES)
	SCORES = {}
	COUNT = 0

# This sets port 80, all interfaces, and a backlog of 10k
app.listen(80, null, 10000)
console.log('Server running on port 80')
