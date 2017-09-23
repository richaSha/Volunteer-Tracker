require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'home page', {:type => :feature} do
  it 'home page should Volunteer and project list button' do
    visit('/')
    expect(page).to have_content('Projects')
  end
end

describe('Project List Page', {:type => :feature}) do
  it('Project List Page should have list of project') do
    visit('/')
    click_link('Projects')
    expect(page).to have_content('Project List')
  end
end

describe('Volunteer List Page', {:type => :feature}) do
  it('Volunteers List Page should have list of volunteer') do
    visit('/')
    click_link('Volunteers')
    expect(page).to have_content('Volunteer List')
  end
end

describe('Breadcrumb', {:type => :feature}) do
  it('Volunteers List Page should have Breadcrumb') do
    visit('/')
    expect(page).to have_content('Home')
  end
end
