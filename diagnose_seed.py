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
        content = f.read()
    
    print(f"Read {len(content)} characters from seed_data.sql")
    
    statements = content.split(';')
    print(f"Found {len(statements)} statements")
    
    for i, stmt in enumerate(statements):
        # Remove comments from statement
        lines = stmt.split('\n')
        clean_lines = [l for l in lines if not l.strip().startswith('--')]
        s = '\n'.join(clean_lines).strip()
        
        if s and not s.upper().startswith('USE'):
            print(f"Executing statement {i+1}: {s[:50]}...")
            try:
                cursor.execute(s)
                print(f"  Rows affected: {cursor.rowcount}")
            except Exception as e:
                print(f"  ERROR in statement {i+1}: {e}")
    
    conn.commit()
    print("Commit complete.")
    
    cursor.execute("SELECT COUNT(*) FROM RUTAS")
    print(f"Final RUTAS count: {cursor.fetchone()[0]}")
    
    conn.close()
except Exception as e:
    print(f"Connection Error: {e}")
