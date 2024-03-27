from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

# Mock user data (replace this with a proper user authentication system)
users = {
    'user1': 'password1',
    'user2': 'password2'
}

# Mock ticket data (replace with actual ticket data storage)
tickets = [
    {"id": 1, "date_created": "2024-03-30", "user": "User1", "description": "Issue 1"},
    {"id": 2, "date_created": "2024-03-31", "user": "User2", "description": "Issue 2"}
]

# Mock engineer data (replace with actual engineer data storage)
engineers = [
    {"id": 1, "name": "Engineer1"},
    {"id": 2, "name": "Engineer2"},
    {"id": 3, "name": "Engineer3"}
]

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        if username in users and users[username] == password:
            # Redirect to init_page upon successful login
            return redirect(url_for('init_page'))
        else:
            error = 'Invalid credentials. Please try again.'
    return render_template('login.html', error=error)

@app.route('/init_page')
def init_page():
    return render_template('init.html')

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


@app.route('/new_ticket')
def new_ticket():
    return render_template('new_ticket.html')

if __name__ == '__main__':
    app.run(debug=True)
