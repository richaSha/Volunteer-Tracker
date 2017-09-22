require "spec_helper"

describe('#volunteer_tracker') do
  describe('#projects') do
    it("will return empty array") do
      expect(Projects.all()).to(eq([]))
    end

    it("will save data in database") do
      project_obj = Projects.new({:name => 'Alexa'})
      project_obj.save()
      projects_list = Projects.all()
      expect(projects_list[0].name).to(eq('Alexa'))
    end

    it("will ckeck for duplicate projects") do
      project_obj = Projects.new({:name => 'Alexa'})
      project_obj.save()
      expect(Projects.is_duplicate_project?('Alexa')).to(eq(true))
    end

    it("will delete project info") do
      project_obj = Projects.new({:name => 'Alexa'})
      project_obj.save()
      Projects.delete(project_obj.id)
      expect(Projects.all()).to(eq([]))
    end

    it("will update project info") do
      project_obj = Projects.new({:name => 'Alexa'})
      project_obj.save()
      Projects.update({:id => project_obj.id, :name => 'Enact'})
      projects_list = Projects.all()
      expect(projects_list[0].name).to(eq('Enact'))
    end
  end

  describe('#volunteers') do
    it("will return empty array") do
      expect(Projects.all()).to(eq([]))
    end
  end





end
