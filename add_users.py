import mysql.connector
from mysql.connector import Error, IntegrityError

def connect_to_database():
    # Replace these values with your actual database connection details
    config = {
        'user': 'root',
        'password': 'passroot',
        'host': 'localhost',
        'database': 'helpdesk4'
    }
    conn = mysql.connector.connect(**config)
    return conn

def insert_users_from_file(filename):
    conn = connect_to_database()
    cursor = conn.cursor()

    # Read data from the file and insert into the database
    with open(filename, 'r', encoding='latin-1') as file:
        next(file)  # Skip header if exists
        for line in file:
            fields = line.strip().split(';')  # Assuming CSV format
            name, password, type, group_id, email, uo = [field if field else None for field in fields]
            query = "INSERT INTO users (name, password, type, group_id, email, uo) VALUES (%s, %s, %s, %s, %s, %s)"
            try:
                cursor.execute(query, (name, password, type, group_id, email, uo))
            except IntegrityError as e:
                # Skip duplicate entry and continue with the next
                print(f"Skipping duplicate entry for email: {email}")
                continue
            except Error as e:
                # Handle other database errors
                print(f"Error: {e}")
                continue

    conn.commit()
    cursor.close()
    conn.close()

if __name__ == "__main__":
    insert_users_from_file('static/files/helpdesk_users.csv')
