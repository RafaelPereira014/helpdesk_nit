import mysql.connector

# Function to insert topics into the topics table from a file
def insert_topics_from_file(file_path, cursor):
    try:
        # Open the file containing topics data
        with open(file_path, 'r') as file:
            # Read each line in the file
            for line in file:
                # Split the line into topic name and group_id
                topic_name, group_id = line.strip().split(',')
                # SQL query to insert the topic into the topics table
                insert_query = "INSERT INTO topics (key_word, group_id) VALUES (%s, %s)"
                # Execute the query
                cursor.execute(insert_query, (topic_name, group_id))
        print("Topics inserted successfully.")
    except FileNotFoundError:
        print("File not found.")
    except mysql.connector.Error as e:
        print("Error inserting topics:", e)

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

        # Insert topics into the MySQL database from a file
        insert_topics_from_file('static/files/topics_data.txt', cursor)

        # Commit the transaction
        connection.commit()

        # Close the cursor
        cursor.close()

    # Close the database connection
    connection.close()
    print("Topics added.")

except mysql.connector.Error as e:
    # Handle connection errors
    print("Error connecting to MySQL database:", e)
