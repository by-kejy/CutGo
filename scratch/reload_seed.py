import os
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

load_dotenv()

DB_USER = os.getenv("DB_USER", "root")
DB_PASSWORD = os.getenv("DB_PASSWORD", "12345678")
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "3306")
DB_NAME = os.getenv("DB_NAME", "cutgo")

# Using charset=utf8mb4 to ensure correct encoding
URL = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}?charset=utf8mb4"
engine = create_engine(URL)

def run_seed():
    with engine.connect() as conn:
        print("Disabling foreign key checks...")
        conn.execute(text("SET FOREIGN_KEY_CHECKS = 0;"))
        
        tables = ["CALIFICACIONES", "INCIDENTES", "REGISTROS_HORARIO", "PARADAS", "RUTAS", "USUARIOS"]
        for table in tables:
            print(f"Truncating {table}...")
            conn.execute(text(f"TRUNCATE TABLE {table};"))
        
        conn.execute(text("SET FOREIGN_KEY_CHECKS = 1;"))
        conn.commit()
        print("Tables truncated.")

        print("Loading seed_data.sql...")
        with open("sql/seed_data.sql", "r", encoding="utf-8") as f:
            content = f.read()
            # Split by semicolon, but be careful with comments and strings. 
            # Simple split might work for this file.
            statements = content.split(";")
            for statement in statements:
                stmt = statement.strip()
                if stmt and not stmt.startswith("USE"):
                    conn.execute(text(stmt))
            conn.commit()
        print("Seed data loaded successfully.")

        print("Verifying RUTAS:")
        result = conn.execute(text("SELECT id_ruta, nombre_ruta FROM RUTAS;"))
        for row in result:
            print(f"ID: {row[0]}, Name: {row[1]}")

if __name__ == "__main__":
    run_seed()
