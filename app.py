import datetime
from functools import wraps
import secrets
import mysql.connector
from flask import Flask, flash, jsonify, render_template, request, redirect, url_for
from db_operations import *
from flask import session
from flask import redirect
from datetime import datetime
from flask import request
from flask_mail import Mail, Message



app = Flask(__name__)
# Generate a secure secret key
app.secret_key = secrets.token_bytes(16)
app.config['MAIL_SERVER']='pegasus.azores.gov.pt'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USERNAME'] = 's0204helpdesk'
app.config['MAIL_PASSWORD'] = 'RL3kieLAziocp7iK'
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False

mail=Mail(app)



config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'helpdesk4'
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
        cursor.execute("SELECT id, type FROM users WHERE name = %s AND password = %s", (username, password))
        user_data = cursor.fetchone()  # Fetch the user ID and type from the database
        cursor.close()
        if user_data:
            session['user_id'] = user_data[0]  # Store user ID in session
            session['user_type'] = user_data[1]  # Store user type in session
            if is_admin(user_data[0]):
                return redirect(url_for('admin_init'))  # Redirect admin users to admin_init page
            else:
                return redirect(url_for('init_page'))  # Redirect non-admin users to init_page
        else:
            error = 'Invalid credentials. Please try again.'
    return render_template('login.html', error=error)

@app.route('/logout')
def logout():
    session.clear()  # Clear session data
    return redirect(url_for('index'))  # Redirect to homepage after logout

@app.route('/init_page')
def init_page():
    if 'user_id' not in session:
        return redirect(url_for('login'))  # Redirect to login page if user is not logged in

    user_id = session['user_id']
    open_tickets = get_opened_tickets_count_by_user(user_id)
    closed_tickets = get_closed_tickets_count_by_user(user_id)
    executing_tickets = get_executing_tickets_count_by_user(user_id)
    
    return render_template('init.html', open_tickets=open_tickets,closed_tickets=closed_tickets,executing_tickets=executing_tickets)

@app.route('/my_profile', methods=['GET', 'POST'])
def profile_page():
    if 'user_id' not in session:
        return redirect(url_for('login'))  # Redirect to login page if user is not logged in

    user_id = session['user_id']
    user_name = get_username(user_id)
    admin_status = is_admin(user_id)

    message = None  # Initialize message variable
    

    if request.method == 'POST':
        password = request.form['password']
        new_pass = request.form['new_password']
        confirm_pass = request.form['confirm_password']

        # Verify the current password
        if verify_password(user_id, password):
            # Update the password
            if new_pass == confirm_pass:
                update_password(user_id, new_pass)
                message = {'type': 'success', 'content': 'Password atualizada com sucesso!'}
            else:
                message = {'type': 'error', 'content': 'Nova password não confirmada.Tente outra vez.'}
        else:
            message = {'type': 'error', 'content': 'Password incorreta!'}

    return render_template('new_forms/my_profile.html', user_name=user_name, is_admin=admin_status, message=message)



@app.route('/admin_init')
def admin_init():
    return render_template('admin_init.html')


from flask import render_template

@app.route('/new_ticket', methods=['GET', 'POST'])
def new_ticket():
    if 'user_id' not in session:
        return redirect(url_for('login'))  # Redirect to login page if user is not logged in
    
    user_id = session['user_id']
    is_edu = check_email_contains_edu(user_id) 


    if request.method == 'POST':
        # Your existing code for creating a new ticket
        topic_id = request.form['topic_id']
        description = request.form['description']
        state = "open"
        uni_org = request.form['UnidadeOrg']
        
        # Get the user ID of the currently logged-in user from the session
        created_by = session.get('user_id')
        user_name = get_username(created_by)
        
        # Generate current date and time
        date = datetime.now().strftime("%Y/%m/%d %H:%M:%S")
        contacto = request.form['contacto']
        title = request.form['title']
        
        # Call the create_ticket function with the correct parameters
        create_ticket(topic_id, description, date, state, created_by, contacto, title, uni_org)
        ticket_id = get_ticketid(description)
        
        # Retrieve the email of the user who created the ticket
        user_email = get_user_email_by_user(created_by)
        # Send an email notification to the user
        admin_emails = get_emails_by_group(topic_id)

        if user_email:
            msg = Message(f'Ticket criado #{ticket_id}', sender='noreply@azores.gov.pt', recipients=[user_email])
            msg.html = f"""
                <h1>Novo ticket</h1>
                <p>Foi registado um novo ticket com o numero #<strong>{ ticket_id }</strong>.</p>
                <p>Logo que possível um dos nossos técnicos resolverá o problema.</p>
                <h2>Assunto: { title }</h2>
                <p>Descricao: { description}</p>
                <p>Obrigado por usar o nosso helpdesk.</p>
                <h3><strong>SREC-NIT</strong></h3>
            """
            mail.send(msg)
            
        if admin_emails:
            unique_admin_emails = set(admin_emails)  # Remove duplicates if any
            for admin_email in unique_admin_emails:
                msg = Message(f'Novo ticket aberto #{ticket_id}', sender='noreply@azores.gov.pt', recipients=[admin_email])
                msg.html = f"""
                    <h1>Novo ticket </h1>
                    <p>Criado por: {user_name}</p>
                    <p>Unidade organica: {uni_org}</p>
                    <p>Foi recebido um novo ticket com o número #<strong>{ticket_id}</strong> e com assunto <strong>{title}</strong>.</p>
                    <p>Descrição: {description}</p>
                    <p>Obrigado por usar o nosso helpdesk.</p>
                    <h3><strong>SREC-NIT</strong></h3>
                """
                mail.send(msg)


        return redirect(url_for('my_tickets'))  # Redirect to my_tickets page after creating ticket

    # Pass is_edu to the template for rendering
    return render_template('new_ticket.html', is_edu=is_edu)

