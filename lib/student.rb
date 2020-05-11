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
    
  def self.create(name, grade)
    s = self.new(name, grade)
    s.save
    s
  end 
  
  def self.new_from_db
    new_s = Student.new 
    new_s.id = row[0]
    new_s.name = row[1]
    new_s.grade = row[2]
    new_s
  end 
  
  def self.find_by_name(name)
    sql = "SELECT * FROM students WHERE name = ?"
    result = DB[:conn].execute(sql, name)[0]
    self.new(result[0], result[1], result[2])
  end
  
  
  attr_accessor :name, :grade, :id 
  
  
  def initialize(name, grade, id = nil)
    @name, @grade, @id = name, grade, id 
  end 
  
  def save
    if self.id 
      self.update
    else
      sql = <<-SQL
      INSERT INTO students(name, grade)
      VALUES(?,?)
      SQL
      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end 
  end
  
  def update
    sql = "UPDATE students SET name = ?, grade = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.grade, self.id)
  end 

end
