# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, :presence => true, :uniqueness => true
  
  has_many(
    :authored_polls,
    class_name: 'Poll',
    foreign_key: :author_id,
    primary_key: :id
  )
  
  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :respondent_id,
    primary_key: :id
  )
  def completed_polls
    question_and_answer_counts = {}
    
    polls_question_counts = Poll.find_by_sql([<<-SQL, id])
      SELECT
        polls.*, COUNT(DISTINCT questions.id) AS questions_count, 
        COUNT(DISTINCT responses.id) AS user_response_count
      FROM
        polls
      JOIN
        questions
      ON
        polls.id = questions.poll_id
      JOIN
        answer_choices on answer_choices.question_id = questions.id
      LEFT OUTER JOIN
        responses on responses.answer_choice_id = answer_choices.id
      WHERE
        responses.respondent_id IS NULL or responses.respondent_id = ?
      GROUP BY
        polls.id
      SQL
      
    polls_question_counts.each do |poll|
      question_and_answer_counts[poll] =
        [poll.questions_count, poll.user_response_count]
    end
    question_and_answer_counts.select do |poll, count_array|
      count_array.first == count_array.last
    end.keys
    question_and_answer_counts
  end
  
  # def completed_polls2
#
#     Poll.select('polls.*, COUNT(questions.*) AS questions_count,
#     COUNT(answer_choice_and_response.respondent_id) AS user_response_count')
#     .joins('polls JOIN questions ON polls.id = questions.poll_id')
#     .joins('answer_choices ON answer_choices.question_id = questions.id')
#
#     # polls_question_counts = Poll.find_by_sql(['
#  #      SELECT
#  #        polls.*, COUNT(questions.*) AS questions_count,
#  #        COUNT(answer_choice_and_response.respondent_id) AS user_response_count
#  #      FROM
#  #        polls
#  #      JOIN
#  #        questions
#  #      ON
#  #        polls.id = questions.poll_id
#  #      LEFT OUTER JOIN
#  #        (
#  #        SELECT
#  #          *
#  #        FROM
#  #          answer_choices
#  #        JOIN
#  #          responses
#  #        ON
#  #          answer_choices.id = responses.answer_choice_id
#  #        WHERE
#  #          responses.respondent_id = ?
#  #        ) AS answer_choice_and_response
#  #      ON
#  #        questions.id = answer_choice_and_response.question_id
#  #      GROUP BY
#  #        polls.id
#  #      HAVING
#  #        COUNT(questions.*) = COUNT(answer_choice_and_response.respondent_id)
#  #    ', id])
#
#
#  .select('answer_choices.*', 'COUNT(responses.*) AS resp_count')
#  .joins('answer_choices LEFT OUTER JOIN responses ON
#          answer_choice_id = answer_choices.id')
#  .where(['answer_choices.question_id = ?', id])
#  .group('answer_choices.id')
#
#   end
  
end
