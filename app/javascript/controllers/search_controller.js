import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "overlay", "results"]
  connect() {
    this.searchOpen = false
    this.handleToggle = this.toggle.bind(this)
    document.addEventListener("toggle-search", this.handleToggle)
  }

  disconnect() {
    document.removeEventListener("toggle-search", this.handleToggle)
  }

  toggle() {
    this.searchOpen = !this.searchOpen
    if (this.searchOpen) {
      this.overlayTarget.classList.remove("hidden")
      this.inputTarget.focus()
    } else {
      this.overlayTarget.classList.add("hidden")
    }
  }
}
