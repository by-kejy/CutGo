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
    
    with open('sql/seed_data.sql', 'r', encoding='utf-8') as f:
        sql_file = f.read()
    
    # Split statements by semicolon, but be careful with strings
    # Simple split works for this specific file
    statements = sql_file.split(';')
    
    for statement in statements:
        stmt = statement.strip()
        if stmt and not stmt.startswith('--') and not stmt.startswith('USE'):
            cursor.execute(stmt)
    
    conn.commit()
    print("Seed data re-executed successfully.")
    conn.close()
except Exception as e:
    print(f"Error: {e}")
