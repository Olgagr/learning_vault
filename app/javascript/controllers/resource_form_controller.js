import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="resource-form"
export default class extends Controller {
  static targets = ["ownedCheckbox", "priceFormGroup"];

  initialize() {
    if (this.ownedCheckboxTarget.checked) {
      this.priceFormGroupTarget.classList.remove("hidden");
    }
  }

  togglePriceFormGroup() {
    this.priceFormGroupTarget.classList.toggle("hidden");
    this.priceFormGroupTarget.querySelector("input").value = "";
  }
}
