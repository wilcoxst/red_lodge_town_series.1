ActiveAdmin.register TimeEntry do
  permit_params :timing, :run
  config.sort_order = "id_asc"

  index do
    selectable_column

    column :id
    column :racer
    column :week
    column :run1
    column :run2
    column :created_at
    column :updated_at

    actions
  end


  collection_action :import_csv, :method => :post do
    # Do some CSV importing work here...
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

end
