import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["vatField", "select", "exemptTvaBlock"];

  connect() {
    console.log('VatApplicationController connected');
    this.toggleVatField();
    this.addEventListeners();
  }

  addEventListeners() {
    document.addEventListener('item-added', () => this.toggleVatField());
  }

  toggleVatField(event) {
    const selectedValue = event ? event.target.value : this.selectTarget.value;

    // Gérer le champ VAT unique
    if (selectedValue === 'taux_uniforme') {
      this.vatFieldTarget.style.display = 'block';
    } else {
      this.vatFieldTarget.querySelector("input").value = 0;
      this.vatFieldTarget.style.display = 'none';
    }

    // Itérer sur tous les blocs d'exemption de TVA si 'taux_variable' est sélectionné
    this.exemptTvaBlockTargets.forEach((exemptTvaBlock) => {
      if (selectedValue === 'taux_variable') {
        exemptTvaBlock.style.display = 'block';
      } else {
        exemptTvaBlock.style.display = 'none';
      }
    });
  }
}
