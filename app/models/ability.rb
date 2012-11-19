class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.blank?
      # not logged in
      cannot :manage, :all
      
    elsif user.has_role? :admin
      can :manage, :all
      
    elsif user.has_role? :account
			can :create, Refund
    	can :edit, Transaction
    	can :create, Transaction
    	can :update, Transaction
    	can :uncoverd_orders, Order
    	can :read, :all
    elsif user.has_role? :operator
			can :destroy, FundUsage
			can :reduce_cash, Transaction
    	can :_save_group, OrderGroup
    	can :_update_group, OrderGroup 
			can :make_done, OrderGroup
    	can :create, Order
    	can :update, Order
    	can :uncoverd_orders, Order
    	can :read, :all
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    
  end
 
   protected
    def basic_read_only
#      can :read,Topic
#      can :feed,Topic
#      can :node,Topic

#      can :read, Reply

#      can :read,  Page
#      can :recent, Page

#      can :read, Photo
#      can :read, Site
#      can :read, Section
#      can :read, Node
#      can :read, Comment
    end 
  
  
end
