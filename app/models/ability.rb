class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.is? :admin
      can :manage, :all
    else
      can :destroy, Post do |post|
        post.author == user
      end

      can :destroy, Comment do |comment|
        comment.author == user
      end
      can %i[read create], :all
    end
  end
end
