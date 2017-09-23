class Projects
  attr_reader :id
  attr_accessor :name
  def initialize(attribute)
    @name = attribute.fetch(:name)
    @id = attribute.key?(:id) ? attribute.fetch(:id) : nil
  end

  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{name}') RETURNING id;")
    @id = result[0]["id"]
  end

  def self.update(attribute)
    new_name = attribute.fetch(:name)
    id  = attribute.fetch(:id).to_i
    DB.exec("UPDATE projects SET name = '#{new_name}' WHERE id= #{id}; ")
  end

  def self.delete(id)
    DB.exec("DELETE FROM projects WHERE id= #{id}; ")
  end

  def self.all
    list = []
    projects = DB.exec("SELECT * FROM projects;")
    projects.each do |project|
      name = project.fetch("name")
      id = project.fetch("id")
      if !list.include?(name)
        project_obj = Projects.new({:name => name, :id=> id})
        list.push(project_obj)
      end
    end
    list
  end

  def self.all_peoject_name
    project_list = self.all()
    list = []
    project_list.each do |project|
      list.push(project.name)
    end
    list
  end

 def self.is_duplicate_project?(project_name)
   project_list = self.all()
   project_list.each do |project|
     if project.name == project_name
       return true
     end
   end
   false
 end

 def self.find_project(id)
   name = nil
   result = DB.exec("SELECT name FROM projects WHERE id = '#{id}'; ")
   if result.cmd_tuples != 0
     name =result[0]['name']
  else
    name = "NA"
  end
 end

 def self.find_id(name)
   id = nil
   result = DB.exec("SELECT id FROM projects WHERE name = '#{name}'; ")
   if result.cmd_tuples != 0
     id =result[0]['id']
  else
    id = "NA"
  end
  id
 end

end
