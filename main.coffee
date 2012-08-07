SCORES = {}

express = require('express')
app = express()

app.get '/receive', (req, res) ->
	user_name = req.query.n + Math.random()
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
	res.send("OK")

app.get '/gather', (req, res) ->
	res.json(SCORES)
	SCORES = {}

app.listen(1337)
console.log('Server running at http://127.0.0.1:1337/')




###
http = require('http')
url = require('url')
querystring = require('querystring')

receive = (req, res) ->

gather = (req, res) ->

handlers =
	'/receive': receive
	'/gather': gather

server = http.createServer (req, res) ->
	pathname = url.parse(req.url).pathname
	handler = handlers[pathname]
	
	if handler
		handler(req, res)
	else
		res.writeHead(404, {'Content-Type': 'text/plain'})
		res.end('Not Found')
	
server.listen(1337, '127.0.0.1')
console.log('Server running at http://127.0.0.1:1337/')
###
