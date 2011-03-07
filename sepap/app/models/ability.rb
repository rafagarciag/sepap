class Ability
    include CanCan::Ability
    
    def initialize(user)
        user ||= User.new #Usuario ETC
    
        if user.admin?
           can :manage, :all
        end
    end
    
end
