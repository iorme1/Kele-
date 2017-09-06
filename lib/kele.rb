require 'httparty'
require 'json'

class Kele
  attr_accessor :user_data, :auth_token 

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

 end
