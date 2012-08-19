import tornado.ioloop
import tornado.web
import tornado.httpserver
import json
import random

SCORES = {}

class ReceiveHandler(tornado.web.RequestHandler):
    def get(self):
		global SCORES

		#return json.dumps(request.args)
	
		user_name = self.get_argument('n') + str(random.random())
		country = self.get_argument('c')
		tagline = self.get_argument('t')
		score = int(self.get_argument('s'))
		best_word = self.get_argument('b')
		number_of_words = int(self.get_argument('u'))
		bonus = int(self.get_argument('bn'))
		input_stream = self.get_argument('i')
		rating_number = int(self.get_argument('r'))

		data = [user_name, country, tagline, score, best_word, number_of_words, bonus, input_stream, rating_number]

		SCORES[user_name] = data

		self.write("OK")

class GatherHandler(tornado.web.RequestHandler):
    def get(self):
		global SCORES
		oldScores = SCORES
		SCORES = {}
		self.write(json.dumps(oldScores))

application = tornado.web.Application([
    (r"/slurp/receive", ReceiveHandler),
    (r"/slurp/gather", GatherHandler)
])

if __name__ == "__main__":
	server = tornado.httpserver.HTTPServer(application)
	server.bind(8088, backlog=20000)
	server.start()
    #application.listen(8088)
    tornado.ioloop.IOLoop.instance().start()
