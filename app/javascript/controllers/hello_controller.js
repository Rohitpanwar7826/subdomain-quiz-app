import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.addEventListener("turbo:before-fetch-response", function (e) {
      let frame = document.getElementById("form-plan");
    })    
  }
}
