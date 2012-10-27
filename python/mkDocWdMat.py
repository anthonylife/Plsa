#!/usr/bin/env python
#encoding=utf8

# MKDOCWDMAT number the words in whole corpus and make sparse matrix
#   representation for words and documents.

from wordProcess import loadStopwords, filterWords

# Source file
src_f = '../features/data.txt'
sw_f = '../dictionary/stopwords'

# Target file
feature_f = '../features/feature.txt'
dict_f = '../features/dict.txt'

dic = loadStopwords(sw_f)

# First scan, filter words and number the rest words
candi_tokens = set([])
for line in open(src_f):
    res = line.strip('\r\n').split(' ')
    for word in res:
        if '-' in word:
            temp_words = word.split('-')
            for s_word in temp_words:
                candi_tokens.add(s_word)
        else:
            candi_tokens.add(word)
final_tokens = filterWords(dic, candi_tokens)

# Second scan, make word dictionary and feature file
final_tokens = set(final_tokens)
token_id = {}
wfd = open(dict_f, 'w')
idx = 1
for i,word in enumerate(final_tokens):
    if word != '':
        token_id[word] = idx
        wfd.write(word+'\n')
        idx += 1
wfd.close()

doc_in_wd = {}
wfd = open(feature_f, 'w')
doc_idx = 1
for line in open(src_f):
    res = line.strip('\r\n').split(' ')
    tag = False
    for word in res:
        if '-' in word:
            temp_words = word.split('-')
            for s_word in temp_words:
                if s_word in token_id:
                    if token_id[s_word] in doc_in_wd:
                        doc_in_wd[token_id[s_word]] += 1
                    else:
                        doc_in_wd[token_id[s_word]] = 1

        elif word in token_id:
            if token_id[word] in doc_in_wd:
                doc_in_wd[token_id[word]] += 1
            else:
                doc_in_wd[token_id[word]] = 1
    for wd_id, num in doc_in_wd.items():
        wfd.write("%d %d %d\n" % (doc_idx, wd_id, num))
        tag=True
    if tag:
        doc_idx += 1
    doc_in_wd.clear()
wfd.close()
