import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="subdomain--quizzes"
export default class extends Controller {
  connect() {
    this.element.click()
  }
}
