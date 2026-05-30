# Node-Auth

A full-stack authentication app with a **Node.js + MongoDB** backend and a **Flutter** frontend. Users can register, log in, and log out — JWT tokens are used to decide whether to show the signup screen or home screen.

---

## 🛠️ Tech Stack

| Layer    | Technology                        |
|----------|-----------------------------------|
| Frontend | Flutter (Dart)                    |
| Backend  | Node.js, Express.js               |
| Database | MongoDB (via Mongoose)            |
| Auth     | JWT (jsonwebtoken) + bcrypt       |

---

## ✨ Features

- **Sign Up** — Create a new account with a hashed password (bcrypt)
- **Login** — Authenticate and receive a JWT token
- **Auth Guard** — Token checked on app start; routes to Home or Sign Up accordingly
- **Logout** — Clears the token and returns to Sign Up screen

---

## 📁 Project Structure

```
Node-Auth/
├── node_auth/              
│   └── lib/                  # Flutter frontend
│   └── server/               # Node.js backend
│     ├── index.js            # Entry point, Express app setup
│     ├── model/              # Mongoose user schema
│     ├── routes/             # Auth routes (register, login, logout)
│     └── middleware/         # JWT verification middleware
└── .gitignore
```

---

## ⚙️ Getting Started

### Backend Setup

1. **Clone the repo**
   ```bash
   git clone https://github.com/mutha-varun/Node-Auth.git
   cd Node-Auth/node_auth/server
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Create a `.env` file**
   ```env
   MONGODB=your_mongodb_connection_string
   PORT=3000
   ```

4. **Start the server**
   ```bash
   npm dev run
   ```

### Flutter Setup

1. ```bash
   cd ..
   flutter pub get
   flutter run
   ```

---

## 🔗 API Endpoints

| Method | Route              | Description              | Auth Required |
|--------|--------------------|--------------------------|---------------|
| POST   | `/api/signup`      | Register a new user      | No            |
| POST   | `/api/signin`      | Login and get JWT token  | No            |

---
