// app/javascript/controllers/provider_selection_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["providerField", "clientAndNumberField", "numberField"];

  connect() {
    this.toggleFields();
    this.updateNumberField();
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

  updateNumberField() {
    const providerId = this.providerFieldTarget.value;
    if (providerId) {
      fetch(`/admin/providers/${providerId}/next_devis_number`)
        .then(response => response.json())
        .then(data => {
          this.numberFieldTarget.value = data.next_number;
        });
    } else {
      this.numberFieldTarget.value = '';
    }
  }
}
