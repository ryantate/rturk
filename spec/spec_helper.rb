SPEC_ROOT = File.expand_path(File.dirname(__FILE__)) unless defined? SPEC_ROOT
$: << SPEC_ROOT
$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'rspec'
require 'fakeweb'
require 'yaml'
require 'webmock'
include WebMock::API

require 'rturk'
# RTurk.log.level = Logger::DEBUG

@aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
RTurk.setup(@aws['AWSAccessKeyId'], @aws['AWSAccessKey'], :sandbox => true)

def faker(response_name, opts = {})
  response = File.read(File.join(SPEC_ROOT, 'fake_responses', "#{response_name.to_s}.xml"))
  if opts[:operation]
    stub_request(:post, /amazonaws.com/).with(:body => /Operation=#{opts[:operation]}/).to_return(:body => response)
  else
    stub_request(:post, /amazonaws.com/).to_return(:body => response)
  end
end

def fake_response(xml)
  mock('RestClientFakeResponse', :body => xml)
end

RSpec.configure do |config|

end

# The QuestionForm data structure is hella complicated, so we're just treating it as a string for now. This is
# from http://docs.amazonwebservices.com/AWSMechTurk/2008-08-02/AWSMturkAPI/ApiReference_QuestionFormDataStructureArticle.html#d0e18794
def example_question_form
  <<-XML
  <Overview>
    <Title>Game 01523, "X" to play</Title>
    <Text>
      You are helping to decide the next move in a game of Tic-Tac-Toe.  The board looks like this:
    </Text>
    <Binary>
      <MimeType>
        <Type>image</Type>
        <SubType>gif</SubType>
      </MimeType>
      <DataURL>http://tictactoe.amazon.com/game/01523/board.gif</DataURL>
      <AltText>The game board, with "X" to move.</AltText>
    </Binary>
    <Text>
      Player "X" has the next move.
    </Text>
  </Overview>
  <Question>
    <QuestionIdentifier>nextmove</QuestionIdentifier>
    <DisplayName>The Next Move</DisplayName>
    <IsRequired>true</IsRequired>
    <QuestionContent>
      <Text>
        What are the coordinates of the best move for player "X" in this game?
      </Text>
    </QuestionContent>
    <AnswerSpecification>
      <FreeTextAnswer>
        <Constraints>
          <Length minLength="2" maxLength="2" />
        </Constraints>
        <DefaultText>C1</DefaultText>
      </FreeTextAnswer>
    </AnswerSpecification>
  </Question>
  <Question>
    <QuestionIdentifier>likelytowin</QuestionIdentifier>
    <DisplayName>The Next Move</DisplayName>
    <IsRequired>true</IsRequired>
    <QuestionContent>
      <Text>
        How likely is it that player "X" will win this game?
      </Text>
    </QuestionContent>
    <AnswerSpecification>
      <SelectionAnswer>
        <StyleSuggestion>radiobutton</StyleSuggestion>
        <Selections>
          <Selection>
            <SelectionIdentifier>notlikely</SelectionIdentifier>
            <Text>Not likely</Text>
          </Selection>
          <Selection>
            <SelectionIdentifier>unsure</SelectionIdentifier>
            <Text>It could go either way</Text>
          </Selection>
          <Selection>
            <SelectionIdentifier>likely</SelectionIdentifier>
            <Text>Likely</Text>
          </Selection>
        </Selections>
      </SelectionAnswer>
    </AnswerSpecification>
  </Question>
  XML
end
