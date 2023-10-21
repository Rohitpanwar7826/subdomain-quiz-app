import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="questions"
export default class extends Controller {
  connect() {
    this.questionCount = 1;
  }

  handleNewFormQuestions  = async (e) => {
    e.preventDefault()
    
    const targetDomId = document.getElementById("add-question");
    const newNode = document.createElement("div")
    newNode.innerHTML=`
    <div class="bg-light shadow mt-2 p-2 mb-4" data-aos="fade-right" data-aos-duration="1500">
      <div class="mt-4 d-flex justify-content-center align-items-center bg-success">
        <h1 class="text-dark p-1">QUESTION - ${this.questionCount+1}</h1>
      </div>
      <div class="mb-3 p-3 bg-light">
        <label class="form-label" for="subdomain_quiz_questions_attributes_${this.questionCount}_question">Question</label>
        <input class="form-control" required="required" type="text" name="subdomain_quiz[questions_attributes][${this.questionCount}][question]"
          id="subdomain_quiz_questions_attributes_${this.questionCount}_question">
      </div>

      <div class="mb-3 p-3 bg-light">
        <label class="form-label" for="subdomain_quiz_questions_attributes_weight">Weight</label>
        <input class="form-control" required="required" type="text" name="subdomain_quiz[questions_attributes][${this.questionCount}][weight]"
          id="subdomain_quiz_questions_attributes_${this.questionCount}_weight">
       </div>

      <div class="mb-3 p-3 bg-light">
        <label class="form-label" for="subdomain_quiz_questions_attributes_${this.questionCount}_options_a">A</label>
        <input class="form-control" required="required" type="text"
          name="subdomain_quiz[questions_attributes][${this.questionCount}][options][a]" id="subdomain_quiz_questions_attributes_${this.questionCount}_options_a">

        <label class="form-label" for="subdomain_quiz_questions_attributes_${this.questionCount}_options_b">B</label>
        <input class="form-control" required="required" type="text"
          name="subdomain_quiz[questions_attributes][${this.questionCount}][options][b]" id="subdomain_quiz_questions_attributes_${this.questionCount}_options_b">

        <label class="form-label" for="subdomain_quiz_questions_attributes_${this.questionCount}_options_c">C</label>
        <input class="form-control" required="required" type="text"
          name="subdomain_quiz[questions_attributes][${this.questionCount}][options][c]" id="subdomain_quiz_questions_attributes_${this.questionCount}_options_c">

        <label class="form-label" for="subdomain_quiz_questions_attributes_${this.questionCount}_options_d">D</label>
        <input class="form-control" required="required" type="text"
          name="subdomain_quiz[questions_attributes][${this.questionCount}][options][d]" id="subdomain_quiz_questions_attributes_${this.questionCount}_options_d">
      </div>

      <div class="mb-3 p-3 bg-light">
        <label class="form-label" for="subdomain_quiz_questions_attributes_${this.questionCount}_correct">Correct</label>
        <select class="form-select" required="required" name="subdomain_quiz[questions_attributes][${this.questionCount}][correct]"
          id="subdomain_quiz_questions_attributes_${this.questionCount}_correct">
          <option value="">Select Correct Answer</option>
          <option value="A">Option A</option>
          <option value="B">Option B</option>
          <option value="C">Option C</option>
          <option value="D">Option D</option>
        </select>
      </div>
    </div>
    
    `
    this.questionCount+=1
    targetDomId.appendChild(newNode)
    window.scrollTo({
      top: document.body.scrollHeight,
      behavior: 'smooth'
    });
    ;
  }
}
