import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tva", "checkbox"]
  previousTvaValue = 0

  connect() {
    if (this.checkboxTarget.checked) {
      this.previousTvaValue = this.tvaTarget.querySelector("input").value;
      this.tvaTarget.querySelector("input").value = 0;
      this.tvaTarget.classList.add("d-none");
    } else {
      this.previousTvaValue = this.tvaTarget.querySelector("input").value;
    }
  }

  toggleTVA() {
    const tvaInput = this.tvaTarget.querySelector("input") || this.tvaTarget;

    if (this.checkboxTarget.checked) {
      console.log("checked");
      this.previousTvaValue = tvaInput.value;
      tvaInput.value = 0;
      this.tvaTarget.classList.add("d-none");
    } else {
      console.log("unchecked");
      tvaInput.value = this.previousTvaValue;
      this.tvaTarget.classList.remove("d-none");
    }
  }
}
