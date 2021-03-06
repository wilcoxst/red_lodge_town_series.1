ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span 'Red Lodge Town Series Admin Dashboard'
        small 'Click on the menu items above to organize teams, and edit time entries'
        #span link_to 'Download Time Entry Spreadsheet', admin_racers_path( :format => :csv )
        span link_to 'Enter Times', admin_enter_times_path
      end
    end

    columns do
      column do
        panel "Teams" do
          ul do
            Team.all.map do |team|
              if not team.id == Team.get_individual_id
                li link_to(team.name, admin_team_path(team))
                ul do
                  team.racers.map do |racer|
                    li link_to(racer.name, admin_racer_path(racer))
                  end
                end
              end
            end
          end
        end
      end

      column do
        panel "Individuals" do
          ul do
            Racer.where('team_id = ?', Team.get_individual_id).map do |racer|
              li link_to(racer.name, admin_racer_path(racer))
            end
          end
        end
      end

      # column do
      #   panel "Weeks" do
      #     ul do
      #       Week.all_weeks_with_times.each do |week|
      #         li link_to(week.name, admin_week_path(week))
      #       end
      #     end
      #   end
      # end

    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
