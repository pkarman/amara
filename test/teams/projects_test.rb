# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

require 'amara/api'
require 'amara/teams'
require 'amara/teams/projects'

require 'webmock/minitest'

describe Amara::Teams::Projects do

  it "gets the base path for this subclass of API" do
    teams = Amara::Teams::Projects.new(team_id: 'test-team')
    teams.base_path.must_equal 'teams/test-team/projects'

    teams = Amara::Teams::Projects.new(team_id: 'test-team', project_id: 'test-project')
    teams.base_path.must_equal 'teams/test-team/projects/test-project'
  end

  it "gets a list of projects for a team" do

    first_response = '{"meta": {"limit": 2, "next": "/api2/partners/teams/test-team/projects/?limit=2&offset=2", "offset": 0, "previous": null, "total_count": 5}, "objects": [{"created": "2013-02-14T07:29:55"}, {"created": "2011-03-01T11:38:16"}]}'

    stub_request(:get, "https://www.amara.org/api2/partners/teams/test-team/projects/?limit=2&offset=0").
      with(:headers => {'Accept'=>'application/json', 'Content-Type'=>'application/json', 'Host'=>'www.amara.org:443'}).
      to_return(:status => 200, :body => "", :headers => {})

    amara = Amara::Client.new
    response = amara.teams('test-team').projects.list(limit: 2)
  end

end
