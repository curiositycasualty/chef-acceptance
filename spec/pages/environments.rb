require 'spec_helper'

module Page
  class Environments < SitePrism::Page
    set_url '/organizations{/org}/environments{/env}{/tab}'

    element :create_link, 'a.create'
    element :name_text, '#create-environment-name'
    element :description_text, '#create-environment-desc'
    element :next_button, :xpath, '//button[@class="btn-next btn" and not(@disabled)]'
    element :default_attributes_text, '.defaultAttributes .attributes'
    element :override_attributes_text, '.overrideAttributes .attributes'
    element :create_button, '.btn.btn-primary'
    element :modal, 'modal'
    
    element :label_detail, '#object-pane .object-id'
    element :description_detail, '#object-pane .description label'

    elements :environment_grid, '#list-pane div.slick-cell.l0.r0'

    def create_environment(env = FactoryGirl.build(:environment))
      wait_for_create_link
      create_link.click
      wait_for_name_text
      name_text.set env.name
      description_text.set env.description
      next_button.click
      
      # temporary
      page.has_content?('You cannot add constraints since there are no cookbooks')
      #first('.breadcrumb .active').find(:xpath, "//span[text()='Constraints']")
      next_button.click

      wait_for_default_attributes_text
      default_attributes_text.set env.default_attributes
      next_button.click

      wait_for_override_attributes_text
      override_attributes_text.set env.override_attributes
      create_button.click

      wait_until_modal_invisible

      return env
    end

    def find_environment(env)
      wait_for_environment_grid
      environment_grid.find do |e|
        e.text == env.name
      end
    end

    def select_environment(env)
      e = find_environment env

      if e.nil?
        raise 'Environment not found, nothing to select' 
      else
        e.click
      end
    end

    def get_selected_details
      details = {}
      details[:name] = label_detail.text
      details[:description] = description_detail.text
      #details[:constraints] = [] not sure what this looks like yet
      return details
    end

    def get_selected_attributes
    end
  end
end
