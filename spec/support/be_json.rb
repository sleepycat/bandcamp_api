require 'json'

RSpec::Matchers.define :be_json do |expected|
  match do |actual|
    begin
      JSON.parse actual
      true
    rescue JSON::ParserError
      false
    end
  end

  failure_message_for_should do |actual|
    "expected that #{actual} would be JSON"
  end

  failure_message_for_should_not do |actual|
    "expected that #{actual} would not be JSON"
  end

  description do
    "be JSON"
  end
end
