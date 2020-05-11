require_relative "../config/environment.rb"

class Student
  
  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    SQL
    DB[:conn].execute(sql)
    
  end 
  attr_accessor :name, :grade, :id 
  
  def initialize(name:, grade:, id: nil)
    @name, @grade, @id = name, grade, id 
  end 
  
  def save 
    
  end 


end
