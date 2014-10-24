# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer          not null
#  respondent_id    :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :answer_choice_id, presence: true
  validates :respondent_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_poll_author
  
  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )
  
  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :respondent_id,
    primary_key: :id
  )
  
  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )
  
  has_one(
    :author,
    through: :question,
    source: :author
  )
  
  def sibling_responses
    if persisted? 
      question.responses.where('responses.id != ?', self.id)
    else
      question.responses
    end
  end
    
  private
  
  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(respondent_id: respondent_id)
      errors[:response] << "cannot be submitted twice for the same question"
    end
  end
  
  def respondent_is_not_poll_author
    if respondent_id == author.id
      errors[:response] << "cannot be submitted by the poll author"
    end
  end
end