@app.route('/my_tickets')
def my_tickets():
    if 'user_id' not in session:
        return redirect(url_for('login'))  # Redirect to login page if user is not logged in

    user_id = session['user_id']
    tickets = get_user_tickets(user_id)  # Function to fetch tickets associated with the user ID
    open_tickets = get_opened_tickets_count_by_user(user_id)
    close_tickets = get_closed_tickets_count_by_user(user_id)
    executing_tickets = get_executing_tickets_count_by_user(user_id)
    all_tickets = get_all_tickets_user(user_id)



    ticket_fields = []  # List to store ticket fields

    for ticket in tickets:
        group_name = get_group_name(ticket['id'])
        attributed_name = attributed_to_by_ticket(ticket['id'])
        ticket_fields.append({
            'id': ticket['id'],  # Assuming the ticket dictionary has an 'id' field
            'date': ticket['date'],  # Replace with actual field name from the database
            'state': ticket['state'],  # Replace with actual field name from the database
            'description': ticket['description'],  # Replace with actual field name from the database
            'attributed_to': ticket['attributed_to'],  # Replace with actual field name from the database
            'title': ticket['title'],
            'group_name': group_name,
            'attributed_name': attributed_name
        })
    
    admin_status = is_admin(user_id)

    # Render the template with the tickets and admin status
    return render_template('my_tickets.html', tickets=ticket_fields, is_admin=admin_status,open_tickets=open_tickets,close_tickets=close_tickets,executing_tickets=executing_tickets,all_tickets=all_tickets)


@app.route('/send_message', methods=['POST'])
def send_message():
    data = request.json
    ticket_id = data['ticket_id']
    message = data['message']
    
    # Get the user's ID from the session
    user_id = session.get('user_id')
    
    # Query the database to get the user's type
    cursor = connection.cursor()
    cursor.execute("SELECT type FROM users WHERE id = %s", (user_id,))
    user_type = cursor.fetchone()
    cursor.close()
    
    # Set the sender type based on the user's type
    sender_type = user_type[0] if user_type else 'user'  # Default to 'user' if no type is found
    sender_name = get_username(user_id)
    
    # Insert the message into the database
    cursor = connection.cursor()
    cursor.execute("INSERT INTO messages (ticket_id, message, sender_type, sender_name) VALUES (%s, %s, %s, %s)",
                   (ticket_id, message, sender_type, sender_name))
    connection.commit()
    
    # If the sender is an admin, send the message to the email of the ticket creator
    if sender_type == 'admin':
        ticket_creator_email = get_user_email_by_ticket(ticket_id)
        if ticket_creator_email:
            msg = Message(f'Atualização no ticket#{ticket_id}', sender='noreply@azores.gov.pt', recipients=[ticket_creator_email])
            msg.html = f"""
                <p>Foi registada uma atualização no seu ticket com o numero #<strong>{ ticket_id }</strong>.</p>
                <p>Verifique as novas atualizações.</p>
                <p>Obrigado por usar o nosso helpdesk.</p>
                <h3><strong>SREC-NIT</strong></h3>
            """
            mail.send(msg)
            
    cursor.close()
    
    return jsonify({'success': True})

def admin_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get('user_type') != 'admin':
            return redirect(url_for('index'))  # Redirect non-admin users to the homepage
        return f(*args, **kwargs)
    return decorated_function

@app.route('/admin_pannel')
@admin_required
def admin_panel():
    tickets = get_all_tickets()  # Fetch all tickets from the database
    open_tickets = no_open_tickets()
    closed_tickets = no_closed_tickets()
    executing_tickets = no_execution_tickets()
    
    for ticket in tickets:
        attributed_name = attributed_to_by_ticket(ticket['id'])

    return render_template('admin_pannel.html', tickets=tickets,open_tickets=open_tickets,closed_tickets=closed_tickets,executing_tickets=executing_tickets,attributed_name=attributed_name)

