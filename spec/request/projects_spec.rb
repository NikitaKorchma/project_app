require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let!(:user) { create :user }
  let!(:project) { create :project, :public, user: user }

  before do
    sign_in user
  end

  it 'index action' do
    get projects_path
    expect(response).to have_http_status(200)
  end

  it 'new action' do
    get new_project_path
    expect(response).to have_http_status(200)
  end

  it 'edit action' do
    get edit_project_path(id: project.id)
    expect(response).to have_http_status(200)
  end

  it 'delete project' do
    delete project_path(id: project.id)
    expect(response).to redirect_to(root_path)
    expect(response).to have_http_status(302)
    expect(Project.count).to eq(0)
  end

  describe 'create project' do
    it 'with valid params' do
      post projects_path, params: { project: { logo: Rack::Test::UploadedFile.new('public/apple-touch-icon.png'),
                                               project_type: Project.project_types.keys.sample,
                                               name: Faker::TvShows::RickAndMorty.character,
                                               description: Faker::TvShows::RickAndMorty.quote } }
      expect(response).to have_http_status(302)
      expect(Project.count).to eq(2)
    end

    it 'with invalid params(without project type)' do
      post projects_path, params: { project: { name: Faker::TvShows::RickAndMorty.character,
                                               description: Faker::TvShows::RickAndMorty.quote } }
      expect(response).to have_http_status(302)
      expect(Project.count).to eq(1)
    end

    it 'with invalid params(with existing name)' do
      post projects_path, params: { project: { project_type: Project.project_types.keys.sample,
                                               name: project.name,
                                               description: Faker::TvShows::RickAndMorty.quote } }
      expect(response).to have_http_status(302)
      expect(Project.count).to eq(1)
    end
  end

  describe 'update project' do
    it 'with valid params' do
      description = Faker::TvShows::RickAndMorty.quote
      put project_path(id: project.id), params: { project: { description: description } }
      expect(project.reload.description).to eq(description)
      expect(response).to redirect_to(root_path)
      expect(response).to have_http_status(302)
    end

    it 'with invalid params(with name nil)' do
      name = project.name
      put project_path(id: project.id), params: { project: { name: nil } }
      expect(project.name).to eq(name)
      expect(response).to redirect_to(edit_project_path(id: project.id))
      expect(response).to have_http_status(302)
    end
  end
end
