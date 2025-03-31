import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["dialog"];

  initialize() {
    this.modal = this.element;
    this.element.addEventListener("turbo:frame-load", () => {
      this.open();
    });
  }

  open() {
    this.dialogTarget.showModal();
  }

  close() {
    this.dialogTarget.close();
    this.element.removeAttribute("src");
    this.element.innerHTML = "";
  }

  formSubmit(event) {
    if (event.detail.success) {
      this.close();
    }
  }
}
