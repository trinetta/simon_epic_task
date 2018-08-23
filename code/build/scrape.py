# scrape data from Andrew's site

import os
import getpass
from selenium import webdriver
from ChromeDriver import ChromeDriver

# the following if statement  
if getpass.getuser()=="simongreenhill":
    file_folder = r"/Users/simongreenhill/Dropbox/simon_epic_task/rawdata"
    # copy the path after typing "which chromedriver" into your command-line
    chromedriver_path = r"/anaconda3/bin/chromedriver" 
elif getpass.getuser()=="trinettachong":
    file_folder = ""
    chromedriver_path = ""
files = ["demographics.txt","house_age.txt","house_chars1.txt","house_chars2.txt","house_type.txt"]
data_url = "http://www.jasmiths.com/data_project"
driver = webdriver.Chrome('/anaconda3/bin/ChromeDriver')
driverObj = ChromeDriver(file_folder, chromedriver_path, files, data_url)
driverObj.get_data()



# import os
# import getpass
# from selenium import webdriver

# # the following if statement 
# if getpass.getuser()=="simongreenhill":
#     file_folder = r"/Users/simongreenhill/Dropbox/simon_epic_task/rawdata"
#     # copy the path after typing "which chromedriver" into your command-line
#     # chromedriver_path = r"/Users/simongreenhill/anaconda/bin/chromedriver" 
# elif getpass.getuser()=="trinettachong":
#     file_folder = ""
#     chromedriver_path = ""


# chrome_options = webdriver.ChromeOptions()
# prefs = {'download.default_directory' : file_folder}
# chrome_options.add_experimental_option('prefs', prefs)
# driver = webdriver.Chrome(chrome_options=chrome_options)
 
# driver.get("http://www.jasmiths.com/data_project")

# elems = driver.find_elements_by_partial_link_text(" Data ")

# for elem in elems:
#     print(elem.get_attribute("href"))
#     elem.click()

# x1=0
# while x1==0:
#     count=0
#     li = os.listdir(prefs['download.default_directory'])
#     for x1 in li:
#         if x1.endswith(".crdownload"):
#              count = count+1        
#     if count==0:
#         x1=1
#     else:
#         x1=0

# driver.close() 