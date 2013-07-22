class PermissionsController < ApplicationController

  load_and_authorize_resource

  include ComboTable
  helper_method :sort_column, :sort_direction
  combo_table :permission, :columns => [:name, :description, :ability], :actions => [:index], :hide_action => true

end
