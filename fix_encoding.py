import pymysql
import os
from dotenv import load_dotenv

load_dotenv()

DB_USER = os.getenv("DB_USER", "root")
DB_PASSWORD = os.getenv("DB_PASSWORD", "12345678")
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = int(os.getenv("DB_PORT", "3306"))
DB_NAME = os.getenv("DB_NAME", "cutgo")

try:
    conn = pymysql.connect(
        host=DB_HOST,
        port=DB_PORT,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME,
        charset='utf8mb4'
    )
    cursor = conn.cursor()
    
    # Alter Database
    print("Altering database charset...")
    cursor.execute("ALTER DATABASE cutgo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;")
    
    # Alter Tables
    tables = ["RUTAS", "PARADAS", "USUARIOS", "INCIDENTES", "CALIFICACIONES", "REGISTROS_HORARIO"]
    for table in tables:
        print(f"Altering table {table} charset...")
        cursor.execute(f"ALTER TABLE {table} CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;")
    
    # Clear existing data
    print("Clearing existing data...")
    # Order matters due to FK
    delete_order = ["CALIFICACIONES", "INCIDENTES", "REGISTROS_HORARIO", "PARADAS", "RUTAS", "USUARIOS"]
    for table in delete_order:
        cursor.execute(f"DELETE FROM {table};")
    
    conn.commit()
    print("Database altered and cleared successfully.")
    conn.close()
except Exception as e:
    print(f"Error: {e}")
