const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cors());

// 🔥 MongoDB bağlantısı (güncel sürüm için doğru yapı)
mongoose.connect("mongodb://127.0.0.1:27017/buschat")
  .then(() => console.log("MongoDB Connected ✔"))
  .catch(err => console.log("DB Error:", err));

// 🔥 Routes bağlama
const authRoute = require("./routes/auth");
app.use("/auth", authRoute);

// 🔥 Server başlatma
app.listen(3000, () => console.log("Server running on port 3000 🔥"));

