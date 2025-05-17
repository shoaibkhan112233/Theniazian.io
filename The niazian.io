// src/firebase.js
import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { getFirestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_PROJECT.firebaseapp.com",
  projectId: "YOUR_PROJECT",
  storageBucket: "YOUR_PROJECT.appspot.com",
  messagingSenderId: "XXXX",
  appId: "XXXX"
};

const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db = getFirestore(app);

export { auth, db };
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './styles/index.css';
import { BrowserRouter } from 'react-router-dom';

ReactDOM.createRoot(document.getElementById('root')).render(
  <BrowserRouter>
    <App />
  </BrowserRouter>
);
import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Login from './pages/Login';
import Register from './pages/Register';
import UserPanel from './pages/UserPanel';
import AdminPanel from './pages/AdminPanel';

function App() {
  return (
    <Routes>
      <Route path="/" element={<Login />} />
      <Route path="/register" element={<Register />} />
      <Route path="/user" element={<UserPanel />} />
      <Route path="/admin" element={<AdminPanel />} />
    </Routes>
  );
}
export default App;
import React, { useState } from 'react';
import { auth } from '../firebase';
import { signInWithEmailAndPassword } from 'firebase/auth';
import { useNavigate } from 'react-router-dom';

export default function Login() {
  const [form, setForm] = useState({ email: '', password: '' });
  const navigate = useNavigate();

  const handleLogin = async () => {
    try {
      const res = await signInWithEmailAndPassword(auth, form.email, form.password);
      const email = res.user.email;
      if (email === 'niazianhost@gmail.com') {
        navigate('/admin');
      } else {
        navigate('/user');
      }
    } catch (err) {
      alert("لاگ ان ناکام: " + err.message);
    }
  };

  return (
    <div className="p-6">
      <h2 className="text-xl mb-4">لاگ ان</h2>
      <input type="email" placeholder="ای میل" onChange={e => setForm({ ...form, email: e.target.value })} />
      <input type="password" placeholder="پاسورڈ" onChange={e => setForm({ ...form, password: e.target.value })} />
      <button onClick={handleLogin} className="bg-indigo-600 text-white p-2 mt-4">لاگ ان کریں</button>
    </div>
  );
}
