const express = require('express');
const mongoose = require('mongoose');
const app = express();

// Middleware to parse JSON
app.use(express.json());

// Connect to MongoDB
mongoose.connect("mongodb://localhost:27017/crud", {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
.then(() => console.log("Connected to MongoDB"))
.catch(err => console.log("MongoDB connection error:", err));

// Define schema
const UserSchema = new mongoose.Schema({
    name: String,
    dept: String   // use String since your sample is "CSE"
});

// Create model
const UserModel = mongoose.model("users", UserSchema);

// GET all students
app.get("/getstudent", async (req, res) => {
    try {
        console.log("GET /getstudent endpoint hit");
        const users = await UserModel.find({});
        console.log("Found users:", users);
        res.json(users);
    } catch (err) {
        console.log("Error fetching users:", err);
        res.status(500).json({ error: err.message });
    }
});

// Start server
app.listen(3001, () => {
    console.log("Server is running on http://localhost:3001");
});