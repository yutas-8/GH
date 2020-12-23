require 'rails_helper'

RSpec.describe Member, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  context "ユーザー登録" do
    before do
      @member = Member.new
      @member.first_name = "1"
      @member.last_name = "1"
      @member.email = "1@1"
      @member.encrypted_password = "111111"
      @member.save
    end
    it "作成された" do
      expect(@member).to be_valid
    end
  end
  
  context "バリデーションテスト" do
    before do
      @member = Member.new
      @member.first_name = ""
      @member.last_name = ""
      @member.email = ""
      @member.encrypted_password = ""
      @member.save
    end
    it "動作している" do
      expect(@member).not_to be_valid
    end
  end
end
