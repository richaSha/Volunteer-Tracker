_Volunteer Tracker_

#### _It will track all volunteer with projects _

#### By _**Richa Shaurbh**_

## Description

_It will unable user to add, delete , update and read volunteer and project deatils_

## Setup/Installation Requirements

* _Clone from github:
* _Open in browser of your choice_

## Specifications

* _It will save data in database_
    project_obj = Projects.new({:name => 'Alexa'})
    project_obj.save()
    projects_list = Projects.all()
* Example input: projects_list[0].name
* Example output: Alexa

* _It will ckeck for duplicate projects_
    project_obj = Projects.new({:name => 'Alexa'})
    project_obj.save()
* Example input: Projects.is_duplicate_project?('Alexa')
* Example output: true

* _It will delete project info_
    project_obj = Projects.new({:name => 'Alexa'})
    project_obj.save()
    Projects.delete(project_obj.id)
* Example input: Projects.all()
* Example output: []

* _It will update project info_
    project_obj = Projects.new({:name => 'Alexa'})
    project_obj.save()
    Projects.update({:id => project_obj.id, :name => 'Enact'})
    projects_list = Projects.all()
* Example input: projects_list[0].name
* Example output: Enact

## Known Bugs

_There are no known bugs at this time._

## Support and contact details

_If you run into any issues or have questions, ideas or concerns, or if you would like to contribute to the code, please contact: richa.shaurbh@gmail.com ._

## Technologies Used

_This application was created with Ruby_

### License
