const express = require("express");
const app = express();
app.use(express.json());
app.use(express.static("public"));

app.post("/api/register", (req, res) => {
  console.log("Received registration:", req.body);
  res.json({ status: "success", message: "Registered successfully!" });
});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});

