require 'singleton'
require 'sqlite3'
require_relative 'user'
require_relative 'question'
require_relative 'question_follower'
require_relative 'question_like'
require_relative 'questions'
require_relative 'save'

class Reply
  
  include Save
  attr_reader :id
  attr_accessor :body, :user_id
  
  def initialize(options = {})
    @id = options['id']
    @body = options['body']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
  end
  
  def self.find_by_id(id)
    query = <<-SQL
    SELECT 
      * 
    FROM 
      replies
    WHERE 
      id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, id).first
    return nil if results.nil?
    Reply.new(results)
  end
  
  def self.find_by_user_id(user_id)
    query = <<-SQL
    SELECT 
      * 
    FROM 
      replies
    WHERE 
      user_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, user_id)
    results.map do |result|
       Reply.find_by_id(result['id'])
    end
  end
  
  def self.find_by_question_id(question_id)
    query = <<-SQL
    SELECT 
      * 
    FROM 
      replies
    WHERE 
      question_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, question_id)
    results.map do |result|
       Reply.find_by_id(result['id'])
    end
  end
  
  def author
    User.find_by_id(user_id)
  end
  
  def question
    Question.find_by_id(question_id)
  end
  
  def parent_reply
    Reply.find_by_id(parent_id)
  end
  
  def child_replies
    query = <<-SQL
    SELECT 
      * 
    FROM 
      replies
    WHERE 
      parent_id = ?
    SQL
    
    results = QuestionsDatabase.instance.execute(query, id)
    results.map do |result|
       Reply.find_by_id(result['id'])
    end
  end
end