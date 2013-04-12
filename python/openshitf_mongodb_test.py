
url = 'mongodb://admin:JryxhKULsAQc@127.9.114.1:27017/'

import pymongo
conn = pymongo.Connection(url, 27017)

print conn.oneday.play.find().next()


