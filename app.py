import mysql.connector
from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL
from db_operations import *

app = Flask(__name__)





# Mock engineer data (replace with actual engineer data storage)
engineers = [
    {"id": 1, "name": "Engineer1"},
    {"id": 2, "name": "Engineer2"},
    {"id": 3, "name": "Engineer3"}
]



config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'helpdesk'
}

connection = mysql.connector.connect(**config)

mysql = MySQL(app)

@app.route('/')
def index():
    return render_template('index.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM Users WHERE name = %s AND password = %s", (username, password)) 
        user = cursor.fetchone()
        cursor.close()
        
        if user:
            # Redirect to init_page upon successful login
            return redirect(url_for('init_page'))
        else:
            error = 'Invalid credentials. Please try again.'
    return render_template('login.html', error=error)

@app.route('/init_page')
def init_page():
    return render_template('init.html')

@app.route('/new_ticket', methods=['GET', 'POST'])
def new_ticket():
    if request.method == 'POST':
        description = request.form['description']
        date = request.form['date']
        state = request.form['state']
        created_by = request.form['created_by']
        attributed_to = request.form['attributed_to']
        create_ticket(description, date, state, created_by, attributed_to)
        return redirect(url_for('index'))  # Redirect to homepage after creating ticket
    return render_template('new_ticket.html')

@app.route('/my_tickets')
def my_tickets():
    return render_template('my_tickets.html', tickets=tickets)

@app.route('/admin_panel')
def admin_panel():
    return render_template('admin_pannel.html', tickets=tickets, engineers=engineers)

@app.route('/assign_engineer', methods=['POST'])
def assign_engineer():
    ticket_id = int(request.form['ticket_id'])
    engineer_id = int(request.form['engineer'])
    # Implement logic to assign engineer to ticket
    return "Engineer assigned successfully."

@app.route('/ticket_details')
def ticket_details():
    return render_template('ticket_details.html')




if __name__ == '__main__':
    app.run(debug=True)
