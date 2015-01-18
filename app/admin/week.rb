ActiveAdmin.register Week do
  permit_params :number
  config.sort_order = 'name_asc'

  controller do
    before_filter { @page_title = 'Weeks' }
  end

  permit_params :id, :name, :date

end
