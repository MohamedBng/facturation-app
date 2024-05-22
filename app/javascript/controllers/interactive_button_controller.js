import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.updateButtonStates();
  }

  toggle(event) {
    event.preventDefault();
    const button = event.currentTarget;
    const checkboxId = button.getAttribute('for');

    if (!checkboxId) {
      console.error('No checkbox ID found for button:', button.outerHTML);
      return;
    }

    const checkbox = document.getElementById(checkboxId);
    if (!checkbox) {
      console.error('Checkbox not found with ID:', checkboxId);
      return;
    }

    checkbox.checked = !checkbox.checked;
    this.updateButtonState(button, checkbox.checked);
  }

  updateButtonStates() {
    const buttons = this.element.querySelectorAll('[data-action="click->interactive-button#toggle"]');
    buttons.forEach(button => {
      const checkboxId = button.getAttribute('for');
      const checkbox = document.getElementById(checkboxId);
      if (checkbox) {
        this.updateButtonState(button, checkbox.checked);
      }
    });
  }

  updateButtonState(button, checked) {
    if (checked) {
      button.classList.add('btn-primary');
      button.classList.remove('btn-outline-primary');
    } else {
      button.classList.add('btn-outline-primary');
      button.classList.remove('btn-primary');
    }
  }
}
