ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span 'Red Lodge Town Series Admin Dashboard'
        small 'Click on the menu items above to organize teams, and enter times'
      end
    end

    columns do
      column do
        panel "Teams" do
          ul do
            Team.all.map do |team|
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

    column do
      panel "Individuals" do
        ul do
          Racer.where('team_id IS NULL').map do |racer|
            li link_to(racer.name, admin_racer_path(racer))
          end
        end
      end
    end
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
