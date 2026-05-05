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
    
    print("Disabling foreign key checks and truncating tables...")
    cursor.execute("SET FOREIGN_KEY_CHECKS = 0;")
    tables = ["CALIFICACIONES", "INCIDENTES", "REGISTROS_HORARIO", "PARADAS", "RUTAS", "USUARIOS"]
    for table in tables:
        cursor.execute(f"TRUNCATE TABLE {table};")
    cursor.execute("SET FOREIGN_KEY_CHECKS = 1;")
    
    print("Reloading seed data...")
    with open('sql/seed_data.sql', 'r', encoding='utf-8') as f:
        sql_file = f.read()
    
    statements = sql_file.split(';')
    for statement in statements:
        stmt = statement.strip()
        if stmt and not stmt.startswith('--') and not stmt.startswith('USE'):
            try:
                cursor.execute(stmt)
            except Exception as e:
                print(f"Warning: Failed to execute statement: {stmt[:50]}... Error: {e}")
    
    conn.commit()
    
    cursor.execute("SELECT id_ruta, nombre_ruta FROM RUTAS")
    rows = cursor.fetchall()
    print("RUTAS loaded:")
    for row in rows:
        print(row)
        
    conn.close()
    print("Seed reloaded successfully.")
except Exception as e:
    print(f"Error: {e}")
