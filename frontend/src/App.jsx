import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, NavLink, Navigate, useNavigate } from 'react-router-dom';
import { LogOut, Sun, Moon } from 'lucide-react';
import MapaRutas from './views/MapaRutas';
import RegistroHorario from './views/RegistroHorario';
import ReporteIncidente from './views/ReporteIncidente';
import Dashboard from './views/Dashboard';
import Home from './views/Home';
import Login from './views/Login';
import Registro from './views/Registro';
import { useAuth } from './context/AuthContext';
import './index.css';

// ─── Bootstrap theme from localStorage before first paint ────
const savedTheme = localStorage.getItem('cutgo_theme') || 'light';
document.documentElement.setAttribute('data-theme', savedTheme);

// ─── Protected Route ─────────────────────────────────────────
const ProtectedRoute = ({ children }) => {
  const { user } = useAuth();
  if (!user) return <Navigate to="/login" replace />;
  return children;
};

// ─── Navbar ──────────────────────────────────────────────────
const Navbar = () => {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  // Local dark state — reads from DOM so it's always in sync
  const [dark, setDark] = useState(
    () => document.documentElement.getAttribute('data-theme') === 'dark'
  );

  const toggleTheme = () => {
    const next = dark ? 'light' : 'dark';
    document.documentElement.setAttribute('data-theme', next);
    localStorage.setItem('cutgo_theme', next);
    setDark(!dark);
  };

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  const navLinkStyle = ({ isActive }) => ({
    padding: '6px 12px',
    borderRadius: 'var(--apple-radius-sm)',
    textDecoration: 'none',
    color: isActive ? 'var(--apple-surface)' : 'var(--apple-label-2)',
    fontWeight: 600,
    backgroundColor: isActive ? 'var(--apple-label)' : 'transparent',
    fontSize: '13px',
    transition: 'all 0.2s ease',
    letterSpacing: '0.1px',
  });

  return (
    <nav style={{
      position: 'sticky',
      top: 0,
      zIndex: 1000,
      backgroundColor: 'var(--apple-bg)',
      borderBottom: '0.5px solid var(--apple-separator)',
      padding: '0 24px',
      height: '56px',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'space-between',
    }}>
      {/* Left: Logo + Links */}
      <div style={{ display: 'flex', alignItems: 'center', gap: '28px' }}>
        <NavLink to="/" style={{ textDecoration: 'none' }}>
          <span style={{ fontSize: '17px', fontWeight: 700, color: 'var(--apple-label)', letterSpacing: '-0.5px' }}>
            CUTGO<span style={{ color: 'var(--orange-accent)' }}>.</span>
          </span>
        </NavLink>

        <div className="desktop-menu" style={{ display: 'flex', gap: '2px' }}>
          <NavLink to="/" end style={navLinkStyle}>Dashboard</NavLink>
          <NavLink to="/mapa" style={navLinkStyle}>Mapa</NavLink>
          <NavLink to="/horarios" style={navLinkStyle}>Horarios</NavLink>
          <NavLink to="/incidentes" style={navLinkStyle}>Incidentes</NavLink>
        </div>
      </div>

      {/* Right: Theme toggle + User */}
      <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
        {/* Dark/light toggle — always visible */}
        <button
          onClick={toggleTheme}
          title={dark ? 'Modo claro' : 'Modo oscuro'}
          style={{
            background: dark ? 'rgba(255,255,255,0.12)' : 'rgba(0,0,0,0.06)',
            border: 'none',
            borderRadius: '980px',
            padding: '6px 10px',
            cursor: 'pointer',
            display: 'flex',
            alignItems: 'center',
            gap: '4px',
          }}
        >
          {dark
            ? <Sun size={16} color="var(--apple-label)" />
            : <Moon size={16} color="var(--apple-label)" />
          }
        </button>

        {user ? (
          <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
            {/* Avatar */}
            <div style={{
              width: '30px',
              height: '30px',
              borderRadius: 'var(--apple-radius-sm)',
              backgroundColor: 'var(--apple-label)',
              color: 'var(--apple-bg)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              fontWeight: 700,
              fontSize: '12px',
              flexShrink: 0,
            }}>
              {user.nombre?.charAt(0).toUpperCase() ?? '?'}
            </div>
            {/* Logout */}
            <button
              onClick={handleLogout}
              style={{ background: 'none', border: 'none', color: 'var(--apple-label-2)', cursor: 'pointer', padding: '4px', display: 'flex', alignItems: 'center' }}
              title="Cerrar sesión"
            >
              <LogOut size={15} />
            </button>
          </div>
        ) : (
          <NavLink to="/login" style={navLinkStyle}>Iniciar sesión</NavLink>
        )}
      </div>
    </nav>
  );
};

// ─── App ──────────────────────────────────────────────────────
export default function App() {
  // Ensure theme is applied on every mount (handles hard refresh)
  useEffect(() => {
    const saved = localStorage.getItem('cutgo_theme') || 'light';
    document.documentElement.setAttribute('data-theme', saved);
  }, []);

  return (
    <Router>
      <div style={{ minHeight: '100vh', backgroundColor: 'var(--apple-bg)' }}>
        <Navbar />
        <main>
          <Routes>
            <Route path="/" element={<ProtectedRoute><Home /></ProtectedRoute>} />
            <Route path="/mapa" element={<MapaRutas />} />
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/login" element={<Login />} />
            <Route path="/registro" element={<Registro />} />
            <Route path="/horarios" element={<ProtectedRoute><RegistroHorario /></ProtectedRoute>} />
            <Route path="/incidentes" element={<ProtectedRoute><ReporteIncidente /></ProtectedRoute>} />
          </Routes>
        </main>
      </div>
    </Router>
  );
}
