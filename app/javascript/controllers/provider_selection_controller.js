import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["providerField", "clientAndNumberField", "numberField"];

  connect() {
    this.toggleFields();
    if (this.modeValue === 'new') {
      this.updateNumberField();
    }
  }

  toggleFields() {
    const providerId = this.providerFieldTarget.value;
    const clientAndNumberField = this.clientAndNumberFieldTarget;

    if (providerId) {
      clientAndNumberField.style.display = "block";
    } else {
      clientAndNumberField.style.display = "none";
    }
  }
}
