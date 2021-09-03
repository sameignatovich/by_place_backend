json.extract! user, :id, :fullname, :username, :email, :admin, :email_confirmed, :created_at, :updated_at
json.avatar user.avatar.attached? ? polymorphic_url(user.avatar.variant(resize_to_limit: [300, 300])) : nil
