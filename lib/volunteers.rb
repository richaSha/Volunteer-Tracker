class Volunteers
  attr_reader :id
  attr_accessor :name, :project_id, :hour
  def initialize(attribute)
    @id = (attribute.key?(:id) ?  attribute.fetch(:id) : nil)
    @project_id = (attribute.key?(:project_id) ?  attribute.fetch(:project_id) : 0)
    @name = attribute.fetch(:name)
    @hour = (attribute.key?(:hour) ?  attribute.fetch(:hour) : '0')
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, hour, project_id) VALUES ('#{name}', '#{hour}', #{project_id}) RETURNING id;")
    @id = result[0]["id"]
  end

  def self.all
    list = []
    projects = DB.exec("SELECT * FROM volunteers;")
    projects.each do |project|
      name = project.fetch("name")
      id = project.fetch("id")
      hour = project.fetch("hour")
      project_id = project.fetch("project_id")
      if !list.include?(name)
        project_obj = Projects.new({:name => name, :id=> id, :project_id => project_id, :hour => hour})
        list.push(project_obj)
      end
    end
    list
  end

  def self.all_valunteer_name
    valunteer_list = self.all()
    list = []
    valunteer_list.each do |valunteer|
      list.push(valunteer.name)
    end
    list
  end

  def self.add_project(name,project_id)
    DB.exec("UPDATE volunteers SET project_id = #{project_id} WHERE name = '#{name}';")
  end

  def self.add_hour(name,hour)
    DB.exec("UPDATE volunteers SET hour = #{hour} WHERE name = '#{name}';")
  end

  def self.find_project_id(name)
    result = DB.exec("SELECT project_id FROM volunteers WHERE name = '#{name}'; ")
    result[0]['project_id']
  end

  def self.find_volunteers(id)
    result = DB.exec("SELECT * FROM volunteers WHERE id = '#{id}'; ")
    result[0]
  end

  def self.find_id(name)
    result = DB.exec("SELECT id FROM volunteers WHERE name = '#{name}'; ")
    result[0]['id']
  end

  def self.find_volunteers_info(project_id)
    DB.exec("SELECT * FROM volunteers WHERE project_id = '#{project_id}'; ")
  end

  def self.update(attribute)
    new_name = attribute.fetch(:name)
    hour = attribute.fetch(:hour)
    project_id = attribute.fetch(:project_id)
    id  = attribute.fetch(:id).to_i
    DB.exec("UPDATE volunteers SET name = '#{new_name}',hour = '#{hour}', project_id = #{project_id}  WHERE id= #{id}; ")
  end

  def self.update_by_project_id(name)
    id =project_id.to_i
    DB.exec("UPDATE volunteers SET project_id = 0  WHERE name = #{name}; ")
  end

  def self.delete(name)
    DB.exec("DELETE FROM volunteers WHERE name = '#{name}';")
  end

  def self.is_duplicate_volunteer?(name)
    project_list = self.all()
    project_list.each do |project|
      if project.name == name
        return true
      end
    end
    false
  end

end
