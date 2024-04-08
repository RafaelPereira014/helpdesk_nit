import mysql.connector
from db_operations import *

# MySQL connection configuration
config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'helpdesk3'
}

try:
    # Attempt to establish a connection to the MySQL database
    connection = mysql.connector.connect(**config)

    if connection.is_connected():
        print("Connected to MySQL database")

        # Create a cursor object to execute SQL queries
        cursor = connection.cursor()

        # Execute the SQL query to fetch all tickets
        cursor.execute("SELECT * FROM tickets ORDER BY id DESC")

        # Fetch all rows (tickets) from the result set
        tickets = cursor.fetchall()

        # Print the fetched tickets
        for ticket in tickets:
            print(ticket)

        # Close the cursor
        cursor.close()

    # Close the database connection
    connection.close()
    print("Connection closed")

except mysql.connector.Error as e:
    # Handle connection errors
    print("Error connecting to MySQL database:", e)
