# scrape data from Andrew's site

from selenium import webdriver
import os

chrome_options = webdriver.ChromeOptions()
prefs = {'download.default_directory' : '/Users/simongreenhill/Documents/orientation/rawdata'}
chrome_options.add_experimental_option('prefs', prefs)
driver = webdriver.Chrome(chrome_options=chrome_options)
 
driver.get("http://www.jasmiths.com/data_project")

elems = driver.find_elements_by_partial_link_text(" Data")

for elem in elems:
    print(elem.get_attribute("href"))
    elem.click()

x1=0
while x1==0:
    count=0
    li = os.listdir(prefs['download.default_directory'])
    for x1 in li:
        if x1.endswith(".crdownload"):
             count = count+1        
    if count==0:
        x1=1
    else:
        x1=0

driver.close() 