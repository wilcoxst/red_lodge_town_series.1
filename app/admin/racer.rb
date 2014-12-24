ActiveAdmin.register Racer do
  permit_params :name, :team_id, :discipline_id, :classification_id, :gender, :is_individual
  config.sort_order = "name_asc"

  # http://activeadmin.info/docs/5-forms.html
  # http://www.rubydoc.info/github/justinfrench/formtastic#Usage

  index do
    selectable_column

    column :id
    column :name
    column :gender
    column :discipline
    column :team
    column :classification

    actions
  end


  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :gender, :as => :select, :collection => %w(M F), :include_blank => false
      f.input :discipline_id, :as => :select, :collection => Discipline.all, :include_blank => false
      #f.input :is_individual
      f.input :team_id, :as => :select, :collection => Team.all
      f.input :classification_id, :as => :select, :collection => Classification.all, :include_blank => false
    end
    f.actions
  end

end
