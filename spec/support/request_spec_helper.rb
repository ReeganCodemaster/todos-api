module RequestSpecHelper
  #parse JSON rsponse to hash
  def json
    JSON.parse(response.body)
  end
end