// add pageTitle
const pageTitle = "My Shopping List";

// add groceries
const groceries = ["bread", "butter", "milk", "crackers", "cereal", "juice", "fruit", "condiments", "paperTowel", "napkins"];

/**
 * This function will get a reference to the title and set its text to the value
 * of the pageTitle variable that was set above.
 */
function setPageTitle() {
  document.getElementById("title").innerText = pageTitle;
  groceries.forEach;
}

/**
 * This function will loop over the array of groceries that was set above and add them to the DOM.
 */
function displayGroceries() {
  for(let i =0; i < groceries.length; i ++){
    const shoppingList = document.getElementById("groceries");
    const list = document.createElement("li");
    list.innerText = groceries[i];
    shoppingList.appendChild(list);
  }
}

/**
 * This function will be called when the button is clicked. You will need to get a reference
 * to every list item and add the class completed to each one
 */
function markCompleted() {
  const shopping = document.querySelectorAll("li");
  shopping.forEach(
    (item) => {
      item.setAttribute("class", "completed");
    }
  )
}

setPageTitle();

displayGroceries();

// Don't worry too much about what is going on here, we will cover this when we discuss events.
document.addEventListener('DOMContentLoaded', () => {
  // When the DOM Content has loaded attach a click listener to the button
  const button = document.querySelector('.btn');
  button.addEventListener('click', markCompleted);
});
