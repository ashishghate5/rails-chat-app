class FriendsListService
  def initialize(user)
    @users = User.all_except(user)
  end

  def call
    @users
  end
end