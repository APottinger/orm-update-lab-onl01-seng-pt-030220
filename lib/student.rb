require_relative "../config/environment.rb"

class Student
  
  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    SQL
    DB[:conn].execute(sql)
  end 
  
  def self.drop_table
    sql = <<-SQL 
    DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end 
  
  attr_accessor :name, :grade, :id 
  
  def initialize(name:, grade:, id: nil)
    @name, @grade, @id = name, grade, id 
  end 
  
  def save
    sql = <<-SQL
    INSERT INTO cats(name, grade)
    VALUES(?,?)
  SQL
  DB[:conn].execute(sql)
    
  end 


end
