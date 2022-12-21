function enableCustomPressureTextField() {
  pressureTextField.enabled = true
  pressureTextField.hidden = false
}

function disableCustomPressureTextField() {
  pressureTextField.enabled = false
  pressureTextField.hidden = true
}

function toggleTextField() {
  if (isCustomPressureSelected()) {
    enableCustomPressureTextField()
  } else {
    disableCustomPressureTextField()
  }
}

function isCustomPressureSelected() {
  return pressurePicker.value === "Custom"
}

function validateInput() {
  calculateButton.disabled = !isInputValid()
}

function isNumber(text) {
  try {
    let number = parseFloat(text)
    
    if (isNaN(number)) {
      return false
    }
    
    if (number < 0) {
      return false
    }
  } catch (e) {
    return false
  }
  
  return true
}

function isInputValid() {
  if (!isNumber(lengthTextField.value)) {
    return false
  }
  
  if (isCustomPressureSelected() && !isNumber(pressureTextField.value)) {
    return false
  }
  
  return true
}

function calculate() {
  let url = "/app/gasvo-web"
  let headers = new Headers({"Content-Type": "application/json"})
  let body = {
  nps: parseInt(npsPicker.value),
  length: parseFloat(lengthTextField.value),
  pressureSelection: pressurePicker.value,
  customPressure: pressureTextField.value
  }
  
  let options = {
  method: "POST",
  body: JSON.stringify(body),
  headers: headers
  }
  
  fetch(url, options)
  .then(response => response.json())
  .then(response => {
    resultParagraph.innerText = response.gasVolume
  })
  .catch(err => alert(`Error: ${err}`))
}

function setup() {
  // Register event listeners
  pressurePicker.addEventListener("change", toggleTextField)
  lengthTextField.addEventListener("input", validateInput)
  pressurePicker.addEventListener("input", validateInput)
  pressureTextField.addEventListener("input", validateInput)
  calculateButton.addEventListener("click", (e) => {
    e.preventDefault()
    calculate()
  })
  
  toggleTextField()
  validateInput()
}

const npsPicker = document.getElementById("npsPicker")
const lengthTextField = document.getElementById("lengthTextField")
const pressurePicker = document.getElementById("pressurePicker")
const pressureTextField = document.getElementById("pressureTextField");
const calculateButton = document.getElementById("calculateButton")
const resultParagraph = document.getElementById("result")

// Init
setup()
