# Change "# require" to "#= require" as desired to include components
#
#= require zepto/dist/zepto
#= require underscore/underscore

questionCache = $('.question-cache')
questionList = $('.question-list')
questionReload = $('.refresh-questions button')

loadQuestions = () ->
  questionReload.attr('disabled', true)
  $.get questionCache.data('src'), (data) ->
    questions = $(data).children('li')
    questionCache.append(questions)
    selectQuestions()

selectQuestions = () ->
  questionList.empty()
  _.chain(questionCache.children('li'))
    .sample(questionList.data('length'))
    .each(insertQuestion)
  questionReload.removeAttr('disabled')

insertQuestion = (question) ->
  q = $(question).clone()
  q.addClass('question')
  q.children('ul')
    .addClass('answer')
  $('<div/>')
    .addClass('show-answer')
    .html('Show answer…')
    .insertBefore(q.find('.answer'))
  questionList.append(q)

questionReload.on 'click', () ->
  selectQuestions()

questionList.on 'click', '.show-answer', () ->
  $(this).hide().next('.answer').show()

loadQuestions()
