ActiveAdmin.register TimeEntry do
  permit_params :timing, :run
  config.sort_order = "id_asc"

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  collection_action :import_csv, :method => :post do
    # Do some CSV importing work here...
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

end
