require 'singleton'
require 'sqlite3'
require_relative 'user'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follower'
require_relative 'question_like'
require_relative 'save'

class QuestionsDatabase < SQLite3::Database
  include Singleton
  def initialize
      # Tell the SQLite3::Database the db file to read/write.
      super('questions.db')

      # Typically each row is returned as an array of values; it's more
      # convenient for us if we receive hashes indexed by column name.
      self.results_as_hash = true

      # Typically all the data is returned as strings and not parsed
      # into the appropriate type.
      self.type_translation = true
    end
end