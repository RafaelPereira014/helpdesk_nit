import mysql.connector

# MySQL connection configuration
config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'helpdesk'
}

try:
    # Attempt to establish a connection to the MySQL database
    connection = mysql.connector.connect(**config)

    if connection.is_connected():
        print("Connected to MySQL database")

        # Create a cursor object to execute SQL queries
        cursor = connection.cursor()

        # Execute the SQL query to select all users
        cursor.execute("SELECT * FROM users")

        # Fetch all rows from the result set
        users = cursor.fetchall()

        # Print the list of users
        print("List of users:")
        for user in users:
            print(user)

        # Close the cursor
        cursor.close()

    # Close the database connection
    connection.close()
    print("Connection closed")

except mysql.connector.Error as e:
    # Handle connection errors
    print("Error connecting to MySQL database:", e)
