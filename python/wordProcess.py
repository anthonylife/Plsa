#!/usr/bin/env python
#encoding=utf8

## Function: remove stopwords and stem words
## Date: 2012/9/23

#from nltk.stem.wordnet import WordNetLemmatizer
from stemming.porter2 import stem

def loadStopwords(dic):
    stopwordsDic = {}
    for line in open(dic):
        line = line.strip('\n')
        #print line
        stopwordsDic[line] = 1
    return stopwordsDic

def filterWords(dic, tokens):
    final_tokens = []
    for token in tokens:
        # Lemmatize
        #token = stem(token)
        #if token.replace(token_temp, '') != 'e':
        #    token = token_temp
        # Remove stopwords
        if not dic.has_key(token):
            final_tokens = final_tokens + [token]
    return final_tokens

if __name__ == "__main__":
    # Test
    lm = stem.WordNetLemmatizer()
    a = ['of', 'the', 'haha']
    dic = loadStopwords('../dictionary/stopwords')
    print filterWords(dic, a)
