import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "type", "toggle"];

  connect() {
    this.restoreState();
  }

  selectType(event) {
    const selectedType = event.currentTarget.dataset.type;
    this.typeTarget.value = selectedType;
    this.updateActiveButton(selectedType);
    this.updateInputState();
  }

  updateActiveButton(selectedType) {
    this.toggleTargets.forEach(toggle => {
      toggle.classList.remove('active');
      if (toggle.dataset.discountUnit === selectedType) {
        toggle.classList.add('active');
      }
    });
  }

  updateInputState() {
    // Active ou désactive le champ de texte basé sur si un type est sélectionné
    this.inputTarget.disabled = !this.typeTarget.value;
  }

  restoreState() {
    // Restaure l'état des boutons et du champ de texte basé sur la valeur du champ caché
    const currentType = this.typeTarget.value;
    if (currentType) {
      this.updateActiveButton(currentType);
      this.updateInputState();
    } else {
      this.inputTarget.disabled = true;
    }
  }
}