@app.route('/new_user', methods=['GET', 'POST'])
@admin_required
def new_user():
    if 'user_id' not in session:
        return redirect(url_for('login'))  # Redirect to login page if user is not logged in

    if request.method == 'POST':
        # Extract user details from the form
        name = request.form['name']
        password = request.form['password']
        type = request.form['type']
        group = request.form.get('group_id', None)
        email = request.form['email']

        # Here, you would add code to insert the new user into the database
        try:
            conn = connect_to_database()
            cursor = conn.cursor()
            cursor.execute("INSERT INTO users (name, password, type, group_id, email) VALUES (%s, %s, %s, %s, %s)",
                            (name, password, type, group, email))
            conn.commit()
            cursor.close()
            conn.close()
            return redirect(url_for('admin_init'))  # Redirect to dashboard after user creation
        except Exception as e:
            print("Error creating user:", e)
            return "Error creating user. Please try again later."


    # Render the form for adding a new user
    return render_template('new_forms/novo_utilizador.html')
    
    
    

@app.route('/pannel_group')
def group_panel():
    if 'user_id' not in session:
        return redirect(url_for('login'))  # Redirect to login page if user is not logged in

    user_id = session['user_id']
    # Fetch the group_id associated with the user
    group_id = get_user_group(user_id)
    # Fetch tickets based on the group_id
    tickets = get_all_tickets_group(group_id)
    closed_tickets = get_closed_tickets_count_by_group(group_id)
    opened_tickets = get_opened_tickets_count_by_group(group_id)
    executing_tickets = get_executing_tickets_count_by_group(group_id)
    
    return render_template('pannel_group.html', tickets=tickets,closed_tickets=closed_tickets,opened_tickets=opened_tickets,executing_tickets=executing_tickets)


@app.route('/ticket_details/<int:ticket_id>')
def ticket_details(ticket_id):
    user_id = session.get('user_id')
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT u.name FROM users u JOIN tickets t ON u.id = t.created_by WHERE t.id = %s", (ticket_id,))
    user_tuple = cursor.fetchone()
    if user_tuple:
        user_name = user_tuple[0]  # Access the first element of the tuple
    else:
        # Handle the case when no user is found
        user_name = None  # or any default value you want
    cursor.close()
    conn.close()
    admin_status = is_admin(user_id)
    ticket_details = get_ticket_details(ticket_id)
    return render_template('ticket_details.html', ticket_details=ticket_details, is_admin=admin_status, user_name=user_name)

@app.route('/close_ticket/<int:ticket_id>', methods=['POST'])
def close_ticket_route(ticket_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))  # Redirect to login page if user is not logged in

    user_id = session['user_id']
    # Add a message indicating that the ticket has been closed by the admin
    #current_time = datetime.now().strftime('%d-%m-%Y %H:%M:%S')
    # close_message = f"Ticket fechado at {current_time}"
    # add_message_to_ticket(ticket_id, close_message)

    # Update the ticket's state to "closed"
    close_ticket(user_id,ticket_id)
    user_email = get_user_email_by_ticket(ticket_id)
        
    # Send an email notification to the user
    if user_email:
        msg = Message(f'Ticket fechado #{ticket_id}', sender='noreply@azores.gov.pt', recipients=[user_email])
        msg.html = f"""
            <h2>O seu ticket com o número #{ticket_id} foi concluído com sucesso.</h2>
            <p>Obrigado por usar o nosso helpdesk.</p>
            <h3><strong>SREC-NIT</strong></h3>
        """
        mail.send(msg)

    return jsonify({'success': True})



@app.route('/reopen_ticket/<int:ticket_id>', methods=['POST'])
def reopen_ticket_route(ticket_id):
    reopen_ticket(ticket_id)

    return jsonify({'success': True})

@app.route('/accept_ticket/<int:ticket_id>', methods=['POST'])
def accept_ticket_route(ticket_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))  # Redirect to login page if user is not logged in

    user_id = session['user_id']
    # Add a message indicating that the ticket has been closed by the admin
    # current_time = datetime.now().strftime('%d-%m-%Y %H:%M:%S')
    # accept_message = f"Ticket accepted by admin at {current_time}"
    # add_message_to_ticket(ticket_id, accept_message)
    #claim the ticket
    claim_ticket(user_id,ticket_id)
    attributed_to(user_id)
    user_email = get_user_email_by_ticket(ticket_id)
    if user_email:
        msg = Message(f'Ticket aceite #{ticket_id}', sender='noreply@azores.gov.pt', recipients=[user_email])
        msg.html = f"""
            <h2>O seu ticket com o número #{ticket_id} foi aceite e encontra-se neste momento em execução.</h2>
            <p>Obrigado por usar o nosso helpdesk.</p>
            <h3><strong>SREC-NIT</strong></h3>
        """
        mail.send(msg)
    

    return jsonify({'success': True})


@app.route('/accountform')
def create_accountEDU_page():
    return render_template('/new_forms/create_accountform.html')


if __name__ == '__main__':
    app.run(debug=True)
