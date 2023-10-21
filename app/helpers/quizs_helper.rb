module QuizsHelper
  def generate_published_according(quiz)
    quiz_html = quiz.is_published ? '<span class="bg-success text-white my-auto btn"> ACTIVE </span>' : '<span class="bg-danger my-auto btn text-white"> In-Active </span>'
    quiz_html.html_safe
  end
end
