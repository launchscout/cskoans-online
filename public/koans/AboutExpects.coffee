describe 'About Expects', ->
  # We shall contemplate truth by testing reality, via spec expectations.
  it 'should expect true', ->
    expect(false).toBeTruthy() # This should be true

  # Sometimes we will ask you to fill in the values
  it 'should have filled in values', ->
    expect(FILL_ME_IN).toEqual(1 + 1)

