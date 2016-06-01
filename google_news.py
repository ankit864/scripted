from __future__ import print_function
from lxml import html
import requests
import subprocess
import time
response = requests.get('http://news.google.com')
if (response.status_code == 200):
	    pagehtml = html.fromstring(response.text)
	    news = pagehtml.xpath('//h2[@class="esc-lead-article-title"] \
                          /a/span[@class="titletext"]/text()')

a = open("a.txt","w")
print("\n".join(news),file = a)
a.close()
proc = subprocess.call(['gedit', 'a.txt'])
