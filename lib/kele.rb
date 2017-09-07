require 'httparty'
require 'json'
require_relative 'roadmap'


class Kele
  attr_accessor :user_data, :auth_token, :availability, :messages, :email

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

  def get_messages
    response = self.class.get("https://www.bloc.io/api/v1/message_threads/", headers: { "authorization" => @auth_token } )
    @messages = JSON.parse(response.body)
  end

  def create_message(recipient_id, subject, stripped_text)
    message = {
      "recipient_id": recipient_id,
      "subject": subject,
      "stripped_text": stripped_text
    }
    response = self.class.post("https://www.bloc.io/api/v1/messages", body: message, headers: { "authorization" => @auth_token } )
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    submission = {
      "checkpoint_id": checkpoint_id,
      "enrollment_id": 30205,
      "assignment_branch": assignment_branch,
      "assignment_commit_link": assignment_commit_link,
      "comment": comment
    }
    response = self.class.post("https://www.bloc.io/api/v1/checkpoint_submissions", body: submission, headers: { "authorization" => @auth_token } )
  end

 end
