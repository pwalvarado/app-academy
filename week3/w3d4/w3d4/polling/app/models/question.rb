# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :body, :presence => true
  validates :poll_id, :presence => true
  
  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )
  
  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )
  
  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )
  
  has_one(
    :author,
    through: :poll,
    source: :author,
  )
  
  def best_results
    responses = Hash.new(0)
    question_responses = Question.find_by_sql([
      "SELECT 
        a.*, COUNT(r.*) AS resp_count 
      FROM 
        answer_choices a 
      LEFT OUTER JOIN
        responses r
      ON 
        answer_choice_id = a.id
      WHERE
        a.question_id = ?
      GROUP BY 
        a.id", id])
    question_responses.each do |question_response|
      responses[question_response.body] = question_response.resp_count
    end
    
    responses
  end
  
  def better_results
    responses = Hash.new(0)
    answer_choices.includes(:responses).each do |answer_choice|
      responses[answer_choice.body] = answer_choice.responses.size
    end

    responses
  end
  
  def amazing_results
    responses = Hash.new(0)
    question_responses = self.answer_choices
      .select('answer_choices.*', 'COUNT(responses.*) AS resp_count')
      .joins( 'answer_choices LEFT OUTER JOIN responses ON
              answer_choice_id = answer_choices.id')
      .where(['answer_choices.question_id = ?', id])
      .group('answer_choices.id')
    
    question_responses.each do |question_response|
      responses[question_response.body] = question_response.resp_count
    end
    
    responses
  end
  
  

end