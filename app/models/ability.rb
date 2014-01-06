class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    else
      can :read, :all

      if user.role? :user
        can :create, Roof
        can :like, Roof
        can :dislike, Roof
        can :bookmark, Roof
        can :buy, Roof

        # Это автор крыши
        can :update, Roof do |roof|
          roof.try(:user_id) == user._id #|| user.role?(:moderator)
        end
        # Инструкции не существует или это ее автор
        can :instruction, Roof do |roof|
          !roof.instruction? || roof.try(:user_id) == user._id
        end

        can :create, Roof::Photo
        can :destroy, Roof::Photo do |photo|
          photo.try(:user_id) == user._id
        end
      end
    end

=begin
    if user.role?(:author)
      can :create, Article
      can :update, Article do |article|
        article.try(:user) == user
      end
    end
=end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
