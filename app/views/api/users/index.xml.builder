xml.instruct!
xml.users do
  @users.each do |user|
    xml.user do
      xml.id user.id
      xml.url api_user_url(user, format: :xml)
    end
  end
end
