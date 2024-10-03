const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const PORT = 3000;

// Middleware to serve static files and parse request bodies
app.use(express.static('public'));
app.use(bodyParser.json());

// Function to evaluate the expression
function calculateExpression(expression) {
    try {
        const result = eval(expression); // Avoid using eval in real-world apps due to security issues.
        return result;
    } catch (error) {
        return 'Error';
    }
}

// API route to handle calculation requests
app.post('/calculate', (req, res) => {
    const { expression } = req.body;
    const result = calculateExpression(expression);
    res.json({ result });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
