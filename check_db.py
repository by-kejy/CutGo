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
    
    cursor.execute("SELECT COUNT(*) FROM RUTAS")
    rutas_count = cursor.fetchone()[0]
    
    cursor.execute("SELECT COUNT(*) FROM PARADAS")
    paradas_count = cursor.fetchone()[0]
    
    print(f"RUTAS count: {rutas_count}")
    print(f"PARADAS count: {paradas_count}")
    
    conn.close()
except Exception as e:
    print(f"Error: {e}")
