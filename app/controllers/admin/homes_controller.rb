class Admin::HomesController < ApplicationController

  before_action :authenticate_end_user!

  def top
  end

end
