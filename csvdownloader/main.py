# This is a sample Python script.

# Press ⌃R to execute it or replace it with your code.
# Press Double ⇧ to search everywhere for classes, files, tool windows, actions, and settings.
import csv
import requests
import time
import os


def open_csv(_csv_path):
    with open(_csv_path, newline='') as csvfile:
        reader = csv.DictReader(csvfile)

        folder = 'downloads/' + str(time.time()) + '/'
        if not os.path.exists(folder):
            os.makedirs(folder)

        for row in reader:
            # print(row['title'],row['url'])
            r = requests.get(row['url'], allow_redirects=True)

            content_type = r.headers.get('content-type')
            ext = content_type.split('/')[-1]
            path = folder + row['title'] + '.' + ext
            open(path, 'wb').write(r.content)
            print(row['title'])


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    # open_csv("./csv/4.csv")
    open_csv("./fiona.csv")

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
