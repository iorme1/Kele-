require 'httparty'
require 'json'
require_relative 'roadmap'


class Kele
  attr_accessor :user_data, :auth_token, :availability

  include Roadmap
  include HTTParty

  def initialize(email, password)
    credentials = {
      "email": email,
      "password": password
    }

    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: credentials)
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    @availability = JSON.parse(response.body)
  end

 end
