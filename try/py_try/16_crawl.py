from bs4 import BeautifulSoup
import requests
import os
import shutil

html_doc = """
12344
"""

soup = BeautifulSoup(html_doc, 'lxml')

headers = {}
url = ''


def crawl_title(url):
    response = requests.get(url, headers=headers)
    soup = BeautifulSoup(response.text, 'lxml')
    for title in soup.find_all('div', class_='123'):
        print(title)
        # 下载 文件名称
        file_name = os.path.basename()
        dir = os.path.abspath('.')
        file_path = os.path.join(dir, 'file_name')
        with open(file_path, 'wb') as f:
            response.raw.decode_content = True
            shutil.copyfileobj(response.raw, f)
            pass
        # 字符方法
        str()
