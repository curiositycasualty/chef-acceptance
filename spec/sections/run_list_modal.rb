require 'spec_helper'

module Modal
  class RunList < SitePrism::Section 
    elements :available_recipes, 'div.recipes.available div div.list-content ul li'
    elements :available_roles
    elements :current_run_list, 'div.current div div.list-content ui'

    def drag_available_recipe_to_run_list(name)
      item = find_available_recipe(name)
      puts "Dragging recipe #{item.text} to run list"
      item.drag_to('div.current div div.list-content ui')
    end

    def find_available_recipe(name)
      available_recipes.find do |recipe|
        recipe.text == name
      end
    end
  end
end
