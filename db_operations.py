# Database Operations

from config import DB_CONFIG  # Import the database configuration
from flask import session
import mysql.connector  # Import MySQL Connector Python module

def connect_to_database():
    """Establishes a connection to the MySQL database."""
    return mysql.connector.connect(**DB_CONFIG)


# User Authentication and Authorization

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
    cursor.execute("SELECT * FROM Users WHERE username = %s AND password = %s", (username, password))
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    return user

def get_user_group(user_id):
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT group_id FROM Users WHERE id = %s", (user_id,))
    user_group = cursor.fetchone()
    cursor.close()
    conn.close()
    return user_group[0] if user_group else None

def get_username(user_id):
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM Users WHERE id = %s", (user_id,))
    user_name = cursor.fetchone()[0]
    cursor.close()
    conn.close()
    return user_name






# Ticket Operations

def get_ticket_details(ticket_id):
    """Fetches ticket details and associated messages from the database based on the ticket ID."""
    conn = connect_to_database()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, description, date, state, created_by, attributed_to, contacto, title,closed_by FROM tickets WHERE id = %s", (ticket_id,))
    ticket_details = cursor.fetchone()
    
    # Fetch messages associated with the ticket
    cursor.execute("SELECT message, sender_type, sent_at,sender_name FROM Messages WHERE ticket_id = %s", (ticket_id,))
    messages = cursor.fetchall()
    ticket_details['messages'] = messages
    
    cursor.close()
    conn.close()
    return ticket_details

def get_all_tickets():
    """Fetches all tickets from the database."""
    conn = connect_to_database()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM tickets")
    tickets = cursor.fetchall()
    cursor.close()
    conn.close()
    return tickets

def get_all_tickets_group(group_id):
    """Fetches all tickets from the database."""
    conn = connect_to_database()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM tickets WHERE group_id = %s", (group_id,))
    tickets = cursor.fetchall()
    cursor.close()
    conn.close()
    return tickets



def create_ticket(topic_id, description, date, state, created_by, contacto, title):
    """Creates a new ticket in the database."""
    conn = connect_to_database()
    cursor = conn.cursor()
    try:
        # Fetch the group_id associated with the provided topic_id
        cursor.execute("SELECT group_id FROM Topics WHERE id = %s", (topic_id,))
        group_id = cursor.fetchone()[0]

        # Fetch the name of the user based on the created_by ID
        cursor.execute("SELECT name FROM Users WHERE id = %s", (created_by,))
        created_by_user = cursor.fetchone()[0]

        # Insert the new ticket with the fetched group_id and created_by_user
        cursor.execute("""
            INSERT INTO Tickets (topic_id, description, date, state, created_by, contacto, title, group_id, created_by_user)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (topic_id, description, date, state, created_by, contacto, title, group_id, created_by_user))
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
    cursor.execute("SELECT id, date, state, description, attributed_to, contacto, title FROM tickets WHERE created_by = %s", (user_id,))
    user_tickets = cursor.fetchall()
    cursor.close()
    conn.close()
    return user_tickets

def get_creator_name(ticket_id):
    try:
        conn = connect_to_database()
        cursor = conn.cursor()
        cursor.execute("""
            SELECT Users.name
            FROM Users
            JOIN Tickets ON Users.id = Tickets.created_by
            WHERE Tickets.id = %s
        """, (ticket_id,))
        creator_name = cursor.fetchone()
        return creator_name[0] if creator_name else None  # Return None if no user found
    except Exception as e:
        print("Error:", e)
    finally:
        cursor.close()
        conn.close()





# Miscellaneous Operations

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
    cursor.execute("SELECT id, name, type FROM Users JOIN ON Tickets.user.id=Users.id WHERE Tickes.ticket_id = %s", ticket_id)
    user_details = cursor.fetchone()
    cursor.close()
    return user_details

def close_ticket(user_id,ticket_id):
    """Closes a ticket by updating its state to 'closed' and sets the 'closed_by' field."""
    try:
        # Close the ticket and set the 'closed_by' field to the name of the admin-user
        conn = connect_to_database()
        cursor = conn.cursor()
        cursor.execute("SELECT name FROM Users WHERE id = %s", (user_id,))
        user_name = cursor.fetchone()[0]
        
        cursor.execute("UPDATE Tickets SET state = 'closed', closed_by = %s WHERE id = %s", (user_name, ticket_id))
        conn.commit()
        print("Ticket closed successfully")
    except Exception as e:
        print("Error closing ticket:", e)
    finally:
        cursor.close()
        conn.close()


def reopen_ticket(ticket_id):
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("UPDATE Tickets SET state = 'open' WHERE id = %s", (ticket_id,))
    conn.commit()
    cursor.close()
    conn.close()
    return reopen_ticket

def is_closed(ticket_id):
    """Checks if the ticket is closed"""
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT state FROM Ticket WHERE id = %s", (ticket_id,))
    ticket_state = cursor.fetchone()
    cursor.close()
    conn.close()
    
    if ticket_state == 'closed':  # Check if user_type is not None and compare the first element of the tuple
        return True
    else:
        return False
    
def add_message_to_ticket(ticket_id, message):
    """Adds a message to the conversation of a ticket."""
    conn = connect_to_database()
    cursor = conn.cursor()
    try:
        cursor.execute("INSERT INTO Messages (ticket_id, message, sender_type) VALUES (%s, %s, 'admin')",
                       (ticket_id, message))
        conn.commit()
        print("Message added to ticket successfully")
    except mysql.connector.Error as e:
        print("Error adding message to ticket:", e)
    finally:
        cursor.close()
        conn.close()
        
def get_group_name(ticket_id):
    conn = connect_to_database()
    cursor = conn.cursor()
    
    try:
        # Fetch the topic ID associated with the ticket
        cursor.execute("SELECT topic_id FROM tickets WHERE id = %s", (ticket_id,))
        topic_id = cursor.fetchone()[0]
        
        # Fetch the group ID associated with the topic
        cursor.execute("SELECT group_id FROM Topics WHERE id = %s", (topic_id,))
        group_id = cursor.fetchone()[0]
        
        # Fetch the group name based on the group ID
        cursor.execute("SELECT name FROM `Groups` WHERE id = %s", (group_id,))
        group_name = cursor.fetchone()
        
        return group_name[0] if group_name else None  # Return the group name or None if not found
    except Exception as e:
        print("Error fetching group name:", e)
        return None
    finally:
        cursor.close()
        conn.close()

