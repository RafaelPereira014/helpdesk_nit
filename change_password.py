import mysql.connector
from db_operations import *

# MySQL connection configuration
config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'passroot',
    'database': 'helpdesk4'
}

try:
    # Attempt to establish a connection to the MySQL database
    connection = mysql.connector.connect(**config)

    if connection.is_connected():
        print("Connected to MySQL database")

        # Ask the user to input a "nome de utilizador"
        email = input("Por favor o email do utilizador': ")

        # Create a cursor object to execute SQL queries
        cursor = connection.cursor()

        # Your SQL query or operation using the username
        query = "UPDATE users SET password='59886fe3e4a390d23717ffc12004fdf754df4084ff23d7be65130205b865926e' WHERE email = %s"
        cursor.execute(query, (email,))
        print("Password alterada para 'password%100' com sucesso!. Informe o utilizador.")
        connection.commit()
        cursor.close()

    # Close the database connection
    connection.close()
    print("Connection closed")

except mysql.connector.Error as e:
    # Handle connection errors
    print("Error connecting to MySQL database:", e)
