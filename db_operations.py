from aifc import Error
from config import DB_CONFIG
import mysql.connector

def connect_to_database():
    """Establishes a connection to the MySQL database."""
    return mysql.connector.connect(**DB_CONFIG)

def is_admin(user_id):
    """Checks if the user is an Admin"""
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT type FROM Users WHERE id = %s", (user_id,))
    user_type = cursor.fetchone()
    cursor.close()
    conn.close()
    
    if user_type and user_type[0] == 'admin':  # Check if user_type is not None and compare the first element of the tuple
        return True
    else:
        return False
    
def validate_user(username, password):
    """Validates user credentials against the database."""
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users WHERE username = %s AND password = %s", (username, password))
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    return user

def get_ticket_details(ticket_id):
    """Fetches ticket details and associated messages from the database based on the ticket ID."""
    conn = connect_to_database()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, description, date, state, created_by, attributed_to FROM tickets WHERE id = %s", (ticket_id,))
    ticket_details = cursor.fetchone()
    
    # Fetch messages associated with the ticket
    cursor.execute("SELECT message, sender_type FROM Messages WHERE ticket_id = %s", (ticket_id,))
    messages = cursor.fetchall()
    ticket_details['messages'] = messages
    
    cursor.close()
    conn.close()
    return ticket_details

def get_all_tickets():
    """Fetches all tickets from the database."""
    conn = connect_to_database()  # Assuming you have a function named connect_to_database to establish a connection
    cursor = conn.cursor(dictionary=True)  # Use dictionary cursor to fetch rows as dictionaries
    cursor.execute("SELECT * FROM tickets")
    tickets = cursor.fetchall()
    cursor.close()
    conn.close()
    return tickets

def create_ticket(topic_id, description, date, state, created_by):
    """Creates a new ticket in the database."""
    conn = connect_to_database()
    cursor = conn.cursor()
    try:
        cursor.execute("INSERT INTO tickets (topic_id, description, date, state, created_by) VALUES (%s, %s, %s, %s, %s)",
                       (topic_id, description, date, state, created_by))
        conn.commit()
        print("Ticket created successfully")
    except mysql.connector.Error as e:
        print("Error creating ticket:", e)
    finally:
        cursor.close()
        conn.close()

def get_user_tickets(user_id):
    """Fetches tickets associated with the given user ID."""
    conn = connect_to_database()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, date, state, description, attributed_to FROM tickets WHERE created_by = %s", (user_id,))
    user_tickets = cursor.fetchall()
    cursor.close()
    conn.close()
    return user_tickets


def get_topics():
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT key_word FROM Topics")
    topics = cursor.fetchone()
    cursor.close()
    return topics

def get_user_details(ticket_id):
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT id,name,type FROM Users JOIN ON Tickets.user.id=Users.id WHERE Tickes.ticket_id = %s", ticket_id)
    user_details = cursor.fetchone()
    cursor.close()
    return user_details

def close_ticket(ticket_id):
    conn = connect_to_database()
    cursor = conn.cursor()
    update_query = "UPDATE Tickets SET state = 'closed' WHERE id = %s"
    cursor.execute(update_query,(ticket_id,))
    cursor.close()
    return close_ticket
