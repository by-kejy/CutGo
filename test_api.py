import requests
import json

try:
    response = requests.get('http://127.0.0.1:8000/api/rutas')
    print(f"Status Code: {response.status_code}")
    if response.status_code == 200:
        data = response.json()
        print(f"Found {len(data)} routes.")
        for route in data:
            print(f" - {route.get('nombre_ruta')}")
    else:
        print(f"Error: {response.text}")
except Exception as e:
    print(f"Connection Error: {e}")
