require 'httparty'

class Kele

  include HTTParty

  def initialize(email, password)
    credentials = {
      "email": email,
      "password": password
    }

    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: credentials)
    @auth_token = response[:auth_token]
  end

 end
