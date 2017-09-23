require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/projects")
require("./lib/volunteers")
require("pg")
require("pry")

DB = PG.connect({:dbname => "volunteer_tracker"})

get("/") do
  erb(:index)
end

get("/project") do
  @project_list = Projects.all()
  erb(:project)
end

get("/project/:id") do
  @id = params[:id]
  @project_name = Projects.find_project(@id.to_i)
  @volunteers_list = Volunteers.find_volunteers_info(@id.to_i)
  erb(:project_info)
end

get("/project/add/:id") do
  @id = params[:id]
  @project_name = Projects.find_project(@id.to_i)
  @volunteers_list = Volunteers.find_volunteers_info(0)
  erb(:add_project_info)
end

patch("/project/add/:id") do
  @id = params[:id]
  name = params.fetch('name')
  volunteer_id = Volunteers.find_id(name)
  hour = (params.has_key?('hour') ? params.fetch('hour') : 0)
  Volunteers.update({:name => name, :project_id => @id, :hour => hour , :id => volunteer_id})
  @project_name = Projects.find_project(@id.to_i)
  @volunteers_list = Volunteers.find_volunteers_info(@id.to_i)
  erb(:project_info)
end

get("/project/edit/:id") do
  @id = params[:id]
  @project_name = Projects.find_project(@id.to_i)
  @volunteers_list = Volunteers.find_volunteers_info(@id.to_i)
  erb(:edit_project)
end

patch("/project/:id") do
  @id = params[:id]
  @volunteers_list = Volunteers.find_volunteers_info(@id.to_i)
  new_project = params.fetch('project')
  Projects.update(:name => new_project, :id=> @id)
  @volunteers_list.each do |volunteer|
    new_hour = params.fetch('hour/' + volunteer['id'])
    volunteer_name = params.fetch("volunteer_name/" + volunteer['id'])
    Volunteers.update({:name => volunteer_name, :project_id => @id, :hour => new_hour , :id => volunteer['id']})
  end
  @project_name = Projects.find_project(@id.to_i)
  @volunteers_list = Volunteers.find_volunteers_info(@id.to_i)
  erb(:project_info)
end

get("/project/delete/:id") do
  @id = params[:id]
  @project_name = Projects.find_project(@id.to_i)
  @volunteers_list = Volunteers.find_volunteers_info(@id.to_i)
  erb(:delete_project_info)
end

get("/project/del/:name") do
  volunteers_name = params[:name]
  @id = Volunteers.find_project_id(volunteers_name)
  Volunteers.add_project(volunteers_name, 0)
  @project_name = Projects.find_project(@id.to_i)
  @volunteers_list = Volunteers.find_volunteers_info(@id.to_i)
  erb(:project_info)
end

get("/delete/project") do
  @project_list = Projects.all()
  erb(:delete_projects)
end

delete("/") do
  id =params.fetch("id")
  Projects.delete(id)
  Volunteers.update_by_project_id(id.to_i)
  @project_list = Projects.all()
  erb(:project)
end

get("/add/project") do
  if params.has_key?('project')
    project = params.fetch('project')
    project_obj = Projects.new({:name => project})
    project_obj.save()
    @project_list = Projects.all()
    erb(:project)
  else
    erb(:add_project)
  end
end

get("/volunteer") do
  @volunteer_list = Volunteers.all()
  erb(:volunteers)
end

get("/add/volunteer") do
  if params.has_key?('volunteer')
    name = params.fetch('volunteer')
    if !Volunteers.is_duplicate_volunteer?(name)
      volunteer_obj = Volunteers.new({:name => name})
      volunteer_obj.save()
    end
    @volunteer_list = Volunteers.all()
    erb(:volunteers)
  else
    erb(:add_volunteer)
  end
end

get("/delete/volunteer") do
  @volunteer_list = Volunteers.all()
  erb(:delete_volunteer)
end

delete("/valunteer") do
  name =params.fetch("name")
  Volunteers.delete(name)
  @volunteer_list = Volunteers.all()
  erb(:volunteers)
end

get("/volunteer/:id") do
  id = params[:id].to_i
  @list = Volunteers.find_volunteers(id)
  @project = Projects.find_project(@list['project_id'].to_i)
  erb(:volunteer_info)
end

get("/search") do
  search = params.fetch("search")
  valunteer_list = Volunteers.all_valunteer_name
  project_list = Projects.all_peoject_name
  if project_list.include?(search)
    @project_name = search
    @id = Projects.find_id(search)
    @volunteers_list = Volunteers.find_volunteers_info(@id.to_i)
    erb(:project_info)
  elsif valunteer_list.include?(search)
    id = Volunteers.find_id(search)
    @list = Volunteers.find_volunteers(id)
    @project = Projects.find_project(@list['project_id'].to_i)
    erb(:volunteer_info)
  end
end
