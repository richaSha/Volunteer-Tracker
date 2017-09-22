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
  id = params[:id]
  @project_name = Projects.find_project(id.to_i)
  @volunteers_list = Volunteers.find_volunteers_info(id.to_i)
  erb(:project_info)
end
