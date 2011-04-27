class Ability
    include CanCan::Ability
    
    def initialize(user)
        user ||= User.new #Usuario ETC
    
        if user.admin?
           can :manage, :all
        end
        if user.profesor?
        	can :manage, Problem
        	can :destroy, Problem
        	can :manage, Group
        	can :manage, Attempt
        end
        if user.estudiante?
        	can :create, Attempt
        	can :read, Problem
        	cannot :destroy, Problem
        	
        end
        
    end
    
end
