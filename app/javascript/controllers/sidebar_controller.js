import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = ["panel"]
  connect() {
    this.sidebarOpen = false

    this.handleToggle = this.toggle.bind(this)
    document.addEventListener("toggle-sidebar", this.handleToggle)
  }

  disconnect() {
    document.removeEventListener("toggle-sidebar", this.handleToggle)
  }

  toggle() {
    this.sidebarOpen = !this.sidebarOpen
    if (this.sidebarOpen) {
      this.panelTarget.classList.remove("-translate-x-full")
      this.panelTarget.classList.add("sidebar-enter")
    } else {
      this.panelTarget.classList.add("-translate-x-full")
      this.panelTarget.classList.remove("sidebar-enter")
    }
  }
}
