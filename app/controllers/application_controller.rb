class ApplicationController < ActionController::Base
    require './app/modules/tasklist_logic'
    include Tasklist_logic
end
