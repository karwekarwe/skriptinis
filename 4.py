
import os
import time

print("Enter directory or file name or its part")
term = input()

found = False

for root, dirs, files in os.walk(os.getcwd()): #dabartiniam kataloge visas vyksta
    for file in files:
        if term in file:
            path = os.path.join(root, file)
            found = True
            break
    if found == True:
        break
    for dir in dirs:
        if term in dir:
            path = os.path.join(root, dir)
            found = True
            break
    if found == True:
        break

if found == False:
    print("Nerasta tokio")
    result = "Nerasta tokio\n"


if found == True:
    stat = os.stat(path)
    result = ""
    if (os.path.isfile(path) == True):
        result += f"Name: {os.path.basename(path)}\n"               #pavadinimas
        result += f"Path: {path}\n"                                 #path 
        result += f"Access date: {time.ctime(stat.st_atime)}\n"     #acess date 
        result += f"Creation date: {time.ctime(stat.st_ctime)}\n"   #create date 
    elif os.path.isdir(path):
        result += f"Direktorijos turinys: {os.listdir(path)}\n"     #contetn of directory
        result += f"Path: {path}\n"                                 #path 
        result += f"Access date: {time.ctime(stat.st_atime)}\n"     #acess date     
        result += f"Creation date: {time.ctime(stat.st_ctime)}\n"   #create date 
    print(result)

with open("4_log.txt", "a") as log:
    log.write(f"Date: {time.ctime()}\n")
    log.write(f"Search term: {term}\n")
    log.write(result)
    log.write("-------------------------------------------------------------\n")