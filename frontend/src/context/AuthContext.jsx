import { createContext, useContext, useState } from 'react'

const AuthContext = createContext(null)

export function AuthProvider({ children }) {
  const [user, setUser] = useState(() => {
    const saved = localStorage.getItem('cutgo_user')
    try {
        return saved ? JSON.parse(saved) : null
    } catch (e) {
        localStorage.removeItem('cutgo_user')
        return null
    }
  })

  const login = (userData) => {
    localStorage.setItem('cutgo_user', JSON.stringify(userData))
    setUser(userData)
  }

  const logout = () => {
    localStorage.removeItem('cutgo_user')
    setUser(null)
  }

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  )
}

export const useAuth = () => useContext(AuthContext)
