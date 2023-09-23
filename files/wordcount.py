from pyspark import SparkContext, SparkConf
import re

conf = SparkConf()
sc = SparkContext(conf=conf)

distFile = sc.textFile("/spark/bernuy/movies.csv")

counts = distFile\
    .flatMap(lambda line: re.split(r'\W*', line.rstrip())) \
    .filter(lambda word: word!="\n") \
    .filter(lambda word: word!="") \
    .map(lambda word: (word, 1)) \
    .reduceByKey(lambda a, b: a + b) \
    .sortByKey(True)

counts.saveAsTextFile("/spark/bernuy/output.txt") 
