const express = require("express");
const bcrypt = require("bcrypt");
const User = require("../models/User");
const router = express.Router();

/* ===========================
   🔥 SIGNUP (kayıt)
=========================== */
router.post("/signup", async (req, res) => {
  const { email, username, password } = req.body;

  // aynı email veya aynı username varsa kayıt izni verme
  const exists = await User.findOne({ $or: [{ email }, { username }] });
  if (exists) return res.json({ success: false, message: "Email veya username kullanılıyor" });

  const hashed = await bcrypt.hash(password, 10);

  const user = new User({ email, username, password: hashed });
  await user.save();

  return res.json({
    success: true,
    username: user.username,        // Flutter buradan alacak!
  });
});

/* ===========================
   🔥 LOGIN (Hem email hem kullanıcı adı ile giriş!)
=========================== */
router.post("/login", async (req, res) => {
  const { email, password } = req.body;

  const user = await User.findOne({
    $or: [{ email }, { username: email }]  // 👈 email inputuna username yazılırsa da eşleşir
  });

  if (!user) return res.json({ success: false, message: "Kullanıcı bulunamadı" });

  const match = await bcrypt.compare(password, user.password);
  if (!match) return res.json({ success: false, message: "Şifre yanlış" });

  return res.json({
    success: true,
    username: user.username,  // Flutter → Profile'a taşır
  });
});

module.exports = router;
