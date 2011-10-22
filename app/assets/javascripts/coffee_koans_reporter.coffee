class CoffeeKoansReporter
  constructor: (@koanRunner)->
    
  reportRunnerStarting: (runner) ->
    @runner = runner
    
  reportSpecResults: (spec) ->
    return if @failed
    if spec.results().failedCount > 0
      @koanRunner.displayFailure spec
      @failed = true
    else 
      @koanRunner.displaySuccess spec.description
  
  reportRunnerResults: (runner) ->
    if !@failed
      @koanRunner.koanCompleted()

      
window.CoffeeKoansReporter = CoffeeKoansReporter
window.FILL_ME_IN = "FILL_ME_IN"
    
