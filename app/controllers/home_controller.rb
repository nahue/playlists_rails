class HomeController < ApplicationController
  def index
    # Set page title for SEO
    @page_title = Current.user ? "Dashboard - Playlists Rails" : "Welcome - Playlists Rails"

    # For authenticated users, we could load recent playlists or activity
    if Current.user
      # @recent_playlists = Current.user.playlists.order(created_at: :desc).limit(5)
    end
  end
end
