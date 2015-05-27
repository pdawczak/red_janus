json.extract! @user, :id, :email, :username, :title, :dob
json.firstNames @user.first_names
json.middleNames @user.middle_names
json.lastNames @user.last_names
