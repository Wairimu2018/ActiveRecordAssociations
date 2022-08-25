# belongs_to, has_one
# belongs to one instance of the other model
# uses singular term

# Class
class User
    has_one : profile
end

# Profile
class Profile
    belongs_to : user 
end
# Migration
class AddUserRefToProfile < ActiveRecord::Migration
    def change
        add_reference : profile, :user, index:true
    end
end

user.profile
profile.user

# belongs_to, has_many
# one-to-many connection with another model
# User

class User
    belongs_to :group, inverse_of: :member
end

# Group
class Group
    has_many :members, class_name: "User, inverse_of: :user"
end
# Migration
class AddGroupRefToUsers < ActiveRecord::Migration
    def changeadd_reference: user, :group,index:true
    end
end


user.group
group.members

# has_one:through
# relates two models through a third model. If a user has_one profile, and a profile has_one avatar, we can access the 
# user’s avatar directly without having to load the entire profile.

# User
class User
    has_one : profile
    has_one :avatar, through: :profile
end
#Profile
class Profile
    belongs_to: user
    has_one: avatar
end
#Avatar
class Avatar
    belongs_to: profile
end
#Migration
class AddAvatarRefToUsers < ActiveRecord: :Migration
    def change
        add_reference : avatar, :profile, index: true
        add_reference: profile, :user, index:true
    end
end

user.avatar

#has_many :through
# allows us to connect two models through a third model. i.e a user might have many uploaded avatars they can choose from that are associated
# to the user through the profile.

#User
class User
    has_many : avatars, through: :profile
end

#Profile
class Profile
    belongs_to: user
    has_many: avatars
end
#Avatar
class Avatar
    belongs_to: profile
end

#Migration
class AddAvatarsAndProfileToUsers <ActiveRecord ::Migration
    def change
        add_reference:profile, :user, index:true
        add_reference:avatar, :profile, index:true
    end
end

user.avatars

# You can as well create a new connecting model to represent the relationship 
class User
    has_many :memberships
    has_many :groups, through: :memberships
    has_many :groups, through: :memberships
end

class Membership
    belongs_to :user
    belongs_to :group
end

class Group
    has_many :memberships
end

# Migration

class CreateMemberships < ActiveRecord::Migration
    def change
        create_table :memberships, do |t|
            t.references :user_id, index: true
            t.references :group_id, index: true


            t.timestamps

        end
    end
end

#has_and_belongs_to_many
# use this when you want many-to-many relationship but you don’t actually need to interact with the relationship itself
# in this case, we don't create a separate clas to represent it.

#User
class User
    has_and_belongs_to_many : groups
end

#group

class Group
    has_and_belongs_to_many :groups
end
#Migration
class createUsersGroupsJoinTable < ActiveRecord::Migration
    def change
        create_table:user_groups, id :false do |t|
            t.integer :user_id, index:true
            t.integer :group_id, index:true
        end
    end
end

user.groups
group.user

# TO READ FURTHER
#Polymorphic
# With polymorphic associations, a model can belong to more than one other model, on a single association.


FOR THIS AND MORE, THIS LINK HAS GREAT CONTENT ABOUT THE SAME https://hackernoon.com/active-record-associations-in-rails-gm19w3ysu