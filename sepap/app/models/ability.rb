# -*- encoding : utf-8 -*-
class Ability
    include CanCan::Ability
    
    def initialize(user)
        user ||= User.new #Usuario ETC
    	
    	if user.id==nil
    		can :read, Problem
    	else
		    if user.admin?
		        can :manage, :all
		    end
		    if user.profesor?
		    	can :manage, Problem
		    	can :destroy, Problem
		    	can :manage, Group
		    	can :create, Attempt
		    	can :read, Attempt
		    	can :show_last, Attempt
		    end
		    if user.estudiante?
		    	can :create, Attempt
		    	can :read, Attempt
		    	can :read, Problem
		    	can :show_last, Attempt
		    end
		end
    end
end
