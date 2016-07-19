Given(/^a "([^"]*)" request is made to "([^"]*)"$/) do |method, path|
  # constructs URI with endpoint i.e http://api.bayqatraining.com/user
  @uri    = URI("#{$uri_hostname}#{path}")
  # @method is a variable that reference to the verb (i.e GET, POST)
  @method = method
end

When(/^these parameters are supplied in URL:$/) do |table|
  # flattens table parameters from feature file
  # into URI format i.e grant_type=client_credentials&client_id=23443334
    @uri.query = URI.encode_www_form(table.rows_hash)
end

Then(/^the api call should (succeed|fail)$/) do |condition|
  # picks which http verb to use bases on @method variable value
  case @method.downcase
    when 'get'
      method = Net::HTTP::Get
    when 'post'
      method = Net::HTTP::Post
    when 'put'
      method = Net::HTTP::Put
    when 'delete'
      method = Net::HTTP::Delete
    else
      raise "Please use correct verb!!!"
  end

  # start method immediately creates a connection to an HTTP server
  # which is kept open for the duration of the block
  Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do |http|
    # line 34 declares variable request and constructs HTTP object using method from case statement above, example:
    # Net::HTTP::Get.new(https://graph.facebook.com/oauth/access_token?)
    request = method.new(@uri)
    puts "Request method: #{@method.upcase}"
    puts "Request URI: #{@uri}"

    # 'http.request request' makes request, then saves response in instance variable, also measures response time
    @response = http.request request
    puts "Response status: #{@response.code} #{@response.message}"
  end

  puts "Response body: #{@response.body}"
  @response_body = @response.body

  # value of condition variable can be only succeed or failed which we specify in feature file
  case condition
    when 'succeed'
      # raises error message in terminal if response has error and response is NOT successful
      unless @response.is_a?(Net::HTTPSuccess) || @response.body['Error']
        raise 'Request failed, expected success'
      end
    when 'fail'
      # raises error message in terminal if response does NOT have error and response IS successful
      if @response.is_a?(Net::HTTPSuccess) && !@response.body['Error']
        raise 'Request succeeded, expected failure'
      end
  end
end

And(/^value of access token is saved in a global variable$/) do
  puts @access_token = @response_body.split("=").last
end