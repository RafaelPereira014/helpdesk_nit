import mysql.connector
from db_operations import *

# MySQL connection configuration
config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'helpdesk4'
}

try:
    # Attempt to establish a connection to the MySQL database
    connection = mysql.connector.connect(**config)

    if connection.is_connected():
        print("Connected to MySQL database")

        # Create a cursor object to execute SQL queries
        cursor = connection.cursor()

        group_id='1'
        # Execute the SQL query to fetch all tickets
        # cursor.execute("SELECT email FROM users WHERE group_id = %s", (group_id,))
        # emails = cursor.fetchall()
        # print(emails)
        
        is_edu = check_email_contains_edu('13')
        

        cursor.execute("SELECT * from users")
        name = cursor.fetchall()
        print(name)
        # Fetch all rows (tickets) from the result set

        # Close the cursor
        cursor.close()

    # Close the database connection
    connection.close()
    print("Connection closed")

except mysql.connector.Error as e:
    # Handle connection errors
    print("Error connecting to MySQL database:", e)
