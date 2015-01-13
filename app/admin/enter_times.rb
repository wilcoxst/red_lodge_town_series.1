ActiveAdmin.register_page "Enter Times" do

  page_action :upload_csv, :method => :post do
    begin
      TimeEntry.import_csv(params[:dump][:file])
      redirect_to admin_enter_times_path, :notice => 'CSV Imported Successfully'
    rescue ActiveRecord::RecordNotUnique
      redirect_to admin_enter_times_path, :alert => 'Duplicate Time Entries.  Have you already entered times for this week?  Create a new week to import more times, or go to Time Entries, filter on this week, select all and use the delete batch action.'
    end
  end

  # action_item do
  #   link_to "Download CSV", admin_racers_path( :format => :csv )
  # end

  content do

    ol do
      li h2 link_to "Download Time Entry CSV", admin_racers_path( :format => :csv )
      li h2 'Enter times'
      li h2 link_to "Create New Week", admin_weeks_path
      li h2 'Upload Time Entry CSV'
    end

    render 'admin/upload_csv'

#    form do |f|
#      f.select :week_id, :collection => Week.all, :include_blank => false
#      f.input :name
#      #f.actions
#    end

  end


end