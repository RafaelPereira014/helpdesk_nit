from config import DB_CONFIG
import mysql.connector

def connect_to_database():
    """Establishes a connection to the MySQL database."""
    return mysql.connector.connect(**DB_CONFIG)

def validate_user(username, password):
    """Validates user credentials against the database."""
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users WHERE username = %s AND password = %s", (username, password))
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    return user

def get_tickets():
    """Fetches all tickets from the database."""
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM tickets")
    tickets = cursor.fetchall()
    cursor.close()
    conn.close()
    return tickets



def create_ticket(description, date, state, created_by, attributed_to):
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO Tickets (description, date, state, created_by) VALUES (%s, %s, %s, %s)",
                   (description, date, state, created_by))
    conn.commit()
    cursor.close()
    conn.close()

def get_ticket(ticket_id):
    """Fetches a specific ticket from the database."""
    conn = connect_to_database()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM tickets WHERE id = %s", (ticket_id,))
    ticket = cursor.fetchone()
    cursor.close()
    conn.close()
    return ticket
