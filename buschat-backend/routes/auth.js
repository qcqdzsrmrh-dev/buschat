const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken"); // Token için eklendi
const User = require("../models/User");
const router = express.Router();


// SIGN UP API
router.post("/signup", async (req, res) => {
  console.log("SIGNUP API CALLED ✔");

  const { email, username, password } = req.body;

  // Check if email or username is already taken
  const exists = await User.findOne({ $or: [{ email }, { username }] });
  if (exists) return res.status(400).json({ message: "Email or Username already used" });

  // Hash password
  const hashed = await bcrypt.hash(password, 10);

  // Create User
  const user = new User({ email, username, password: hashed });
  await user.save();

  return res.json({
    success: true,
    userId: user._id,
    message: "User created successfully"
  });
});


// LOGIN API + TOKEN
router.post("/login", async (req, res) => {
  console.log("LOGIN API CALLED ✔");

  const { email, password } = req.body;

  const user = await User.findOne({ email });
  if (!user) return res.status(400).json({ message: "User not found" });

  const match = await bcrypt.compare(password, user.password);
  if (!match) return res.status(400).json({ message: "Wrong password" });

  // JWT TOKEN oluşturma
  const token = jwt.sign(
    { userId: user._id, username: user.username },
    "superSecretKey123",                // 🔥 daha sonra .env içine taşıyacağız
    { expiresIn: "30d" }                 // token geçerlilik süresi
  );

  return res.json({
    success: true,
    token,
    userId: user._id,
    username: user.username
  });
});


module.exports = router;   // 🔥 En altta olmalı — ikisini de export eder
