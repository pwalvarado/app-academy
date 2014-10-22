require 'singleton'
require 'sqlite3'
require_relative 'user'
require_relative 'reply'
require_relative 'question_follower'
require_relative 'question_like'
require_relative 'questions'
require_relative 'save'

class Question
  
  include Save
  attr_reader :id
  attr_accessor :title, :body, :user_id
  
  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end
  
  def self.find_by_id(id)
    query = <<-SQL
    SELECT 
      * 
    FROM 
      questions
    WHERE 
      id = ?
    LIMIT
        1
    SQL

    results = QuestionsDatabase.instance.execute(query, id).first
    return nil if results.nil?
    Question.new(results)
  end
  
  def self.find_by_author_id(author_id)
    query = <<-SQL
    SELECT 
      * 
    FROM 
      questions
    WHERE 
      id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, author_id)
    results.map do |result|
      Question.find_by_id(result['id'])
    end
  end
  
  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end
  
  def author
    User.find_by_id(user_id)
  end
  
  def replies
    Reply.find_by_question_id(id)
  end
  
  def followers
    QuestionFollower.followers_for_question_id(id)
  end
  
  def likers
    QuestionLike.likers_for_question_id(id)
  end
  
  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end
  
  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
  
end