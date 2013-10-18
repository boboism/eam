class AssetCategorizationMailer < ActionMailer::Base
  default from: 'eam@gacmotor.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.asset_categorization_mailer.submitted_email.subject
  #
  def submitted_email(asset_categorization_id)
    if (emails = User.joins{roles}.where{roles.name.in("finadmin")}.select{email}.map(&:email)) && !emails.empty? 
      @asset_categorization = AssetCategorization.where(id: asset_categorization_id).includes{ [submitted_by] }.first
      mail to: emails
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.asset_categorization_mailer.arranged_email.subject
  #
  def arranged_email(asset_categorization_id)
    if (emails = User.joins{roles}.where{roles.name.in("deptadmin")}.select{email}.map(&:email)) && !emails.empty? 
      @asset_categorization = AssetCategorization.where(id: asset_categorization_id).includes{ [submitted_by] }.first
      mail to: emails
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.asset_categorization_mailer.confirmed_email.subject
  #
  def confirmed_email(asset_categorization_id)
    if (emails = User.joins{roles}.where{roles.name.in("finadmin")}.select{email}.map(&:email)) && !emails.empty? 
      @asset_categorization = AssetCategorization.where(id: asset_categorization_id).includes{ [submitted_by] }.first
      mail to: emails
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.asset_categorization_mailer.approved_email.subject
  #
  def approved_email(asset_categorization_id)
    @asset_categorization = AssetCategorization.where(id: asset_categorization_id).includes{ [submitted_by] }.first
    mail to: @asset_categorization.submitted_by.try(:email)
  end
end
