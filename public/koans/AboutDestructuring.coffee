describe "destructuring assignment", ->
  it 'should understand destructuring assignment', ->
    weatherReport = (location) -> [location, 22, 'Mostly sunny']
    [city, temperature, forecast] = weatherReport 'London'
    expect(city).toBe(FILL_ME_IN)
    expect(temperature).toBe(FILL_ME_IN)

  it 'should understand destructuring works with splats', ->
    phrase = 'Now is the time for all good men to come to the aid of the Party'
    [start, middle..., end] = phrase.split ' '
    expect(start).toBe(FILL_ME_IN)
    expect(end).toBe(FILL_ME_IN)
