module BandsHelper
  def get_owner(band)
    if Current.user.email_address == band.user.email_address
      "me"
    else
      band.user.email_address
    end
  end
end
