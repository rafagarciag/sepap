# -*- encoding : utf-8 -*-
class Ability
    include CanCan::Ability
    
    def initialize(user)
        user ||= User.new #Usuario ETC
    
        if user.admin?
            can :manage, :all
        elsif user.profesor?
        	can :manage, Problem
        	can :destroy, Problem
        	can :manage, Group
        	can :manage, Attempt
        elsif user.estudiante?
        	can :create, Attempt
        	can :read, Attempt
        	can :read, Problem
        else
        	can :read, Problem
        end
        
    end
    
end
