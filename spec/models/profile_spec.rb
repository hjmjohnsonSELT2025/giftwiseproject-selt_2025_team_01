require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { User.create(email: "test@example.com", password: "password") }
  let(:profile) do
    Profile.new(
      user: user,
      name: "Alice",
      age: 25,
      occupation: "Engineer",
      hobbies: "Reading, coding",
      likes: "Coffee",
      dislikes: "Loud noises"
    )
  end

  describe "associations" do
    it "belongs to a user" do
      expect(profile.user).to eq(user)
    end
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(profile).to be_valid
    end

    it "validates age must be an integer greater than 0" do
      profile.age = -1
      expect(profile).not_to be_valid

      profile.age = 0
      expect(profile).not_to be_valid

      profile.age = 25
      expect(profile).to be_valid
    end

    it "allows blank optional fields" do
      profile.occupation = ""
      profile.hobbies = ""
      profile.likes = ""
      profile.dislikes = ""
      expect(profile).to be_valid
    end

    it "limits text fields to 500 characters" do
      long_text = "a" * 501
      profile.hobbies = long_text
      expect(profile).not_to be_valid
    end
  end
end

RSpec.describe Profile, type: :model do
  let(:user) { User.create(email: "test@example.com", password: "password") }

  describe "validations" do
    it "is valid with all blank fields except user_id" do
      profile = Profile.new(
        user: user,
        name: "",
        age: nil,
        occupation: "",
        hobbies: "",
        likes: "",
        dislikes: ""
      )

      expect(profile).to be_valid
    end

    it "is invalid without a user_id" do
      profile = Profile.new(name: "Test")

      expect(profile).not_to be_valid
      expect(profile.errors[:user]).to include("must exist")
    end

    it "allows valid numerical age" do
      profile = Profile.new(user: user, age: 25)
      expect(profile).to be_valid
    end

    it "rejects invalid ages" do
      profile = Profile.new(user: user, age: -5)
      expect(profile).not_to be_valid
      expect(profile.errors[:age]).to be_present
    end
  end

  describe "associations" do
    it "belongs to user" do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq(:belongs_to)
    end
  end
end