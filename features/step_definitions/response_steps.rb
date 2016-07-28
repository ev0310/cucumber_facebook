And(/^these response keys should have value:$/) do |table|
  # Parse the JSON document _source_ into a Ruby HashMap data structure and return it
  # i.e table = {"id"=>108, "name"=>"Andrei", "email"=>"andrei9@gmail.com"}

  table.raw.each do |row|
    # go through each row in table from feature file
    # match that first row from server response is equal to first row from table in feature file
    # name"=>"Andrei" == "name", "Andrei"
    expect(json_parse['data'][0][row[0]]).to be == row[1]
  end
end

Then /^these response keys (should|should not) be nil:$/ do |should, table|

  if should == 'should not'
    condition = :not_to
  else
    should == 'should'
    condition = :to
  end

  table.raw.each do |row|
     expect(json_parse['data'][0][row[0]]).send(condition, be_nil)
  end
end