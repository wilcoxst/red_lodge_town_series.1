ActiveAdmin.register_page 'Timesheet' do

  page_action :get_csv, :method => :get do
  end

  page_action :ex, :method => :post do
    # do stuff here
    redirect_to admin_timeshet_path, :notice => 'Time entries saved'
  end

  # action_item do
  #   link_to 'Save Entries', admin_enter_times_ex_path, :method => :post
  # end

  content do
    link_to "Get Timesheet CSV", admin_timesheet_get_csv_path, :method => :get
  end



end