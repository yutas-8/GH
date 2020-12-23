require 'rails_helper'

RSpec.describe Member, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"←保留という意味(1つだけ残しておく)
  before do
    @member = build(:member)
  end

  describe "ユーザー登録について" do
    it "作成された" do
      expect(@member.valid?).to eq(true) #
    end
  end

  it "姓が空はNG" do
    @member.first_name = ""
    expect(@member.valid?).to eq(false)
    expect(@member.errors[:first_name]).to include("を入力してください") # エラー文が日本語文に変換してあるので中途半端になっている
  end

  it "名が空はNG" do
    @member.last_name = ""
    expect(@member.valid?).to eq(false)
    expect(@member.errors[:last_name]).to include("を入力してください")
  end

  it "emailが空はNG" do
    @member.email = ""
    expect(@member.valid?).to eq(false)
    expect(@member.errors[:email]).to include("を入力してください")
  end

  it "passwordが空はNG" do
    @member.encrypted_password = ""
    expect(@member.valid?).to eq(false)
    expect(@member.errors[:encrypted_password]).to include("を入力してください")
  end

  it "passwordは6文字以上で登録できる" do
    @member.encrypted_password = "11111"
    expect(@member.valid?).to eq(false)
    expect(@member.errors[:encrypted_password]).to include("は6文字以上で入力してください")
  end



end
