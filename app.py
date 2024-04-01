import datetime
import secrets
import mysql.connector
from flask import Flask, jsonify, render_template, request, redirect, url_for
from db_operations import *
from flask import session

app = Flask(__name__)
# Generate a secure secret key
app.secret_key = secrets.token_bytes(16)



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
        cursor.execute("SELECT id, type FROM Users WHERE name = %s AND password = %s", (username, password))
        user_data = cursor.fetchone()  # Fetch the user ID and type from the database
        cursor.close()
        if user_data:
            user_id, user_type = user_data
            session['user_id'] = user_id
            if is_admin(user_id):
                return redirect(url_for('admin_init'))  # Redirect admin users to admin_init page
            else:
                return redirect(url_for('init_page'))  # Redirect non-admin users to init_page
        else:
            error = 'Invalid credentials. Please try again.'
    return render_template('login.html', error=error)

@app.route('/init_page')
def init_page():
    return render_template('init.html')

@app.route('/admin_init')
def admin_init():
    return render_template('admin_init.html')


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

@app.route('/send_message', methods=['POST'])
def send_message():
    data = request.json
    ticket_id = data['ticket_id']
    message = data['message']
    
    # Get the user's ID from the session
    user_id = session.get('user_id')
    
    # Query the database to get the user's type
    cursor = connection.cursor()
    cursor.execute("SELECT type FROM Users WHERE id = %s", (user_id,))
    user_type = cursor.fetchone()
    cursor.close()
    
    # Set the sender type based on the user's type
    sender_type = user_type[0] if user_type else 'user'  # Default to 'user' if no type is found
    
    # Insert the message into the database
    cursor = connection.cursor()
    cursor.execute("INSERT INTO Messages (ticket_id, message, sender_type) VALUES (%s, %s, %s)",
                   (ticket_id, message, sender_type))
    connection.commit()
    cursor.close()
    
    return jsonify({'success': True})

@app.route('/admin_pannel')
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
    user_id = session.get('user_id')
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM Users WHERE id = %s", (user_id,))
    user_name = cursor.fetchone()
    cursor.close()
    conn.close()
    admin_status = is_admin(user_id)
    ticket_details = get_ticket_details(ticket_id)
    return render_template('ticket_details.html', ticket_details=ticket_details, is_admin=admin_status, user_name=user_name)


@app.route('/close_ticket/<int:ticket_id>', methods=['POST'])
def close_ticket_route(ticket_id):
    close_ticket(ticket_id)
    return jsonify({'success': True})


if __name__ == '__main__':
    app.run(debug=True)
