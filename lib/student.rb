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
  DB[:conn].execute(sql, self.name, self.grade)
  end 
  
  def self.create(name, grade)
    s = self.new(name, grade)
    s.save
    s
  end 
  
  def self.new_from_db
    new_s = self.new 
    new_s.id = row[0]
    new_s.name = row[1]
    new_s.grade = row[2]
    new_s
  end 
  
  def self.find_by_name(name)
    sql = "SELECT * FROM students WHERE name = ?"
    result = DB[:conn].execute(sql, name)[0]
    
  end

end
