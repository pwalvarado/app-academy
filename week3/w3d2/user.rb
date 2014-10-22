require 'singleton'
require 'sqlite3'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follower'
require_relative 'question_like'
require_relative 'questions'
require_relative 'save'

class User
  
  include Save
  attr_accessor :id, :fname, :lname
  
  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
  
  def self.find_by_id(id)
    query = <<-SQL
    SELECT 
      * 
    FROM 
      users
    WHERE 
      id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, id).first
    return nil if results.nil?
    User.new(results)
  end
  
  def self.find_by_name(fname, lname)
    query = <<-SQL
    SELECT 
      *
    FROM 
      users
    WHERE
      fname = ?
    AND
      lname = ?
    LIMIT
      1
    SQL
    
    results = QuestionsDatabase.instance.execute(query, fname, lname).first
    return nil if results.nil?
    User.new(results) 
  end
  
  def authored_questions
    Question.find_by_author_id(id)
  end
  
  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(id)
  end
  
  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end
  
  def average_karma
    query = <<-SQL
    SELECT 
      ((COUNT(question_likes.user_id)) / (CAST( (COUNT(DISTINCT questions.id)) AS FLOAT))) AS karma
    FROM 
        questions 
    LEFT OUTER JOIN 
      question_likes ON questions.id = question_likes.question_id
    WHERE
      questions.user_id = ?
    GROUP BY
        questions.user_id
    SQL
    
    QuestionsDatabase.instance.execute(query, id).first['karma']
  end
  
end
