import sqlite3

conn = sqlite3.connect('tickets.db')
c = conn.cursor()

# Create table
c.execute('''CREATE TABLE tickets
             (id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              description TEXT NOT NULL,
              priority TEXT NOT NULL,
              category TEXT NOT NULL,
              status TEXT NOT NULL)''')

c.execute('''CREATE TABLE users
             (id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              password TEXT NOT NULL)''')


conn.commit()
conn.close()

