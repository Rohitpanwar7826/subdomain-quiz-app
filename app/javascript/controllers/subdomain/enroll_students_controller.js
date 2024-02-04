import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from '@rails/request.js'

// Connects to data-controller="subdomain--enroll-students"
export default class extends Controller {
  async requestForJoinOrNotJoinEnrollQuiz(e) {
    const request = new FetchRequest("POST", "/enroll_students", {
      body: JSON.stringify(
        { 
          subdomain_quiz_id: e.currentTarget.value }
        ), 
        responseKind: "turbo-stream"
      }
    )
    await request.perform()
  }
  connect() {
    const joinBtns = document.querySelectorAll("#join-btn")
    joinBtns.forEach((btn) => {
      btn.addEventListener("click", this.requestForJoinOrNotJoinEnrollQuiz)
    })
  }
  
}
