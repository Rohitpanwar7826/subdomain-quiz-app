import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from '@rails/request.js'

// Connects to data-controller="subdomain--count-down-timer"
export default class extends Controller {

  connect() {
    
    const quizStartTime = new Date(this.data.get("timer")).getTime();
    // const quizStartTime = new Date("2023-10-07 18:10:00 +0530").getTime();
    const quizId = this.data.get("quiz-id");

    var timerObj = setInterval(function() {
    const now = new Date().getTime();
    const distance = quizStartTime - now;

    const days = Math.floor(distance / (1000 * 60 * 60 * 24));
    const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((distance % (1000 * 60)) / 1000);

    if (distance < 0) {
      clearInterval(timerObj);
      document.getElementById("countdown").innerHTML = "Quiz has started!";
      const request = new FetchRequest("post", `/exams/${quizId}/base_line_assessment`, {
        responseKind: "turbo-stream"
      })
    request.perform()
    }else {
      document.getElementById("countdown").innerHTML = `${days}d ${hours}h ${minutes}m ${seconds}s`;
    }
  }, 1000);
    
  }

  disconnect() {
    clearInterval(this.timerObj);
  }



}
