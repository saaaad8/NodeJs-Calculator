let currentInput = '';

function appendNumber(number) {
    currentInput += number;
    document.getElementById('display').value = currentInput;
}

function appendOperator(operator) {
    currentInput += operator;
    document.getElementById('display').value = currentInput;
}

function clearDisplay() {
    currentInput = '';
    document.getElementById('display').value = '';
}

function calculate() {
    fetch('/calculate', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ expression: currentInput })
    })
    .then(response => response.json())
    .then(data => {
        document.getElementById('display').value = data.result;
        currentInput = '';
    })
    .catch(err => console.error(err));
}
