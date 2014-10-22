require 'singleton'
require 'sqlite3'
require_relative 'user'
require_relative 'question'
require_relative 'reply'
require_relative 'question_like'
require_relative 'questions'
require_relative 'save'

class QuestionFollower
  
  include Save
  attr_reader :id
  attr_accessor :user_id, :question_id
  
  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
  
  def self.find_by_id(id)
    query = <<-SQL
    SELECT 
      * 
    FROM 
      question_followers
    WHERE 
      id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, id).first
    return nil if results.nil?
    QuestionFollower.new(results)
  end
  
  def self.followers_for_question_id(question_id)
    query = <<-SQL
    SELECT 
      users.*
    FROM 
      users
    INNER JOIN 
      question_followers 
    ON 
      users.id = question_followers.user_id
    WHERE 
      question_followers.question_id = ?
    SQL
    
    results = QuestionsDatabase.instance.execute(query, question_id)
    results.map do |result|
      User.new(result)
    end
  end
  
  def self.followed_questions_for_user_id(user_id)
    query = <<-SQL
    SELECT 
      questions.*
    FROM 
      questions
    INNER JOIN 
      question_followers 
    ON 
      questions.id = question_followers.question_id
    WHERE 
      question_followers.user_id = ?
    SQL
    
    results = QuestionsDatabase.instance.execute(query, user_id)
    results.map do |result|
      Question.new(result)
    end
  end
  
  def self.most_followed_questions(n)
    query = <<-SQL
    SELECT 
      *
    FROM
      questions
    JOIN (
      SELECT 
        question_id
      FROM
        question_followers
      GROUP BY
        question_id
      ORDER BY
        COUNT(user_id) DESC
      LIMIT
        ?
      ) AS ordered_questions
    ON
      questions.id = ordered_questions.question_id  
    SQL
    
    results = QuestionsDatabase.instance.execute(query, n)
    results.map do |result|
      Question.new(result)
    end
  end
  
end
