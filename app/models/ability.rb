class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, :to => :modify
    user ||= User.new # guest user (not logged in)
    #can :manage, :all if user.has_role?(:admin)

    if user.has_any_role?(:admin,:finadmin,:acctadmin,:finmgr,:acctmgr)
      can :read, AssetCategorization 
    else
      can :read, AssetCategorization, :created_by_id => user.id 
    end
    can :create, AssetCategorization if user.has_any_role?(:admin,:costadmin)
    can [:modify, :submit], AssetCategorization, :created_by_id => user.id, :submitted => false
    can [:confirm, :index_confirmable], AssetCategorization, :submitted => true, :confirmed => false if user.has_any_role?(:admin,:deptadmin)
    can [:approve, :index_approvable], AssetCategorization, :submitted => true, :confirmed => true, :approved => false if user.has_any_role?(:admin,:finadmin)

    if user.has_any_role?(:admin,:finadmin,:acctadmin,:finmgr,:acctmgr)
      can :read, Asset
    end

    if user.has_any_role?(:admin,:deptadmin)
      can :create, AssetCostAdjustment
    end
    if user.has_any_role?(:admin,:finadmin,:acctadmin,:finmgr,:acctmgr)
      can :read, AssetCostAdjustment
    else
      can :read, AssetCostAdjustment, :created_by_id => user.id
    end

    if user.has_any_role?(:admin,:finadmin,:deptadmin)
      can :create, AssetTransfer
    end
    if user.has_any_role?(:admin,:finadmin,:deptadmin)
      can :read, AssetTransfer
    else
      can :read, AssetTransfer, :created_by_id => user.id
    end
    can [:modify, :submit], AssetTransfer, :created_by_id => user.id, :submitted => false
    if user.has_any_role?(:admin,:deptadmin)
      can :confirm, AssetTransfer, :submitted => true, :confirmed => false
    end
    if user.has_any_role?(:admin, :findadmin, :finmgr)
      can :approve, AssetTransfer, :confirmed => true, :approved => false
    end

    if user.has_any_role?(:admin,:costadmin)
      can :create, AssetInfoAdjustment
    end
    if user.has_any_role?(:admin,:finadmin,:acctadmin,:finmgr,:acctmgr,:deptadmin)
      can :read, AssetInfoAdjustment
    else
      can :read, AssetInfoAdjustment, :created_by_id => user.id
    end
    can [:modify, :submit], AssetInfoAdjustment, :created_by_id => user.id, :submitted => false 
    can [:confirm, :index_confirmable], AssetInfoAdjustment, :submitted => true, :confirmed => false if user.has_any_role?(:admin,:deptadmin)
    can [:approve, :index_approvable], AssetInfoAdjustment, :submitted => true, :confirmed => true, :approved => false if user.has_any_role?(:admin,:finadmin)

    if user.has_any_role?(:admin, :deptadmin)
      can :create, AccessoryAdjustment
    end
    if user.has_any_role?(:admin, :finadmin, :acctadmin)
      can :read, AccessoryAdjustment
    else 
      can :read, AccessoryAdjustment, :created_by_id => user.id
    end
    can [:modify, :submit], AccessoryAdjustment, :created_by_id => user.id, :submitted => false 
    can [:confirm, :index_confirmable], AccessoryAdjustment, :submitted => true, :confirmed => false if user.has_any_role?(:admin,:deptadmin)
    can [:approve, :index_approvable], AccessoryAdjustment, :submitted => true, :confirmed => true, :approved => false if user.has_any_role?(:admin,:finadmin)

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
