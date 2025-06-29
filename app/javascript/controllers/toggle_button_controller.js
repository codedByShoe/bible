import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-button"
export default class extends Controller {
  dispatchSidebarToggle(event) {
    event.preventDefault()
    document.dispatchEvent(new CustomEvent("toggle-sidebar"))
  }

  dispatchSearchToggle(event) {
    event.preventDefault()
    document.dispatchEvent(new CustomEvent("toggle-search"))
  }
}
