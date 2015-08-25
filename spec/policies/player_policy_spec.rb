describe PlayerPolicy do
  subject { PlayerPolicy }

  let (:current_player) { FactoryGirl.build_stubbed :player }
  let (:other_player) { FactoryGirl.build_stubbed :player }
  let (:admin) { FactoryGirl.build_stubbed :player, :admin }

  permissions :index? do
    it "denies access if not an admin" do
      expect(PlayerPolicy).not_to permit(current_player)
    end
    it "allows access for an admin" do
      expect(PlayerPolicy).to permit(admin)
    end
  end

  permissions :show? do
    it "prevents other players from seeing your profile" do
      expect(subject).not_to permit(current_player, other_player)
    end
    it "allows you to see your own profile" do
      expect(subject).to permit(current_player, current_player)
    end
    it "allows an admin to see any profile" do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it "prevents updates if not an admin" do
      expect(subject).not_to permit(current_player)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "prevents deleting yourself" do
      expect(subject).not_to permit(current_player, current_player)
    end
    it "allows an admin to delete any player" do
      expect(subject).to permit(admin, other_player)
    end
  end

end
