canon = require('pilot/canon')

koans = [
  "AboutExpects"
  "AboutFunctions"
  "AboutObjects"
  "AboutStrings"
  "AboutExistence"
  "AboutFlowControl"
  "AboutDestructuring"
  "AboutClasses"
  "AboutFatArrow"]

class KoanRouter extends Backbone.Router
  routes:
    "koan/:koan": "loadKoan"
    
  loadKoan: (koan)->
    koanRunner.loadKoan(koan)

class KoanSelectView extends Backbone.View
  
  events: 
    "change": "selectKoan"
  
  selectKoan: ->
    koanRouter.navigate("koan/#{@el.val()}", true)
    
  render: ->
    @el.html()
    @el.append("<option value='#{koan}'>#{koan}</option>") for koan in koans
      
class KoanRunnerView extends Backbone.View
  
  constructor: (options)->
    super options
    @editor = options.editor
    
  loadCurrentKoan: (index) ->
    @loadKoan(@koanIndex)
    
  loadKoan: (koan)->
    $.get "/koans/#{koan}.coffee", (data)=>
      @editor.setCode data
      @run()

  events:
    "click .try-it": "run"  
  
  zenProverbs: [
    "If you understand, things are just as they are; if you do not understand, things are just as they are."
    "From the withered tree, a flower blooms."
    "Do not seek the truth, only cease to cherish your opinions."
    "No snowflake ever falls in the wrong place."
    "Knock on the sky and Listen to the sound."
    "Only when you can be extremely pliable and soft can you be extremely hard and strong."
    "It takes a wise man to learn from his mistakes, but an even wiser man to learn from others."
    "To know and not do is not yet to know."
    "The infinite is in the finite of every instant."
    "The mind should be as a mirror."
    "Only the crystal clear question yields a transparent answer."
    "When an ordinary man gains knowledge, he is a sage; when a sage gains understanding, he is an ordinary man."
  ]

  randomZenProverb: ->
    _.shuffle(@zenProverbs)[0]
    
  koanCompleted: ->
    @$(".spec-results").html "<p>#{@randomZenProverb()}</p>"
    @$(".spec-results").append "<p>You have completed this koan.</p>"
    
  displaySuccess: (text) ->
    @$(".spec-results").append "<p><code>#{text}</code> has expanded your awareness.</p>"

  displayFailure: (spec) ->
    @$(".spec-results").append("<p class='error'>Consider <code>#{spec.description}</code>. It has damaged your karma:</p>")
    @$(".spec-results").append("<ul></ul>")
    for expectation in spec.results().getItems()
      @$("ul").append("<li>#{expectation.message}</li>") unless expectation.passed()
    @editor.find spec.description
    
  findInEditor: (text) ->
    @editor.find text

  run: (event) ->
    event.preventDefault() if event?
    @$(".spec-results").empty()
    @iframe.remove if @iframe?
    @iframe = $("<iframe id='sandbox' src='/sandbox'></iframe>").appendTo("body").load =>
      iframeWin = @iframe.get(0).contentWindow
      iframeWin.jasmine.getEnv().addReporter new iframeWin.CoffeeKoansReporter @
      iframeWin.eval CoffeeScript.compile(@editor.code(), { bare: true })
      iframeWin.jasmine.getEnv().execute()



class KoanEditor

  constructor: ->
    @editor = ace.edit("koan_editor")
    @editor.name = "koan_editor"
    @editor.setTheme("ace/theme/textmate")
    @editor.getSession().setTabSize(2)
    @editor.getSession().setUseSoftTabs(true)
    coffeeMode = require("ace/mode/coffee").Mode
    @editor.getSession().setMode new coffeeMode()
    canon.addCommand
      name: 'myCommand'
      bindKey:
          win: 'Ctrl-s'
          mac: 'Command-s'
          sender: 'editor'
      exec: (env, args, request) ->
        window.koanRunner.run()
    
  code: ->
    @editor.getSession().getValue()

  setCode: (code)->
    @editor.getSession().setValue code

  find: (text) -> @editor.find(text)

$ ->
  window.koanEditor = new KoanEditor()
  window.koanRunner = new KoanRunnerView(el: $("#koan_runner"), editor: koanEditor)
  window.koanRouter = new KoanRouter()
  window.koanSelect = new KoanSelectView(el: $("#koan_select"))
  window.koanSelect.render()
  Backbone.history.start()
  window.koanRouter.navigate("koan/AboutExpects", true)
  
  $('body').keydown (e)->
    if (e.which == 13 && (e.ctrlKey || e.metaKey))
      e.preventDefault()
      window.koanRunne.run()


  

