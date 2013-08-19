class ExampleQuestionForm < RTurk::QuestionForm
  def question_form_content
    Overview do
      Title do
        text 'Game 01523, "X" to play'
      end
      Text do
        text 'You are helping to decide the next move in a game of Tic-Tac-Toe.  The board looks like this:'
      end
      Binary do
        MimeType do
          Type do
            text 'image'
          end
          SubType do
            text 'gif'
          end
        end
        DataURL do
          text 'http://tictactoe.amazon.com/game/01523/board.gif'
        end
        AltText do
          text 'The game board, with "X" to move.'
        end
      end
      Text do
        text 'Player "X" has the next move.'
      end
    end
    Question do
      QuestionIdentifier do
        text 'nextmove'
      end
      DisplayName do
        text 'The Next Move'
      end
      IsRequired do
        text 'true'
      end
      QuestionContent do
        Text do
          text 'What are the coordinates of the best move for player "X" in this game?'
        end
      end
      AnswerSpecification do
        FreeTextAnswer do
          Constraints do
            Length :minLength => '2', :maxLength => '2'
          end
          DefaultText do
            text 'C1'
          end
        end
      end
    end
    Question do
      QuestionIdentifier do
        text 'likelytowin'
      end
      DisplayName do
        text 'The Next Move'
      end
      IsRequired do
        text 'true'
      end
      QuestionContent do
        Text do
          text 'How likely is it that player "X" will win this game?'
        end
      end
      AnswerSpecification do
        SelectionAnswer do
          StyleSuggestion do
            text 'radiobutton'
          end
          Selections do
            Selection do
              SelectionIdentifier do
                text 'notlikely'
              end
              Text do
                text 'Not likely'
              end
            end
            Selection do
              SelectionIdentifier do
                text 'unsure'
              end
              Text do
                text 'It could go either way'
              end
            end
            Selection do
              SelectionIdentifier do
                text 'likely'
              end
              Text do
                text 'Likely'
              end
            end
          end
        end
      end
    end
  end
end
