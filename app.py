import datetime
import secrets
import mysql.connector
from flask import Flask, render_template, request, redirect, url_for
from db_operations import *

app = Flask(__name__)
# Generate a secure secret key
app.secret_key = secrets.token_bytes(16)

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
        cursor.execute("SELECT id FROM Users WHERE name = %s AND password = %s", (username, password))
        user_id = cursor.fetchone()  # Fetch the user ID from the database
        cursor.close()
        if user_id:
            # Store the user ID in the session
            session['user_id'] = user_id[0]
            return redirect(url_for('init_page'))
        else:
            error = 'Invalid credentials. Please try again.'
    return render_template('login.html', error=error)

@app.route('/init_page')
def init_page():
    return render_template('init.html')

from flask import session

@app.route('/new_ticket', methods=['GET', 'POST'])
def new_ticket():
    if request.method == 'POST':
        topic_id = request.form['topic_id']
        description = request.form['description']
        state = "open"
        
        # Get the user ID of the currently logged-in user from the session
        created_by = session.get('user_id')
        
        # Generate current date and time
        date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        
        # Call the create_ticket function with the correct parameters
        create_ticket(topic_id, description, date, state, created_by)
        
        return redirect(url_for('my_tickets'))  # Redirect to my_tickets page after creating ticket
    return render_template('new_ticket.html')



from flask import session

@app.route('/my_tickets')
def my_tickets():
    if 'user_id' not in session:
        return redirect(url_for('login'))  # Redirect to login page if user is not logged in

    user_id = session['user_id']
    tickets = get_user_tickets(user_id)  # Function to fetch tickets associated with the user ID

    ticket_fields = []  # List to store ticket fields

    for ticket in tickets:
        ticket_fields.append({
            'id': ticket['id'],  # Assuming the ticket dictionary has an 'id' field
            'date': ticket['date'],  # Replace with actual field name from the database
            'state': ticket['state'],  # Replace with actual field name from the database
            'description': ticket['description'],  # Replace with actual field name from the database
            'attributed_tp': ticket['attributed_to'],  # Replace with actual field name from the database
        })
    print(ticket_fields)
    return render_template('my_tickets.html', tickets=ticket_fields)


@app.route('/admin_panel')
def admin_panel():
    tickets = get_all_tickets()  # Fetch all tickets from the database
    return render_template('admin_pannel.html', tickets=tickets)


@app.route('/assign_engineer', methods=['POST'])
def assign_engineer():
    ticket_id = int(request.form['ticket_id'])
    engineer_id = int(request.form['engineer'])
    # Implement logic to assign engineer to ticket
    return "Engineer assigned successfully."

@app.route('/ticket_details/<int:ticket_id>')
def ticket_details(ticket_id):
    # Fetch ticket details from the database based on the ticket ID
    ticket_details = get_ticket_details(ticket_id)
    return render_template('ticket_details.html', ticket_details=ticket_details)


if __name__ == '__main__':
    app.run(debug=True)
