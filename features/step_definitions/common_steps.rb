def json_parse
  @parsed_response = JSON.parse(@response_body)
end

Given(/^get app access token$/) do
steps %Q{
    Given a request is made to "/oauth/access_token"
    When these parameters are supplied in URL:
      |grant_type    | client_credentials               |
      |client_id     | 931957476934241                  |
      |client_secret | 68b3a63cfb0a6e961978ddd205e005f2 |
    Then the GET api call should succeed
    And value of access token is saved in a global variable
}
end

Given /^I create test (.*)$/ do |user|
  steps %Q{
    Given a request is made to "/{client_id}/accounts/test-users"
    When these parameters are supplied in URL:
      |installed       | true              |
      |access_token    |                   |
      |permissions     | read_stream,publish_actions,user_posts |
    And I make test Facebook #{user}
  }
end

Given(/^a request is made to "([^"]*)"$/) do |path|
  # constructs URI with endpoint i.e http://api.bayqatraining.com/user

  if path.include?('{')
    path_variable = path[/{(.+)}/, 1]

    if FACEBOOK_STORE.has_key? path_variable
      path.gsub!(/{.*}/, FACEBOOK_STORE[path_variable])
    end

    if path_variable.include? "user"
      path.gsub!(/{.*}/, $users[path_variable].id)
      @user = $users[path_variable]
    end
  end

  @uri    = URI("#{$uri_hostname}#{path}")
  # @method is a variable that reference to the verb (i.e GET, POST)
end

When(/^these parameters are supplied in URL:$/) do |table|
  # flattens table parameters from feature file
  # into URI format i.e grant_type=client_credentials&client_id=23443334
  request_parameters = table.rows_hash
  if request_parameters.has_key? "access_token"
    request_parameters["access_token"] = @app_access_token
  elsif request_parameters.has_key? "user_access_token"
    request_parameters["access_token"] = @user.user_access_token
  end

  @uri.query = URI.encode_www_form(request_parameters)
end

Then(/^the ([^"]*) api call should (succeed|fail)$/) do |method, condition|
  response = Server.new(method, condition, @uri)
  response.facebook_response
  @response_body = response.response_body
end

And(/^value of access token is saved in a global variable$/) do
  @app_access_token = @response_body.split("=").last
end

And /^I make test Facebook (.*)$/ do |user|
  step "the POST api call should succeed"
  $users[user] = FacebookUser.new json_parse
  $ids << $users[user].id
end

Given(/^delete all test users$/) do
  $ids.each do |id|
    uri = URI.parse(URI.encode("#{$uri_hostname}/#{id}?access_token=#{@app_access_token}"))
    response = Server.new("DELETE", "succeed", uri)
    response.facebook_response
  end
  $users = nil
  $ids = nil
end
