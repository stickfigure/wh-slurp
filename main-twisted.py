from twisted.web import server, resource
from twisted.internet import reactor
import json
import random

SCORES = {}

class Receive(resource.Resource):
	isLeaf = True
	def render_GET(self, request):
		global SCORES

		#return json.dumps(request.args)
	
		user_name = request.args['n'][0] + str(random.random())
		country = request.args['c'][0]
		tagline = request.args['t'][0]
		score = int(request.args['s'][0])
		best_word = request.args['b'][0]
		number_of_words = int(request.args['u'][0])
		bonus = int(request.args['bn'][0])
		input_stream = request.args['i'][0]
		rating_number = int(request.args['r'][0])

		data = [user_name, country, tagline, score, best_word, number_of_words, bonus, input_stream, rating_number]

		SCORES[user_name] = data

		return "OK"

class Gather(resource.Resource):
	isLeaf = True
	def render_GET(self, request):
		global SCORES
		oldScores = SCORES
		SCORES = {}
		return json.dumps(oldScores)

root = resource.Resource()
root.putChild("receive", Receive())
root.putChild("gather", Gather())

site = server.Site(root)
reactor.listenTCP(8088, site)
reactor.run()
