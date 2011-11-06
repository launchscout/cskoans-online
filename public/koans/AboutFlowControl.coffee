describe 'About flow control in coffeescript', ->
  
  it "should let me put conditionals at the end of the line", ->
    today = "Monday"
    greeting = "Yay, time to write more code!" if today is "Monday"
    greeting = "Blarg, just another day" unless today is "Monday"
    greeting = "Well, at least it's not Wednesday" if today isnt "Wednesday"
    expect(greeting).toEqual FILL_ME_IN
    
  it "should use 'for' for simple iteration", ->
    numbers = [3..0] # a reverse range
    msg = ''
    tell = (num) -> if num > 0 then "#{num}, " else "Blastoff!"
    msg += tell i for i in numbers # 'for' gives an array comprehension

    expect(msg).toEqual(FILL_ME_IN)
    expect(numbers).toEqual(FILL_ME_IN)

  it 'should also use 'for' to do list comprehensions', ->
    numbers = [1..3]
    twice = (a) -> a * 2
    # simply place any function in front of 'for' for a map
    doubles = (twice x for x in numbers)

    expect(numbers).toEqual(FILL_ME_IN)
    expect(doubles).toEqual(FILL_ME_IN)
  
  it "should let me do while and until loops alse", ->
    num = 1
    while num < 5
      num += 1
    expect(num).toEqual(FILL_ME_IN)
    until num == 10
      num += 1
    expect(num).toEqual(FILL_ME_IN)
    
  it "should use 'in' to test inclusion", ->
    numbers = [1..3]

    expect(if 2 in numbers then true else false).toBe()

  it 'should let me use when to filter a list comprehension', ->
    numbers = [1..6]
    even = (a) -> if a % 2 == 0 then true else false
    odds = (x for x in numbers when not even x) # filter an array comprehension with 'when'

    expect(odds).toEqual(FILL_ME_IN)
    expect(odds.length).toBe(FILL_ME_IN)
    expect(numbers.length).toBe(FILL_ME_IN)


