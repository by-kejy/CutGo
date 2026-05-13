from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .routers import rutas, horarios, incidentes, estadisticas, auth, paradas

app = FastAPI(title="CutGo API", redirect_slashes=False)

origins = [
    "http://localhost:5173",
    "http://localhost:5174",
    "https://cutgo-nine.vercel.app",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(rutas.router)
app.include_router(horarios.router)
app.include_router(incidentes.router)
app.include_router(estadisticas.router)
app.include_router(auth.router)
app.include_router(paradas.router)

@app.get("/")
def root():
    return {"message": "Welcome to the CutGo API!"}
