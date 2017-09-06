module Roadmap
attr_accessor :roadmap, :checkpoint

  def get_roadmap(id)
    response =  self.class.get("https://www.bloc.io/api/v1/roadmaps/#{id}", headers: { "authorization" => @auth_token })
    @roadmap = JSON.parse(response.body)
  end

  def get_checkpoint(id)
    response = self.class.get("https://www.bloc.io/api/v1/checkpoints/#{id}", headers: { "authorization" => @auth_token })
    @checkpoint = JSON.parse(response.body)
  end

end
