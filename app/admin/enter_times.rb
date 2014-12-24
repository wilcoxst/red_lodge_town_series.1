ActiveAdmin.register_page "Enter Times" do

  page_action :ex, :method => :post do
    # do stuff here
    redirect_to admin_enter_times_path, :notice => "Time entries saved"
  end

  action_item do
    link_to "Save Entries", admin_enter_times_ex_path, :method => :post
  end

  content do
    week = Week.last
    para "Enter times for current week"
    link_to "Download CSV", admin_enter_times_get_csv_path
    #f.inputs 'Week' do
    #f.input :week, :as => :select, :collection => Week.all, :include_blank => false
    h1 "Week #{week.name}"
    #end
    Team.all.each do |team|
      #form do |f|
      h2 team.name
      team.racers.each do |racer|
        active_admin_form_for :time_entry do |f|
          f.inputs racer.name do
            columns do
              #para racer.name
              column do
                f.input :run1
              end
              column do
                f.input :run2
              end
              # column do
              #   f.submit
              # end
            end
          end
        end
      end
    end
    para "Hello"
    link_to "Do Stuff", admin_enter_times_ex_path, :method => :post
  end

  page_action :get_csv do
  end

end