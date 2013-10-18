require "spec_helper"

describe AssetCategorizationMailer do
  describe "submitted_email" do
    let(:mail) { AssetCategorizationMailer.submitted_email }

    it "renders the headers" do
      mail.subject.should eq("Submitted email")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "arranged_email" do
    let(:mail) { AssetCategorizationMailer.arranged_email }

    it "renders the headers" do
      mail.subject.should eq("Arranged email")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "confirmed_email" do
    let(:mail) { AssetCategorizationMailer.confirmed_email }

    it "renders the headers" do
      mail.subject.should eq("Confirmed email")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "approved_email" do
    let(:mail) { AssetCategorizationMailer.approved_email }

    it "renders the headers" do
      mail.subject.should eq("Approved email")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
