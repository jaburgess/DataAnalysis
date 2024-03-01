from bs4 import BeautifulSoup
import requests
import smtplib
import time
import datetime
import csv
import pandas as pd


URL = 'https://www.amazon.com/fire-tv-stick-with-3rd-gen-alexa-voice-remote/dp/B08C1W5N87/ref=zg_bs_c_amazon-devices_d_sccl_2/144-4659131-5236465?pd_rd_w=lsZKt&content-id=amzn1.sym.309d45c5-3eba-4f62-9bb2-0acdcf0662e7&pf_rd_p=309d45c5-3eba-4f62-9bb2-0acdcf0662e7&pf_rd_r=93YT3HHWPGH2KVCHZHX1&pd_rd_wg=RePFw&pd_rd_r=f9dca366-2b57-4fb0-a387-59be3f902506&pd_rd_i=B08C1W5N87&psc=1'

headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36", "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}

page = requests.get(URL, headers=headers)

soup1 = BeautifulSoup(page.content, "html.parser")

soup2 = BeautifulSoup(soup1.prettify(), "html.parser")

title = soup2.find(id='productTitle').get_text()

price_element = soup2.find(class_="aok-offscreen")
if price_element:
    price = price_element.get_text()
else:
    price = "Price not found"


price = price.strip()[1:]
title = title.strip()

today = datetime.date.today()

header = ['Title', 'Price', 'Date']
data = [title, price, today]

with open('AmazonScraperDataset.csv', 'w', newline='', encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow(header)
    writer.writerow(data)


def check_price():
    URL = 'https://www.amazon.com/fire-tv-stick-with-3rd-gen-alexa-voice-remote/dp/B08C1W5N87/ref=zg_bs_c_amazon-devices_d_sccl_2/144-4659131-5236465?pd_rd_w=lsZKt&content-id=amzn1.sym.309d45c5-3eba-4f62-9bb2-0acdcf0662e7&pf_rd_p=309d45c5-3eba-4f62-9bb2-0acdcf0662e7&pf_rd_r=93YT3HHWPGH2KVCHZHX1&pd_rd_wg=RePFw&pd_rd_r=f9dca366-2b57-4fb0-a387-59be3f902506&pd_rd_i=B08C1W5N87&psc=1'

    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36", "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}


    page = requests.get(URL, headers=headers)

    soup1 = BeautifulSoup(page.content, "html.parser")

    soup2 = BeautifulSoup(soup1.prettify(), "html.parser")

    title = soup2.find(id='productTitle').get_text()

    price_element = soup2.find(class_="aok-offscreen")
    if price_element:
        price = price_element.get_text()
    else:
        price = "Price not found"


    price = price.strip()[1:]
    title = title.strip()

    today = datetime.date.today()

    header = ['Title', 'Price', 'Date']
    data = [title, price, today]

    with open(r"C:\Users\Aiden\Documents\DataAnalystProjects\PythonProjects\pProjects\AmazonScraperDataset.csv", 'a+', newline='', encoding='UTF8') as f:
        writer = csv.writer(f)
        writer.writerow(data)

SECONDS_IN_DAY = 86400
while(True):
    check_price()
    time.sleep(SECONDS_IN_DAY)

