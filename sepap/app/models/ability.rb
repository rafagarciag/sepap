class Ability
    include CanCan::Ability
    
    def initialize(user)
        can :read, :all
    end
    
end
